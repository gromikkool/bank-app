package com.k3sh.bankapp.dto.validation;

import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordsMatchValidator implements ConstraintValidator<PasswordsMatch, AuthRegistrationRequestDto> {

    @Override
    public void initialize(PasswordsMatch constraintAnnotation) {
        log.info("PasswordsMatch initialized");
    }

    @Override
    public boolean isValid(AuthRegistrationRequestDto dto, ConstraintValidatorContext context) {
        if (dto.password() == null || dto.confirmPassword() == null) {
            return false;
        }
        return dto.password().equals(dto.confirmPassword());
    }
}