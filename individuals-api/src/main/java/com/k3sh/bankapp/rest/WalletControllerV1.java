package com.k3sh.bankapp.rest;

import com.k3sh.bankapp.client.feign.WalletsApiFeignClient;
import com.k3sh.common.model.WalletTypeResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.k3sh.bankapp.client.feign.WalletTypesApiFeignClient;
import com.k3sh.common.model.CreateWalletRequest;
import com.k3sh.common.model.WalletResponse;

import lombok.RequiredArgsConstructor;

import java.util.UUID;

@RestController
@RequestMapping("api/v1/wallets")
@RequiredArgsConstructor
public class WalletControllerV1 {

    private final WalletTypesApiFeignClient walletTypesClient;
    private final WalletsApiFeignClient walletClient;

    @PostMapping
    ResponseEntity<WalletResponse> createWallet(@RequestBody CreateWalletRequest createWalletRequest) {
        return walletClient.walletsPost(createWalletRequest);
    }

    @GetMapping
    ResponseEntity<WalletTypeResponse> getWalletType(@RequestParam UUID uuid){
        return walletTypesClient.walletTypesWalletTypeUidGet(uuid);
    }

}
