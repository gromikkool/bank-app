package com.k3sh.bankapp.client.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserCreationDto;
import com.k3sh.bankapp.dto.KeycloakUserDto;
import com.k3sh.bankapp.exception.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
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
     public Mono<KeycloakUserDto> me(String accessToken) {
          return webClient.get()
                  .uri(getUrl() + "userinfo")
                  .header(HttpHeaders.AUTHORIZATION, accessToken)
                  .retrieve()
                  .bodyToMono(KeycloakUserDto.class)
                  .onErrorResume(ex -> {
                       log.error("You are not logged in", ex);
                       return Mono.error(new UserNotFoundException("You are not logged in" + ex.getMessage()));
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
                          "firstName", requestDto.firstName(),
                          "lastName", requestDto.lastName(),
                          "attributes", Map.of("globalUuid", requestDto.globalUuid().toString()),
                          CREDENTIALS, List.of(Map.of(
                                  TYPE, PASSWORD,
                                  VALUE, requestDto.password(),
                                  TEMPORARY, false
                          ))
                  ))
                  .retrieve()
                  .onStatus(httpStatus -> httpStatus.value() == HttpStatus.CONFLICT.value(), response -> Mono.error(new UserAlreadyExists("User with this email already exists")))
                  .onStatus(
                          HttpStatusCode::is4xxClientError,
                          response -> response.bodyToMono(String.class)
                                  .map(body -> new CreateUserException("Client error creating user '" + requestDto.email() + "': " + body))
                  )
                  .onStatus(
                          HttpStatusCode::is5xxServerError,
                          response -> response.bodyToMono(String.class)
                                  .map(body -> new CreateUserException("Server error creating user '" + requestDto.email() + "': " + body))
                  )
                  .toBodilessEntity()
                  .map(entity -> {
                       log.info("User successfully created: {}", requestDto.email());
                       return new UserCreationDto(requestDto.email(), entity.getStatusCode());
                  });
     }

     private String getUrl() {
          return keycloakProperties.getKeycloakServerUrl() + "/realms/" + keycloakProperties.getRealm() + "/protocol/openid-connect/";
     }
}
