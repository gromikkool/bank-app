package com.k3sh.personservice.entity;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.UuidGenerator;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "individuals", schema = "person")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Individual {
     @Id
     @UuidGenerator
     @Column(columnDefinition = "uuid", updatable = false, nullable = false)
     private UUID id;

     @OneToOne
     @JoinColumn(name = "user_id", unique = true)
     private User user;

     @Column(name = "passport_number", length = 32)
     private String passportNumber;

     @Column(name = "phone_number", length = 32)
     private String phoneNumber;

     @Column(length = 32)
     private String email;

     @Column(name = "verified_at", nullable = false)
     private LocalDateTime verifiedAt;

     @Column(name = "archived_at", nullable = false)
     private LocalDateTime archivedAt;

     @Column(length = 32)
     private String status;
}



