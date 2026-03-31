package com.k3sh.transactionservice.repository;

import com.k3sh.transactionservice.entity.WalletType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface WalletTypeRepository extends JpaRepository<WalletType, UUID> {
}
