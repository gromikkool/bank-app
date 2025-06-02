package com.k3sh.bankapp.client.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.dto.TokenDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.time.Instant;

@Component
@RequiredArgsConstructor
public class AdminTokenManager {

    private final KeycloakProperties keycloakProperties;
    private TokenDto adminToken;
    private final ObjectMapper objectMapper;

    public Mono<TokenDto> getAdminAccessToken() {

        if (adminToken != null && adminToken.accessToken() != null && Instant.now().isBefore(Instant.ofEpochMilli(adminToken.expires()))) {
            return Mono.just(adminToken);
        }

        MultiValueMap<String, String> form = new LinkedMultiValueMap<>();
        form.add("grant_type", "password");
        form.add("client_id", "admin-cli");
        form.add("username", keycloakProperties.getAdminUsername());
        form.add("password", keycloakProperties.getAdminPassword());

        return WebClient.builder().build()
                .post()
                .uri(keycloakProperties.getKeycloakServerUrl() + "/realms/" + keycloakProperties.getRealm() + "/protocol/openid-connect/token")
                .contentType(MediaType.APPLICATION_FORM_URLENCODED)
                .bodyValue(form)
                .retrieve()
                .bodyToMono(String.class)
                .map(json -> {
                    try {
                        return objectMapper.readValue(json, TokenDto.class);
                    } catch (JsonProcessingException e) {
                        throw new RuntimeException(e);
                    }
                }).doOnNext(tokenDto -> adminToken = tokenDto);
    }
}
