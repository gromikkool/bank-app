package com.k3sh.bankapp.dto;

import jakarta.validation.constraints.NotBlank;

public record AuthRegistrationRequestDto(String email, @NotBlank String password, String confirmPassword) {
}
