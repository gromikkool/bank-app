package com.k3sh.bankapp.client.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.exception.CreateUserException;
import com.k3sh.bankapp.exception.LoginFailedException;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class KeycloakAuthApiClientImpl implements ExAuthApiClient {

    private static final String PASSWORD = "password";
    private static final String CLIENT_ID = "client_id";
    private static final String CLIENT_SECRET = "client_secret";
    private static final String USERNAME = "username";
    private static final String EMAIL = "email";
    private static final String ENABLED = "enabled";
    private static final String CREDENTIALS = "credentials";
    private static final String TYPE = "type";
    private static final String VALUE = "value";
    private static final String TEMPORARY = "temporary";

    private final ObjectMapper objectMapper;
    private final KeycloakProperties keycloakProperties;
    private final AdminTokenManager adminTokenManager;

    @Override
    public Mono<TokenDto> login(String email, String password) {
        return WebClient.builder().build().post()
                .uri(keycloakProperties.getKeycloakServerUrl() + "/realms/" + keycloakProperties.getRealm() + "/protocol/openid-connect/token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .body(BodyInserters.fromFormData("grant_type", PASSWORD)
                        .with(CLIENT_ID, keycloakProperties.getClientId())
                        .with(CLIENT_SECRET, keycloakProperties.getClientSecret())
                        .with(USERNAME, email)
                        .with(PASSWORD, password))
                .retrieve()
                .onStatus(HttpStatusCode::isError, resp -> resp.bodyToMono(String.class)
                        .flatMap(error -> Mono.error(new LoginFailedException("Login failed: " + error))))
                .bodyToMono(TokenDto.class);
    }

    @Override
    public Mono<TokenDto> register(AuthRegistrationRequestDto authRegistrationRequestDto) {
        return adminTokenManager.getAdminAccessToken().
                flatMap(token -> createUser(token.accessToken(), authRegistrationRequestDto)).
                then(login(authRegistrationRequestDto.email(), authRegistrationRequestDto.password()));
    }

    private Mono<Void> createUser(String token, AuthRegistrationRequestDto requestDto) {
        if (requestDto == null) return Mono.empty();
        return WebClient.builder().build().post()
                .uri(keycloakProperties.getKeycloakServerUrl() + "/admin/realms/" + keycloakProperties.getRealm() + "/users")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(Map.of(
                        USERNAME, requestDto.email(),
                        EMAIL, requestDto.email(),
                        ENABLED, true,
                        CREDENTIALS, List.of(Map.of(
                                TYPE, PASSWORD,
                                VALUE, requestDto.password(),
                                TEMPORARY, false
                        ))
                ))
                .retrieve()
                .onStatus(HttpStatusCode::is4xxClientError, clientResponse ->
                        clientResponse.bodyToMono(String.class)
                                .flatMap(errorBody -> {
                                    String message = "Failed to create user: " + errorBody;
                                    return Mono.error(new CreateUserException(message));
                                })
                )
                .toBodilessEntity().then();
    }
}
