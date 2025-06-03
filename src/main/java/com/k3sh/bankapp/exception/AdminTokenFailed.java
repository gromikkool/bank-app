package com.k3sh.bankapp.exception;

public class AdminTokenFailed extends RuntimeException {
    public AdminTokenFailed(String message) {
        super(message);
    }
}
