package com.k3sh.common.model.validation;

import com.k3sh.common.model.UserCreateDto;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PasswordsMatchValidator implements ConstraintValidator<PasswordsMatch, UserCreateDto> {

    @Override
    public void initialize(PasswordsMatch constraintAnnotation) {
//        log.info("PasswordsMatch initialized");
    }

    @Override
    public boolean isValid(UserCreateDto dto, ConstraintValidatorContext context) {
        if (dto.getPassword() == null || dto.getConfirmPassword() == null) {
            return false;
        }
        return dto.getPassword().equals(dto.getConfirmPassword());
    }
}