package com.k3sh.bankapp.dto;

import java.time.Instant;

public record ErrorResponse(
        String message,
        String code,
        int status,
        String timestamp
) {
    public static ErrorResponse of(String message, String code, int status) {
        return new ErrorResponse(message, code, status, Instant.now().toString());
    }
}