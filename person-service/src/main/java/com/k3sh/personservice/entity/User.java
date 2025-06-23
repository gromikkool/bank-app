package com.k3sh.personservice.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.UuidGenerator;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "users", schema = "person")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class User {

     @Id
     @UuidGenerator
     @Column(columnDefinition = "uuid", updatable = false, nullable = false)
     private UUID id;

     @Column(name = "secret_key", length = 32)
     private String secretKey;

     @Column(length = 1024)
     private String email;

     @CreationTimestamp
     @Column(nullable = false, updatable = false)
     private LocalDateTime created;

     @UpdateTimestamp
     @Column(nullable = false)
     private LocalDateTime updated;

     @Column(name = "first_name", length = 32)
     private String firstName;

     @Column(name = "last_name", length = 32)
     private String lastName;

     private Boolean filled;

     @ManyToOne
     @JoinColumn(name = "address_id")
     private Address address;
}