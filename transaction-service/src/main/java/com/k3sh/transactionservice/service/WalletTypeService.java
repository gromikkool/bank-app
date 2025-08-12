package com.k3sh.transactionservice.service;

import com.k3sh.common.model.WalletTypeResponse;

import java.util.UUID;

public interface WalletTypeService {

     WalletTypeResponse getWalletTypeByUUID(UUID uuid);
}
