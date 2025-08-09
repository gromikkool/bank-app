package com.k3sh.transactionservice.service;

import com.k3sh.common.model.CreateWalletRequest;
import com.k3sh.common.model.WalletResponse;

import java.util.UUID;

public interface WalletService {
     WalletResponse createWallet(CreateWalletRequest createWalletRequest);

     WalletResponse getWallet(String walletUuid);
}
