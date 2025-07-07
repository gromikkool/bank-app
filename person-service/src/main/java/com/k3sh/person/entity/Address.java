package com.k3sh.person.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.UuidGenerator;
import org.hibernate.envers.Audited;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Audited
@Table(name = "addresses", schema = "person")
@Getter
@Setter
@NoArgsConstructor
public class Address {
     @Id
     @UuidGenerator
     @Column(columnDefinition = "uuid", updatable = false)
     private UUID id;

     @CreationTimestamp
     @Column(nullable = false, updatable = false)
     private LocalDateTime created;

     @UpdateTimestamp
     @Column(nullable = false)
     private LocalDateTime updated;

     @ManyToOne(fetch = FetchType.LAZY)
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

     @PrePersist
     public void prePersist() {
          LocalDateTime now = LocalDateTime.now();
          if (this.archived == null) this.archived = now;
     }
}
