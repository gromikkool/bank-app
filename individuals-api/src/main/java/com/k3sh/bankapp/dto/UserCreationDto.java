package com.k3sh.bankapp.dto;

import org.springframework.http.HttpStatusCode;

public record UserCreationDto(
        String email,
        HttpStatusCode status) {
}
