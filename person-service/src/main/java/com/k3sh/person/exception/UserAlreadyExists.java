package com.k3sh.person.exception;

public class UserAlreadyExists extends RuntimeException {

     public UserAlreadyExists(String message) {
          super(message);
     }
}
