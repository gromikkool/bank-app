package com.k3sh.transactionservice.entity;

import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Table(name = "payment_type", schema = "transaction_service")
@Getter
@NoArgsConstructor
public enum PaymentType {
     DEPOSIT, WITHDRAWAL, TRANSFER
}
