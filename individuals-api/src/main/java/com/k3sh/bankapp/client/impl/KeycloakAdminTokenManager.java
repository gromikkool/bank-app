package com.k3sh.bankapp.client.impl;

import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.exception.AdminTokenFailed;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.concurrent.atomic.AtomicReference;

@Slf4j
@Component
@RequiredArgsConstructor
public class KeycloakAdminTokenManager {

    private final WebClient webClient;
    private final KeycloakProperties keycloakProperties;
    private final AtomicReference<TokenDto> adminToken = new AtomicReference<>();
    private final AtomicReference<Mono<TokenDto>> isRequestInProgress = new AtomicReference<>();

    public Mono<TokenDto> getAdminAccessToken() {
        TokenDto currentToken = adminToken.get();

        if (currentToken != null && currentToken.accessToken() != null && !currentToken.isExpired()) {
            return Mono.just(currentToken);
        }

        Mono<TokenDto> currentRequest = isRequestInProgress.get();

        if (currentRequest != null) {
            return currentRequest;
        }

        Mono<TokenDto> newRequest = createTokenRequest()
                .doOnNext(adminToken::set)
                .doFinally(signalType -> isRequestInProgress.set(null))
                .cache();

        if (isRequestInProgress.compareAndSet(null, newRequest)) {
            return newRequest;
        } else {
            return isRequestInProgress.get();
        }
    }


    private Mono<TokenDto> createTokenRequest() {
        MultiValueMap<String, String> form = new LinkedMultiValueMap<>();
        form.add("grant_type", "password");
        form.add("client_id", "admin-cli");
        form.add("username", keycloakProperties.getAdminUsername());
        form.add("password", keycloakProperties.getAdminPassword());

        return webClient
                .post()
                .uri(keycloakProperties.getKeycloakServerUrl() + "/realms/" + keycloakProperties.getRealm() + "/protocol/openid-connect/token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .bodyValue(form)
                .retrieve()
                .bodyToMono(TokenDto.class)
                .map(token -> TokenDto.fromResponse(token.accessToken(), token.refreshToken(), token.expires(), token.tokenType()))
                .onErrorResume(ex -> {
                    log.error("Failed to get admin access token", ex);
                    return Mono.error(new AdminTokenFailed("Failed to get admin access token: " + ex.getMessage()));
                });
    }
}
