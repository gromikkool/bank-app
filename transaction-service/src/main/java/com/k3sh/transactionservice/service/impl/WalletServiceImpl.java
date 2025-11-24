package com.k3sh.transactionservice.service.impl;

import com.k3sh.common.model.CreateWalletRequest;
import com.k3sh.common.model.WalletResponse;
import com.k3sh.transactionservice.entity.Wallet;
import com.k3sh.transactionservice.mapper.WalletMapper;
import com.k3sh.transactionservice.repository.WalletRepository;
import com.k3sh.transactionservice.service.WalletService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class WalletServiceImpl implements WalletService {

     private final WalletRepository walletRepository;
     private final WalletMapper walletMapper;

     @Override
     public WalletResponse createWallet(CreateWalletRequest createWalletRequest) {
          var entity = walletMapper.toEntity(createWalletRequest);
          return walletMapper.toDto(walletRepository.save(entity));
     }

     @Override
     public WalletResponse getWallet(String walletUuid) {
          UUID uuid = UUID.fromString(walletUuid);
          Wallet wallet = walletRepository.findById(uuid).orElse(null);
          if (wallet != null) {
               return walletMapper.toDto(wallet);
          }
          throw new EntityNotFoundException("Wallet with uuid " + walletUuid + " not found");
     }
}
