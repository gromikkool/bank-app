package com.k3sh.bankapp.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public record AuthRegistrationResponseDto(@JsonProperty("access_token") String accessToken, @JsonProperty("refresh_token") String refreshToken,  @JsonProperty("expires_in") Long expires,  @JsonProperty("token_type") String tokenType) {

}
