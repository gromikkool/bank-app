package com.k3sh.bankapp.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.Instant;

public record TokenDto(@JsonProperty("access_token") String accessToken,
                       @JsonProperty("refresh_token") String refreshToken, @JsonProperty("expires_in") Long expires,
                       @JsonProperty("token_type") String tokenType, Instant issuedAt,
                       Instant expiresAt) {
    public static TokenDto fromResponse(
            String accessToken,
            String refreshToken,
            long expiresIn,
            String tokenType
    ) {
        Instant now = Instant.now();
        return new TokenDto(
                accessToken,
                refreshToken,
                expiresIn,
                tokenType,
                now,
                now.plusSeconds(expiresIn)
        );
    }

    public boolean isExpired() {
        return Instant.now().isAfter(expiresAt.minusSeconds(30));
    }
}
