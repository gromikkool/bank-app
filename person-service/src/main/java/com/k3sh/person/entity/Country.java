package com.k3sh.person.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.envers.Audited;

import java.time.LocalDateTime;

@Entity
@Audited
@Table(name = "countries", schema = "person")
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Country {
     @Id
     @GeneratedValue(strategy = GenerationType.IDENTITY)
     private Integer id;

     @CreationTimestamp
     @Column(nullable = false, updatable = false)
     private LocalDateTime created;

     @UpdateTimestamp
     @Column(nullable = false)
     private LocalDateTime updated;

     @Column(length = 32)
     private String name;

     @Column(length = 2)
     private String alpha2;

     @Column(length = 3)
     private String alpha3;

     @Column(length = 32)
     private String status;
}
