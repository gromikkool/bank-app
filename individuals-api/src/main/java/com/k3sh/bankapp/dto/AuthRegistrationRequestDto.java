package com.k3sh.bankapp.dto;

import com.k3sh.bankapp.dto.validation.PasswordsMatch;

import jakarta.validation.constraints.NotBlank;

@PasswordsMatch
public record AuthRegistrationRequestDto(String email, @NotBlank String password, @NotBlank String confirmPassword) {
}
