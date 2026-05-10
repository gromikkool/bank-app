package com.k3sh.person.exception;

public class CreateEntityFailed extends RuntimeException {

     public CreateEntityFailed(String message, Exception ex) {
          super(message, ex);
     }
}
