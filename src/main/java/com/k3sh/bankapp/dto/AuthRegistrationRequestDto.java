package com.k3sh.bankapp.dto;

public record AuthRegistrationRequestDto(String email, String password, String confirmPassword) {
}
