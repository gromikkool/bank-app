package com.k3sh.bankapp.exception;

public class PartialRollbackException extends RuntimeException {
     public PartialRollbackException(String message, Throwable cause) {
          super(message, cause);
     }
}