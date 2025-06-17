package com.k3sh.bankapp.keycloak;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import dasniko.testcontainers.keycloak.KeycloakContainer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.reactive.server.WebTestClient;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import reactor.test.StepVerifier;

import java.time.Duration;
import java.util.concurrent.atomic.AtomicReference;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.http.HttpStatus.CREATED;

@Testcontainers
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class KeycloakContainersTest {


    @Autowired
    private ExAuthApiClient exAuthApiClient;

    @Autowired
    private WebTestClient webTestClient;

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
    void testContainerStart() {
        System.out.println("Keycloak running at: " + keycloak.getAuthServerUrl());
        assertThat(keycloak.isRunning()).isTrue();
    }

    @Test
    void login_shouldReturnAdminAccessToken() {
        TokenDto token = exAuthApiClient.login("admin", "123")
                .block(Duration.ofSeconds(5));
        assertThat(token).isNotNull();
        assertThat(token.accessToken()).isNotBlank();
    }

    @Test
    void registration_shouldCreateUserAndReturnValidToken() {
        // given
        String email = "test.user1@baeldung.com";
        String password = "super-secret";

        AuthRegistrationRequestDto request = new AuthRegistrationRequestDto(email, password, password);

        AtomicReference<TokenDto> token = new AtomicReference<>();

        WebTestClient client = webTestClient
                .mutate()
                .responseTimeout(Duration.ofSeconds(20)) // временно
                .build();

        // when
        client.post()
                .uri("/api/v1/auth/registration")
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(request)
                .exchange()
                .expectStatus().isCreated()
                .expectHeader().contentType(MediaType.APPLICATION_JSON)
                .expectBody(TokenDto.class)
                .consumeWith(response -> token.set(response.getResponseBody()));

        // then
        assertThat(token).isNotNull();
        assertThat(token.get().accessToken()).isNotBlank();
        assertThat(token.get().refreshToken()).isNotBlank();
    }

    @Test
    void registration_shouldCreateUserAndReturn200() {
        // given
        String email = "test.user1@baeldung.com";
        String password = "super-secret";

        AuthRegistrationRequestDto request = new AuthRegistrationRequestDto(email, password, password);

        // when

        StepVerifier.create(exAuthApiClient.registration(request)).assertNext(result -> {
            // then
            assertThat(result.email()).isEqualTo(email);
            assertThat(result.userId()).isNotNull();
            assertThat(result.status()).isEqualTo(CREATED);
        }).verifyComplete();
    }
}
