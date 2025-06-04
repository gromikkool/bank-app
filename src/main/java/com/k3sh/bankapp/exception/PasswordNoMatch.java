package com.k3sh.bankapp.exception;

public class PasswordNoMatch extends RuntimeException {
    public PasswordNoMatch(String message) {
        super(message);
    }
}
