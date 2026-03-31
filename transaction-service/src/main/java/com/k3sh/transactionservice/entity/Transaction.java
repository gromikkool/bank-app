package com.k3sh.transactionservice.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.UuidGenerator;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "transactions", schema = "transaction_service")
@Getter
@Setter
@NoArgsConstructor
public class Transaction {
     @Id
     @UuidGenerator
     @Column(columnDefinition = "uuid", updatable = false, nullable = false)
     private UUID uuid;

     @Column(columnDefinition = "created_at", nullable = false, updatable = false)
     private LocalDateTime createdAt;

     @Column(columnDefinition = "modified_at", nullable = false)
     private LocalDateTime modifiedAt;

     @Column(columnDefinition = "user_uuid", updatable = false, nullable = false)
     private UUID userUuid;

     @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
     @JoinColumn(name = "wallet_uuid", nullable = false)
     private Wallet wallet;

     @Column(name = "amount", columnDefinition = "DECIMAL(10,2)", nullable = false)
     @ColumnDefault("0.0")
     private BigDecimal amount;

     @Column(name = "type", nullable = false)
     @Enumerated(EnumType.STRING)
     private PaymentType paymentType;

     @Column(length = 32)
     private String status;

     @Column(length = 32)
     private String comment;

     @Column
     private BigDecimal fee;

     @Column(name = "target_wallet_uuid")
     private UUID targetWalletUuid;

     @Column(name = "payment_method_id")
     private BigInteger paymentMethodId;

     @Column(name = "failure_reason")
     private String failureReason;
}
