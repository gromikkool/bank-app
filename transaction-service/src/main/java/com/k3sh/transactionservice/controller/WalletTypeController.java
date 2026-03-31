package com.k3sh.transactionservice.controller;

import com.k3sh.common.api.WalletTypesApi;
import com.k3sh.common.model.CreateWalletTypeRequest;
import com.k3sh.common.model.WalletTypeResponse;
import com.k3sh.transactionservice.service.WalletTypeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class WalletTypeController implements WalletTypesApi {

     private final WalletTypeService walletTypesService;
     @Override
     public ResponseEntity<WalletTypeResponse> walletTypesPost(CreateWalletTypeRequest createWalletTypeRequest) {
          return null;
     }

     @Override
     public ResponseEntity<WalletTypeResponse> walletTypesWalletTypeUidGet(UUID walletTypeUid) {
          return ResponseEntity.ok(walletTypesService.getWalletTypeByUUID(walletTypeUid));
     }
}
