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
@Table(name = "addresses", schema = "person")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Address {
     @Id
     @UuidGenerator
     @Column(columnDefinition = "uuid", updatable = false, nullable = false)
     private UUID id;

     @CreationTimestamp
     @Column(nullable = false, updatable = false)
     private LocalDateTime created;

     @UpdateTimestamp
     @Column(nullable = false)
     private LocalDateTime updated;

     @ManyToOne
     @JoinColumn(name = "country_id")
     private Country country;

     @Column(name = "address", length = 128)
     private String streetAddress;

     @Column(name = "zip_code", length = 32)
     private String zipCode;

     @Column(nullable = false)
     private LocalDateTime archived;

     @Column(length = 32)
     private String city;

     @Column(length = 32)
     private String state;
}
