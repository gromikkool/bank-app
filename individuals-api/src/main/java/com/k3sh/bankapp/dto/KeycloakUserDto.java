package com.k3sh.bankapp.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public record KeycloakUserDto(String name, String email, @JsonProperty("given_name") String givenName,
                              @JsonProperty("family_name") String familyName, String preferred_username) {
}
