package com.k3sh.transactionservice.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.UuidGenerator;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;

@Entity
@Table(name = "wallet_types", schema = "transaction_service")
@Getter
@Setter
@NoArgsConstructor
public class WalletType {
     @Id
     @UuidGenerator
     @Column(columnDefinition = "uuid", updatable = false, nullable = false)
     private UUID uuid;

     @Column(columnDefinition = "created_at", nullable = false, updatable = false)
     @CreationTimestamp
     private LocalDateTime createdAt;

     @Column(columnDefinition = "modified_at", nullable = false)
     @UpdateTimestamp
     private LocalDateTime modifiedAt;

     @OneToMany(mappedBy = "walletTypeUuid")
     private Set<Wallet> wallets;

     @Column(length = 32)
     private String name;

     @Column(length = 3)
     private String currencyCode;

     @Column(length = 18)
     private String status;

     @Column(name = "archived_at")
     private LocalDateTime archivedAt;

     @Column(length = 15)
     private String userType;

     @Column
     private String creator;

     @Column
     private String modifier;
}
