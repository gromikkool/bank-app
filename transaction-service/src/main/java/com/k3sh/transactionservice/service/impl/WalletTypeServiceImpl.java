package com.k3sh.transactionservice.service.impl;

import com.k3sh.common.model.WalletTypeResponse;
import com.k3sh.transactionservice.mapper.WalletTypeMapper;
import com.k3sh.transactionservice.repository.WalletTypeRepository;
import com.k3sh.transactionservice.service.WalletTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class WalletTypeServiceImpl implements WalletTypeService {
     private final WalletTypeRepository walletTypeRepository;
     private final WalletTypeMapper walletTypeMapper;

     @Override
     public WalletTypeResponse getWalletTypeByUUID(UUID uuid) {
          return walletTypeMapper.toDto(walletTypeRepository.findById(uuid).orElse(null));
     }
}
