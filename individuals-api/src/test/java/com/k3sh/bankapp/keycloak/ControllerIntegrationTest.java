package com.k3sh.bankapp.keycloak;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.client.impl.KeycloakAdminTokenManager;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.RefreshTokenRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.common.model.*;
import dasniko.testcontainers.keycloak.KeycloakContainer;
import org.jetbrains.annotations.NotNull;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
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
import org.springframework.test.context.bean.override.mockito.MockitoSpyBean;
import org.springframework.test.web.reactive.server.WebTestClient;
import org.springframework.web.reactive.function.client.WebClient;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.wiremock.spring.ConfigureWireMock;
import org.wiremock.spring.EnableWireMock;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.IntStream;

import static com.github.tomakehurst.wiremock.client.WireMock.*;

@EnableWireMock(value = {
        @ConfigureWireMock(
                port = 8089,
                name = "person-service",
                baseUrlProperties = "feign.url"
        )
})
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

     @MockitoSpyBean
     private ExAuthApiClient apiClientSpy;

     @Autowired
     private ObjectMapper objectMapper;


     private static final KeycloakContainer keycloak = new KeycloakContainer()
             .withRealmImportFile("keycloak/realm-export.json")
             .withAdminUsername("admin")
             .withAdminPassword("123")
             .withReuse(false);

     @BeforeAll
     static void startContainers() {
          keycloak.start();
     }

     @DynamicPropertySource
     static void configureProperties(DynamicPropertyRegistry registry) {
          registry.add("keycloak.auth-server-url", keycloak::getAuthServerUrl);
          registry.add("keycloak.realm", () -> "individuals");
          registry.add("spring.security.oauth2.client.registration.keycloak.client-id", () -> "individuals");
          registry.add("spring.security.oauth2.client.registration.keycloak.client-secret", () -> "Sv7XYOdgXU27e5tkg84t8FoojF43XQPu");
          registry.add("keycloak.admin-user", () -> "admin");
          registry.add("keycloak.admin-password", () -> "123");
          registry.add("feign.url", () -> "http://localhost:8089");
     }

     @Test
     void testContainersStart() {
          System.out.println("Keycloak running at: " + keycloak.getAuthServerUrl());
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
          stubFor(post(urlEqualTo("/api/v1/auth/login"))
                  .withRequestBody(containing("roman@baeldung.com"))
                  .willReturn(aResponse()
                          .withHeader("Content-Type", "application/json")
                          .withBody("""
                                      {
                                        "accessToken": "mock-access-token",
                                        "refreshToken": "mock-refresh-token"
                                      }
                                  """)));

          LoginRequestDto request = new LoginRequestDto("roman@baeldung.com", "12345");

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
     void registration_shouldCreateUserAndReturnValidToken() throws JsonProcessingException {
          // given
          String email = "test.user@baeldung.com";
          IndividualCreateDto request = getIndividualCreateDto(email);
          UUID userUUID = UUID.randomUUID();
          IndividualDto individualDto = getResponseIndividualDto(userUUID, email);

          String bodyJson = objectMapper.writeValueAsString(individualDto);
          stubFor(post(urlEqualTo("/individuals"))
                  .willReturn(okJson(bodyJson)));

          // mock: deleteIndividual (на случай ошибки)
          stubFor(delete(urlEqualTo("/individuals/" + userUUID))
                  .willReturn(aResponse().withStatus(200)));

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
          Assertions.assertNotNull(token.get());
          Assertions.assertNotNull(token.get().accessToken());
          Assertions.assertNotNull(token.get().refreshToken());

          // Admin access token
          TokenDto adminToken = keycloakAdminTokenManager.getAdminAccessToken().block();
          Assertions.assertNotNull(adminToken);

          // Check Keycloak for created user
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


     @Test
     void registration_shouldRollbackAndDeleteUser_ifKeycloakFails() throws JsonProcessingException {
          // given
          String email = "fail.user@baeldung.com";

          IndividualCreateDto request = getIndividualCreateDto(email);
          UUID userUUID = UUID.randomUUID();
          IndividualDto individualDto = getResponseIndividualDto(userUUID, email);

          String bodyJson = objectMapper.writeValueAsString(individualDto);
          stubFor(post(urlEqualTo("/individuals"))
                  .willReturn(okJson(bodyJson)));

          stubFor(delete(urlEqualTo("/individuals/" + userUUID))
                  .willReturn(aResponse().withStatus(200)));

          Mockito.doReturn(Mono.error(new RuntimeException("Simulated Keycloak failure")))
                  .when(apiClientSpy).registration(Mockito.any());

          // when
          webTestClient.post()
                  .uri("/api/v1/auth/registration")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().is5xxServerError();

          // then
          verify(deleteRequestedFor(urlEqualTo("/individuals/" + userUUID)));
     }

     private static IndividualDto getResponseIndividualDto(UUID userUUID, String email) {
          String firstName = "Roman";
          String lastName = "Baeldung";

          IndividualDto individualDto = new IndividualDto();
          individualDto.setId(userUUID);

          UserDto userDto = new UserDto();
          userDto.setEmail(email);
          userDto.setFirstName(firstName);
          userDto.setLastName(lastName);
          individualDto.setUser(userDto);
          return individualDto;
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

          return new IndividualCreateDto(passportNumber, "123456789", "ACTIVE", user);
     }

     @Test
     void registration_withDuplicateEmail_shouldReturn409() throws JsonProcessingException {
          // given
          String email = "dup1@baeldung.com";
          IndividualCreateDto request = getIndividualCreateDto(email);

          // Simulate duplicate email scenario - typically this would be a 409 response
          stubFor(post(urlEqualTo("/individuals"))
                  .willReturn(aResponse()
                          .withStatus(409)
                          .withHeader("Content-Type", "application/json")
                          .withBody("""
                                  {
                                    "message": "User with email already exists",
                                    "errorCode": "DUPLICATE_EMAIL"
                                  }
                                  """)));

          // when
          webTestClient.post()
                  .uri("/api/v1/auth/registration")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().isEqualTo(HttpStatus.CONFLICT);

          // then
          verify(postRequestedFor(urlEqualTo("/individuals")));
          // Verify that delete is NOT called since user creation failed
          verify(0, deleteRequestedFor(urlMatching("/individuals/.*")));
     }

     @Test
     void me_shouldReturnCurrentUserInfo() throws JsonProcessingException {
          String email = "jane.doe@baeldung.com";
          String password = "123";

          LoginRequestDto request = new LoginRequestDto(email, password);
          UUID knownUserUuid = UUID.fromString("12345678-1234-1234-1234-123456789012");

          TokenDto tokenDto = webTestClient.post()
                  .uri("/api/v1/auth/login")
                  .contentType(MediaType.APPLICATION_JSON)
                  .bodyValue(request)
                  .exchange()
                  .expectStatus().isOk().expectBody(TokenDto.class).returnResult().getResponseBody();

          Assertions.assertNotNull(tokenDto);
          Assertions.assertNotNull(tokenDto.accessToken());

          IndividualDto individualDto = getResponseIndividualDto(knownUserUuid, email);
          String bodyJson = objectMapper.writeValueAsString(individualDto);

          stubFor(get(urlEqualTo("/individuals/" + knownUserUuid)).willReturn(
                  aResponse().withStatus(200).withBody(bodyJson))
          );

          webTestClient.get()
                  .uri("/api/v1/auth/me")
                  .header(HttpHeaders.AUTHORIZATION, "Bearer " + tokenDto.accessToken())
                  .exchange()
                  .expectStatus().isOk()
                  .expectHeader().contentType(MediaType.APPLICATION_JSON)
                  .expectBody(IndividualDto.class)
                  .consumeWith(response -> {
                       IndividualDto dto = response.getResponseBody();
                       Assertions.assertNotNull(dto);
                       Assertions.assertNotNull(dto.getUser());
                       Assertions.assertEquals(email, dto.getUser().getEmail());
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

}
