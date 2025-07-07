package com.k3sh.person.exception;

public class FailedToCreateEntity extends RuntimeException {

     public FailedToCreateEntity(String message, Exception ex) {
          super(message, ex);
     }
}
