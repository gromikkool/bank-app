package com.k3sh.bankapp.keycloak;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.dto.TokenDto;
import dasniko.testcontainers.keycloak.KeycloakContainer;
import org.apache.http.client.utils.URIBuilder;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.json.JacksonJsonParser;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

import java.net.URI;
import java.time.Duration;
import java.util.Collections;

import static org.assertj.core.api.Assertions.assertThat;

@Testcontainers
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class KeycloakContainersTest {


    @Autowired
    private ExAuthApiClient exAuthApiClient;

    @Container
    private static final KeycloakContainer keycloak = new KeycloakContainer()
            .withRealmImportFile("keycloak/realm-export.json")
            .withAdminUsername("admin")
            .withAdminPassword("123");

    @Test
    void testContainerStart() {
        System.out.println("Keycloak running at: " + keycloak.getAuthServerUrl());
        final String token = getBearerToken();
        assertThat(keycloak.isRunning()).isTrue();
    }

    @Test
    void login_shouldReturnAccessToken() {
        TokenDto token = exAuthApiClient.login("admin", "123")
                .block(Duration.ofSeconds(5));
        assertThat(token).isNotNull();
        assertThat(token.accessToken()).isNotBlank();
    }



    protected String getBearerToken() {
        try {

            URI authorizationURI = new URIBuilder(keycloak.getAuthServerUrl() + "/realms/baeldung/protocol/openid-connect/token").build();
            WebClient webclient = WebClient.builder().build();
            MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
            formData.put("grant_type", Collections.singletonList("password"));
            formData.put("client_id", Collections.singletonList("baeldung-api"));
            formData.put("username", Collections.singletonList("jane.doe@baeldung.com"));
            formData.put("password", Collections.singletonList("123"));

            String result = webclient.post()
                    .uri(authorizationURI)
                    .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                    .body(BodyInserters.fromFormData(formData))
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();

            JacksonJsonParser jsonParser = new JacksonJsonParser();

            return "Bearer " + jsonParser.parseMap(result)
                    .get("access_token")
                    .toString();

        } catch (Exception e) {
//            log.error("Can't obtain an access token from Keycloak!", e);
        }
        return null;
    }
}
