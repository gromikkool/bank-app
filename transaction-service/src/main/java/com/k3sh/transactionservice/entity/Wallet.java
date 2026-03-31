package com.k3sh.transactionservice.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.annotations.UuidGenerator;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;

@Entity
@Table(name = "wallets", schema = "transaction_service")
@Getter
@Setter
@NoArgsConstructor
public class Wallet {
     @Id
     @UuidGenerator
     @Column(updatable = false, nullable = false)
     private UUID uuid;

     @Column(columnDefinition = "created_at", nullable = false, updatable = false)
     @CreationTimestamp
     private LocalDateTime createdAt;

     @Column(columnDefinition = "modified_at", nullable = false)
     @UpdateTimestamp
     private LocalDateTime modifiedAt;

     @Column(length = 32)
     private String name;

     @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
     @JoinColumn(name = "wallet_type_uuid", nullable = false)
     private WalletType walletTypeUuid;

     @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
     private Set<Transaction> transactions;

     @Column(columnDefinition = "user_uuid", updatable = false, nullable = false)
     private UUID userUuid;

     @Column(length = 30)
     private String status;

     @Column(name = "balance", columnDefinition = "DECIMAL(10,2)", nullable = false)
     @ColumnDefault("0.0")
     private BigDecimal balance;

     @Column(name = "archived_at")
     private LocalDateTime archivedAt;
}
