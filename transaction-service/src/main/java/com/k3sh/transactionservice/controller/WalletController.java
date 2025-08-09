package com.k3sh.transactionservice.controller;

import com.k3sh.common.api.WalletsApi;
import com.k3sh.common.model.CreateWalletRequest;
import com.k3sh.common.model.WalletResponse;
import com.k3sh.transactionservice.service.WalletService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class WalletController implements WalletsApi {

     private final WalletService walletService;

     @Override
     public ResponseEntity<WalletResponse> walletsPost(CreateWalletRequest createWalletRequest) {
          return ResponseEntity.ok(walletService.createWallet(createWalletRequest));
     }

     @Override
     public ResponseEntity<WalletResponse> walletsWalletUidGet(String walletUid) {
          return ResponseEntity.ok(walletService.getWallet(walletUid));

     }
}
