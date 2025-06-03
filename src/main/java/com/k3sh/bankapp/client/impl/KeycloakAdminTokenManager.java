package com.k3sh.bankapp.client.impl;

import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.exception.AdminTokenFailed;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
public class KeycloakAdminTokenManager {

    private final WebClient webClient;
    private final KeycloakProperties keycloakProperties;
    private TokenDto adminToken;

    public Mono<TokenDto> getAdminAccessToken() {

        if (adminToken != null && adminToken.accessToken() != null && !adminToken.isExpired()) {
            return Mono.just(adminToken);
        }

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
                .doOnNext(tokenDto -> adminToken = tokenDto)
                .onErrorResume(ex -> Mono.error(new AdminTokenFailed("Failed to get admin access token: " + ex.getMessage())));
    }
}
