package com.k3sh.bankapp.exception;

import com.k3sh.bankapp.dto.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

     @ExceptionHandler(LoginFailedException.class)
     public ResponseEntity<ErrorResponse> handleLoginError(LoginFailedException ex) {
          return ResponseEntity
                  .status(HttpStatus.UNAUTHORIZED)
                  .body(ErrorResponse.of(
                          ex.getMessage(),
                          "AUTH_FAILED",
                          HttpStatus.UNAUTHORIZED.value()
                  ));
     }

     @ExceptionHandler(RefreshTokenException.class)
     public ResponseEntity<ErrorResponse> handleRefreshTokenError(RefreshTokenException ex) {
          return ResponseEntity
                  .status(HttpStatus.UNAUTHORIZED)
                  .body(ErrorResponse.of(
                          "Invalid or expired refresh token",
                          "REFRESH_TOKEN_FAILED",
                          HttpStatus.UNAUTHORIZED.value()
                  ));
     }

     @ExceptionHandler(CreateUserException.class)
     public ResponseEntity<ErrorResponse> handleCreateUserError(CreateUserException ex) {
          return ResponseEntity
                  .status(HttpStatus.BAD_REQUEST)
                  .body(ErrorResponse.of(
                          ex.getMessage(),
                          "CREATE_USER_FAILED",
                          HttpStatus.BAD_REQUEST.value()
                  ));
     }

     @ExceptionHandler(AdminTokenFailed.class)
     public ResponseEntity<ErrorResponse> handleAdminTokenError(AdminTokenFailed ex) {
          return ResponseEntity
                  .status(HttpStatus.UNAUTHORIZED)
                  .body(ErrorResponse.of(
                          ex.getMessage(),
                          "ADMIN_TOKEN_FAILED",
                          HttpStatus.UNAUTHORIZED.value()
                  ));
     }

     @ExceptionHandler(PasswordDoesNotMatchException.class)
     public ResponseEntity<ErrorResponse> handlePasswordNoMatch(PasswordDoesNotMatchException ex) {
          return ResponseEntity
                  .status(HttpStatus.BAD_REQUEST)
                  .body(ErrorResponse.of(
                          ex.getMessage(),
                          "PASSWORD_NO_MATCH",
                          HttpStatus.BAD_REQUEST.value()
                  ));
     }

     @ExceptionHandler(UserNotFoundException.class)
     @ResponseStatus(HttpStatus.NOT_FOUND)
     public ResponseEntity<ErrorResponse> handleUserNotFoundException(UserNotFoundException ex) {
          return ResponseEntity
                  .status(HttpStatus.NOT_FOUND)
                  .body(ErrorResponse.of(
                          "User not found",
                          "USER_NOT_FOUND",
                          HttpStatus.BAD_REQUEST.value()
                  ));
     }

     @ExceptionHandler(UserAlreadyExists.class)
     public ResponseEntity<ErrorResponse> handleUserAlreadyExists(UserAlreadyExists ex) {
          return ResponseEntity
                  .status(HttpStatus.CONFLICT)
                  .body(ErrorResponse.of(
                          ex.getMessage(),
                          "USER_ALREADY_EXISTS",
                          HttpStatus.CONFLICT.value()
                  ));
     }

     @ExceptionHandler(KeycloakRegistrationException.class)
     public ResponseEntity<ErrorResponse> handleKeycloakFailure(KeycloakRegistrationException ex) {
          return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
                  .body(ErrorResponse.of(ex.getMessage(), "Keycloak registration failed", HttpStatus.BAD_GATEWAY.value()));
     }

     @ExceptionHandler(PartialRollbackException.class)
     public ResponseEntity<ErrorResponse> handleRollbackFailure(PartialRollbackException ex) {
          return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                  .body(ErrorResponse.of(ex.getMessage(), "Partial rollback failed", HttpStatus.INTERNAL_SERVER_ERROR.value()));
     }

}
