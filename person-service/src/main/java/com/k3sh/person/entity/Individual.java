package com.k3sh.person.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.UuidGenerator;
import org.hibernate.envers.Audited;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Audited
@Table(name = "individuals", schema = "person")
@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@NamedEntityGraph(name = "individualGraph", attributeNodes = @NamedAttributeNode(value = "user", subgraph = "userGraph"), subgraphs = {
        @NamedSubgraph(name = "userGraph", attributeNodes = @NamedAttributeNode(value = "address", subgraph = "addressGraph")),
        @NamedSubgraph(name = "addressGraph", attributeNodes = @NamedAttributeNode(value = "country"))
})
public class Individual {
     @Id
     @UuidGenerator
     @Column(columnDefinition = "uuid", updatable = false, nullable = false)
     private UUID id;

     @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
     @JoinColumn(name = "user_id", unique = true)
     private User user;

     @Column(name = "passport_number", length = 32)
     private String passportNumber;

     @Column(name = "phone_number", length = 32)
     private String phoneNumber;

     @Column(name = "verified_at", nullable = false)
     private LocalDateTime verifiedAt;

     @Column(name = "archived_at", nullable = false)
     private LocalDateTime archivedAt;

     @Column(length = 32)
     private String status;

     @PrePersist
     public void prePersist() {
          LocalDateTime now = LocalDateTime.now();
          if (this.verifiedAt == null) this.verifiedAt = now;
          if (this.archivedAt == null) this.archivedAt = now;
     }
}



