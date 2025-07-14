package com.k3sh.bankapp.keycloak;

import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.client.impl.KeycloakAdminTokenManager;
import com.k3sh.bankapp.dto.*;
import com.k3sh.common.model.AddressCreateDto;
import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import com.k3sh.common.model.UserCreateDto;
import dasniko.testcontainers.keycloak.KeycloakContainer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.reactive.server.WebTestClient;
import org.springframework.web.reactive.function.client.WebClient;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.junit.jupiter.Testcontainers;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.IntStream;

@Testcontainers
@ActiveProfiles("test")
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ControllerIntegrationTest {

     private static final Logger log = LoggerFactory.getLogger(ControllerIntegrationTest.class);

     @Autowired
     private WebTestClient webTestClient;

     @Autowired
     private KeycloakAdminTokenManager keycloakAdminTokenManager;

     @Autowired
     private KeycloakProperties keycloakProperties;

     private static final Network network = Network.newNetwork();

     private static final KeycloakContainer keycloak = new KeycloakContainer()
             .withRealmImportFile("keycloak/realm-export.json")
             .withAdminUsername("admin")
             .withAdminPassword("123")
             .withReuse(false);

     private static final PostgreSQLContainer<?> personServicePostgre = new PostgreSQLContainer<>("postgres:15")
             .withDatabaseName("person")
             .withUsername("test")
             .withPassword("test")
             .withNetwork(network)
             .withNetworkAliases("postgres")
             .withReuse(false);

     private static final GenericContainer<?> personService = new GenericContainer<>("person-service:latest")
             .withExposedPorts(8080)
             .withNetwork(network)
             .waitingFor(Wait.forHttp("/actuator/health").forStatusCode(200))
             .withReuse(false);

     @BeforeAll
     static void startContainers() {
          keycloak.start();
          personServicePostgre.start();
          personService
                  .withEnv("APP_PORT", "8080")
                  .withEnv("POSTGRES_HOST", "postgres")
                  .withEnv("POSTGRES_PORT", String.valueOf(5432))
                  .withEnv("POSTGRES_DB", "person")
                  .withEnv("POSTGRES_USER", "test")
                  .withEnv("POSTGRES_PASSWORD", "test")
                  .withEnv("APP_DEBUG_PORT", "5006")
                  .withEnv("PROMETHEUS_PORT", "9090")
                  .withEnv("GRAFANA_PORT", "3001");
          personService.start();
     }

     @AfterEach
     void printLogs() {
          log.info("Person Service Logs:");
          log.info(personService.getLogs());
     }

     @DynamicPropertySource
     static void configureProperties(DynamicPropertyRegistry registry) {
          registry.add("keycloak.auth-server-url", keycloak::getAuthServerUrl);
          registry.add("keycloak.realm", () -> "individuals");
          registry.add("spring.security.oauth2.client.registration.keycloak.client-id", () -> "individuals");
          registry.add("spring.security.oauth2.client.registration.keycloak.client-secret", () -> "Sv7XYOdgXU27e5tkg84t8FoojF43XQPu");
          registry.add("keycloak.admin-user", () -> "admin");
          registry.add("keycloak.admin-password", () -> "123");
          registry.add("feign.url", () -> "http://" + personService.getHost() + ":" + personService.getFirstMappedPort());
     }

     @Test
     void testContainersStart() {
          System.out.println("Keycloak running at: " + keycloak.getAuthServerUrl());
          System.out.println("PostgreSQL running at: " + personServicePostgre.getJdbcUrl());
          System.out.println("Person Service running at: " + personService.getHost() + ":" + personService.getFirstMappedPort());
          Assertions.assertTrue(keycloak.isRunning());
     }

     @Test
     void getAdminAccessToken_shouldReturnSameTokenForConcurrentAccess() {

          int threadCount = 10;
          List<Mono<TokenDto>> calls = IntStream.range(0, threadCount)
                  .mapToObj(i -> keycloakAdminTokenManager.getAdminAccessToken())
                  .toList();

          List<TokenDto> results = Flux.merge(calls)
                  .collectList()
                  .block();

          // then
          Assertions.assertNotNull(results);
          Assertions.assertEquals(threadCount, results.size());
          String expectedAccessToken = results.getFirst().accessToken();
          results.forEach(token -> Assertions.assertEquals(expectedAccessToken, token.accessToken()));
     }


     @Test
     void login_shouldReturnToken() {
          String email = "roman@baeldung.com";
          String password = "12345";

          LoginRequestDto request = new LoginRequestDto(email, password);

          webTestClient.post()
                  .uri("/api/v1/auth/login")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().isOk()
                  .expectHeader().contentType(MediaType.APPLICATION_JSON)
                  .expectBody(TokenDto.class)
                  .consumeWith(response -> {
                       TokenDto token = response.getResponseBody();
                       Assertions.assertNotNull(token);
                       Assertions.assertNotNull(token.accessToken());
                       Assertions.assertNotNull(token.refreshToken());
                  });
     }

     @Test
     void registration_shouldCreateUserAndReturnValidToken() {
          // given
          String email = "test.user@baeldung.com";
          IndividualCreateDto request = getIndividualCreateDto(email);

          AtomicReference<TokenDto> token = new AtomicReference<>();

          // when
          webTestClient.post()
                  .uri("/api/v1/auth/registration")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().isOk()
                  .expectHeader().contentType(MediaType.APPLICATION_JSON)
                  .expectBody(TokenDto.class)
                  .consumeWith(response -> token.set(response.getResponseBody()));

          // then
          Assertions.assertNotNull(token);
          Assertions.assertNotNull(token.get().accessToken());
          Assertions.assertNotNull(token.get().refreshToken());

          TokenDto adminToken = keycloakAdminTokenManager.getAdminAccessToken().block();
          Assertions.assertNotNull(adminToken);

          Flux<Map<String, Object>> fluxUsers = WebClient.create()
                  .get()
                  .uri(keycloak.getAuthServerUrl() + "/admin/realms/" + keycloakProperties.getRealm() + "/users")
                  .header(HttpHeaders.AUTHORIZATION, "Bearer " + adminToken.accessToken())
                  .retrieve()
                  .bodyToFlux(new ParameterizedTypeReference<>() {
                  });

          StepVerifier.create(fluxUsers.collectList()).assertNext(users -> {
               boolean userFound = users.stream()
                       .anyMatch(user -> email.equalsIgnoreCase((String) user.get("email")));
               Assertions.assertTrue(userFound, "Registered user should exist in Keycloak");
          }).verifyComplete();
     }

     private static IndividualCreateDto getIndividualCreateDto(String email) {
          String password = "super-secret";
          String passportNumber = "12345";
          String firstName = "Roman";
          String lastName = "Baeldung";

          final AddressCreateDto addressDto = new AddressCreateDto();
          addressDto.setCountryAlpha2("PL");
          addressDto.setCity("Warsaw");

          final UserCreateDto user = new UserCreateDto(email, firstName, lastName, addressDto);
          user.setPassword(password);
          user.setConfirmPassword(password);

          IndividualCreateDto request = new IndividualCreateDto(passportNumber, "123456789", "ACTIVE", user);
          return request;
     }

     @Test
     void registration_withDuplicateEmail_shouldReturn409() {
          String email = "dup1@baeldung.com";

          IndividualCreateDto request = getIndividualCreateDto(email);

          webTestClient.post()
                  .uri("/api/v1/auth/registration")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().isEqualTo(HttpStatus.CONFLICT);
     }

     @Test
     void me_shouldReturnCurrentUserInfo() {

          String email = "test.user@baeldung.com";
          String password = "super-secret";

          LoginRequestDto request = new LoginRequestDto(email, password);

          TokenDto tokenDto = webTestClient.post()
                  .uri("/api/v1/auth/login")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().isOk().expectBody(TokenDto.class).returnResult().getResponseBody();

          Assertions.assertNotNull(tokenDto);
          Assertions.assertNotNull(tokenDto.accessToken());

          webTestClient.get()
                  .uri("/api/v1/auth/me")
                  .header(HttpHeaders.AUTHORIZATION, "Bearer " + tokenDto.accessToken())
                  .exchange()
                  .expectStatus().isOk()
                  .expectHeader().contentType(MediaType.APPLICATION_JSON)
                  .expectBody(IndividualDto.class)
                  .consumeWith(response -> {
                       IndividualDto individualDto = response.getResponseBody();
                       Assertions.assertNotNull(individualDto);
                       Assertions.assertNotNull(individualDto.getUser());
                       Assertions.assertEquals(email, individualDto.getUser().getEmail());
                  });
     }

     @Test
     void me_withNotValidAuthHeader_shouldReturnUnauthorized() {
          webTestClient.get()
                  .uri("/api/v1/auth/me")
                  .header(HttpHeaders.AUTHORIZATION, "Bearer " + "some_invalid_token")
                  .exchange()
                  .expectStatus()
                  .isNotFound()
                  .expectBody()
                  .jsonPath("$.message")
                  .isEqualTo("User not found");
     }

     @Test
     void me_withoutAuthHeader_shouldReturnUnauthorized() {
          webTestClient.get()
                  .uri("/api/v1/auth/me")
                  .exchange()
                  .expectStatus()
                  .isNotFound()
                  .expectBody()
                  .jsonPath("$.message")
                  .isEqualTo("User not found");
     }

     @Test
     void login_callWithInvalidValues_shouldThrowLoginFailedException() {

          webTestClient.post().uri("/api/v1/auth/login")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(new LoginRequestDto("invalid_email", "invalid_password"))
                  .exchange().expectStatus().isUnauthorized();
     }

     private TokenDto getTokenDto() {
          LoginRequestDto loginRequest = new LoginRequestDto("roman@baeldung.com", "12345");

          return webTestClient.post()
                  .uri("/api/v1/auth/login")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(loginRequest)
                  .exchange()
                  .expectStatus().isOk()
                  .expectBody(TokenDto.class)
                  .returnResult()
                  .getResponseBody();
     }

     @Test
     void refreshToken_shouldReturnNewAccessAndRefreshTokens() {
          TokenDto initialToken = getTokenDto();

          Assertions.assertNotNull(initialToken);
          Assertions.assertNotNull(initialToken.refreshToken());

          RefreshTokenRequestDto refreshRequest = new RefreshTokenRequestDto(initialToken.refreshToken());

          webTestClient.post()
                  .uri("/api/v1/auth/refresh-token")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(refreshRequest)
                  .exchange()
                  .expectStatus().isOk()
                  .expectHeader().contentType(MediaType.APPLICATION_JSON)
                  .expectBody(TokenDto.class)
                  .consumeWith(response -> {
                       TokenDto refreshed = response.getResponseBody();
                       Assertions.assertNotNull(refreshed);
                       Assertions.assertNotNull(refreshed.accessToken());
                       Assertions.assertNotNull(refreshed.refreshToken());

                       Assertions.assertNotEquals(refreshed.accessToken(), initialToken.accessToken());
                  });
     }

     @Test
     void refreshToken_withInvalidRefreshToken_shouldReturnError() {
          String invalidRefreshToken = "invalid-token";

          webTestClient.post()
                  .uri("/api/v1/auth/refresh-token")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(new RefreshTokenRequestDto(invalidRefreshToken))
                  .exchange()
                  .expectStatus().is4xxClientError()
                  .expectBody();
     }

     @Test
     void registration_shouldRollback_whenKeycloakUnavailable_andUserShouldBeDeleted() {
          String email = "rollback-api@example.com";
          IndividualCreateDto request = getIndividualCreateDto(email);

          keycloak.stop();
          log.warn("Keycloak OFF — simulate failure");

          // Act
          webTestClient.post()
                  .uri("/api/v1/auth/registration")
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().isEqualTo(HttpStatus.BAD_GATEWAY);

          webTestClient.get()
                  .uri(uriBuilder -> uriBuilder
                          .host(personService.getHost())
                          .port(personService.getFirstMappedPort())
                          .path("/individuals/email")
                          .queryParam("email", email)
                          .build())
                  .exchange()
                  .expectStatus().isNotFound();
     }
}
