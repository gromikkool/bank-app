package com.k3sh.bankapp.dto;

import com.k3sh.bankapp.dto.validation.PasswordsMatch;

import jakarta.validation.constraints.NotBlank;

import java.util.UUID;

@PasswordsMatch
public record AuthRegistrationRequestDto(@NotBlank UUID globalUuid, @NotBlank String email, @NotBlank String password, @NotBlank String confirmPassword,
                                         String firstName, String lastName) {
}
