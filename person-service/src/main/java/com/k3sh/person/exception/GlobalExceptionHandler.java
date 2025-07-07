package com.k3sh.person.exception;

import com.k3sh.common.model.ErrorResponse;
import jakarta.persistence.EntityNotFoundException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

     @ExceptionHandler(EntityNotFoundException.class)
     public ResponseEntity<ErrorResponse> handleUserNotFoundException(EntityNotFoundException ex) {
          log.error("Entity not found: {}", ex.getMessage(), ex);
          ErrorResponse errorResponse = new ErrorResponse();
          errorResponse.setMessage(ex.getMessage());
          errorResponse.setCode("USER_NOT_FOUND");
          errorResponse.status(HttpStatus.NOT_FOUND.value());
          return ResponseEntity
                  .status(HttpStatus.NOT_FOUND)
                  .body(errorResponse);
     }

     @ExceptionHandler(UserAlreadyExists.class)
     public ResponseEntity<ErrorResponse> handleUserAlreadyExists(UserAlreadyExists ex) {
          ErrorResponse errorResponse = new ErrorResponse();
          errorResponse.setMessage(ex.getMessage());
          errorResponse.setCode("USER_ALREADY_EXISTS");
          errorResponse.status(HttpStatus.CONFLICT.value());
          return ResponseEntity
                  .status(HttpStatus.CONFLICT)
                  .body(errorResponse);

     }


     @ExceptionHandler(DataIntegrityViolationException.class)
     public ResponseEntity<ErrorResponse> handleDataIntegrityViolation(DataIntegrityViolationException ex) {
          ErrorResponse errorResponse = new ErrorResponse();
          errorResponse.setMessage(ex.getMessage());
          errorResponse.setCode("USER_ALREADY_EXISTS");
          errorResponse.status(HttpStatus.CONFLICT.value());
          return ResponseEntity
                  .status(HttpStatus.CONFLICT)
                  .body(errorResponse);

     }
}