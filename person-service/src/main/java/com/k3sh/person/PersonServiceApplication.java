package com.k3sh.person;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class PersonServiceApplication {

     public static void main(String[] args) {
          SpringApplication.run(PersonServiceApplication.class, args);
     }

}
