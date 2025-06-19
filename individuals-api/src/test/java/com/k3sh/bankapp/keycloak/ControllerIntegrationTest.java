package com.k3sh.bankapp.keycloak;

import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.client.impl.KeycloakAdminTokenManager;
import com.k3sh.bankapp.dto.*;
import dasniko.testcontainers.keycloak.KeycloakContainer;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.reactive.server.WebTestClient;
import org.springframework.web.reactive.function.client.WebClient;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.IntStream;

@Testcontainers
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ControllerIntegrationTest {

    @Autowired
    private WebTestClient webTestClient;

    @Autowired
    private KeycloakAdminTokenManager keycloakAdminTokenManager;

    @Autowired
    private KeycloakProperties keycloakProperties;

    @Container
    private static final KeycloakContainer keycloak = new KeycloakContainer()
            .withRealmImportFile("keycloak/realm-export.json")
            .withAdminUsername("admin")
            .withAdminPassword("123");


    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        registry.add("keycloak.auth-server-url", keycloak::getAuthServerUrl);
        registry.add("keycloak.realm", () -> "individuals");
        registry.add("keycloak.client-id", () -> "individuals");
        registry.add("keycloak.client-secret", () -> "Sv7XYOdgXU27e5tkg84t8FoojF43XQPu");
        registry.add("keycloak.admin-user", () -> "admin");
        registry.add("keycloak.admin-password", () -> "123");
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
        String password = "super-secret";

        AuthRegistrationRequestDto request = new AuthRegistrationRequestDto(email, password, password);

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

    @Test
    void registration_withDuplicateEmail_shouldReturn409() {
        String email = "dup@baeldung.com";
        String password = "secret";

        AuthRegistrationRequestDto request = new AuthRegistrationRequestDto(email, password, password);

        webTestClient.post()
                .uri("/api/v1/auth/registration")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(request)
                .exchange()
                .expectStatus().isOk();

        webTestClient.post()
                .uri("/api/v1/auth/registration")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(request)
                .exchange()
                .expectStatus().isEqualTo(HttpStatus.CONFLICT);
    }

    @Test
    void me_shouldReturnCurrentUserInfo() {
        TokenDto token = getTokenDto();

        Assertions.assertNotNull(token);
        Assertions.assertNotNull(token.accessToken());

        webTestClient.get()
                .uri("/api/v1/auth/me")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + token.accessToken())
                .exchange()
                .expectStatus().isOk()
                .expectHeader().contentType(MediaType.APPLICATION_JSON)
                .expectBody(UserDto.class)
                .consumeWith(response -> {
                    UserDto user = response.getResponseBody();
                    Assertions.assertNotNull(user);
                    Assertions.assertEquals("roman@baeldung.com", user.email());
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
