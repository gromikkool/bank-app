package com.k3sh.bankapp.client.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserCreationDto;
import com.k3sh.bankapp.dto.UserDto;
import com.k3sh.bankapp.exception.CreateUserException;
import com.k3sh.bankapp.exception.LoginFailedException;
import com.k3sh.bankapp.exception.RefreshTokenException;
import com.k3sh.bankapp.exception.UserAlreadyExists;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
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
    private static final String REFRESH_TOKEN = "refresh_token";
    private static final String GRANT_TYPE = "grant_type";
    private static final String SCOPE = "scope";
    private static final String OPENID_PROFILE_EMAIL = "openid profile email";

    private final KeycloakProperties keycloakProperties;
    private final KeycloakAdminTokenManager keycloakAdminTokenManager;
    private final WebClient webClient;

    @Override
    public Mono<TokenDto> login(String email, String password) {
        return webClient.post()
                .uri(getUrl() + "token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .body(BodyInserters.fromFormData(GRANT_TYPE, PASSWORD)
                        .with(CLIENT_ID, keycloakProperties.getClientId())
                        .with(CLIENT_SECRET, keycloakProperties.getClientSecret())
                        .with(USERNAME, email)
                        .with(PASSWORD, password)
                        .with(SCOPE, OPENID_PROFILE_EMAIL))
                .retrieve()
                .bodyToMono(TokenDto.class)
                .map(dto -> TokenDto.fromResponse(dto.accessToken(), dto.refreshToken(), dto.expires(), dto.tokenType()))
                .onErrorResume(ex -> {
                    log.error("Login failed", ex);
                    return Mono.error(new LoginFailedException("Login failed: " + ex.getMessage()));
                });
    }

    @Override
    public Mono<UserCreationDto> registration(AuthRegistrationRequestDto authRegistrationRequestDto) {
        return keycloakAdminTokenManager.getAdminAccessToken()
                .flatMap(token -> createUser(token.accessToken(), authRegistrationRequestDto));
    }

    @Override
    public Mono<UserDto> me(String accessToken) {
        return webClient.get()
                .uri(getUrl() + "userinfo")
                .header(HttpHeaders.AUTHORIZATION, accessToken)
                .retrieve()
                .bodyToMono(UserDto.class)
                .onErrorResume(ex -> {
                    log.error("Login failed", ex);
                    return Mono.error(new LoginFailedException("Login failed: " + ex.getMessage()));
                });
    }

    @Override
    public Mono<TokenDto> refreshToken(String refreshToken) {
        return webClient.post()
                .uri(getUrl() + "token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .body(BodyInserters.fromFormData(GRANT_TYPE, REFRESH_TOKEN)
                        .with(CLIENT_ID, keycloakProperties.getClientId())
                        .with(CLIENT_SECRET, keycloakProperties.getClientSecret())
                        .with(REFRESH_TOKEN, refreshToken)).retrieve().bodyToMono(TokenDto.class)
                .map(dto -> TokenDto.fromResponse(dto.accessToken(), dto.refreshToken(), dto.expires(), dto.tokenType()))
                .onErrorResume(ex -> {
                    log.error("Refresh token failed", ex);
                    return Mono.error(new RefreshTokenException("Refresh token failed: " + ex.getMessage()));
                });
    }

    private Mono<UserCreationDto> createUser(String token, AuthRegistrationRequestDto requestDto) {
        if (requestDto == null) return Mono.empty();
        return webClient.post()
                .uri(keycloakProperties.getKeycloakServerUrl() + "/admin/realms/" + keycloakProperties.getRealm() + "/users")
                .header(HttpHeaders.AUTHORIZATION, "Bearer " + token)
                .contentType(MediaType.APPLICATION_JSON)
                .bodyValue(Map.of(
                        USERNAME, requestDto.email(),
                        EMAIL, requestDto.email(),
                        ENABLED, true,
                        "emailVerified", true,
                        CREDENTIALS, List.of(Map.of(
                                TYPE, PASSWORD,
                                VALUE, requestDto.password(),
                                TEMPORARY, false
                        ))
                ))
                .retrieve()
                .onStatus(httpStatus -> httpStatus.value() == HttpStatus.CONFLICT.value(), response -> Mono.error(new UserAlreadyExists("User with this email already exists")))
                .toBodilessEntity()
                .map(entity -> {
                    HttpHeaders headers = entity.getHeaders();
                    String location = headers.getFirst(HttpHeaders.LOCATION);
                    String id = (location != null && location.contains("/users/"))
                            ? location.substring(location.lastIndexOf("/") + 1)
                            : "unknown";

                    log.info("User successfully created: {}", id);

                    return new UserCreationDto(id, requestDto.email(), entity.getStatusCode());
                })
                .onErrorResume(ex -> {
                    log.error("Failed to create user", ex);
                    return Mono.error(new CreateUserException("Failed to create user: " + ex.getMessage()));
                });
    }

    private String getUrl() {
        return keycloakProperties.getKeycloakServerUrl() + "/realms/" + keycloakProperties.getRealm() + "/protocol/openid-connect/";
    }
}
