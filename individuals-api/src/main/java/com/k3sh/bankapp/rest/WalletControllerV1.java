package com.k3sh.bankapp.rest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.k3sh.bankapp.client.feign.TransactionServiceFeignClient;
import com.k3sh.common.model.CreateWalletRequest;
import com.k3sh.common.model.WalletResponse;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("api/v1/wallets")
@RequiredArgsConstructor
public class WalletControllerV1 {

    private final TransactionServiceFeignClient client;

    @PostMapping
    ResponseEntity<WalletResponse> createWallet(@RequestBody CreateWalletRequest createWalletRequest) {
        return client.walletsPost(createWalletRequest);
    }

    @GetMapping
    ResponseEntity<WalletResponse> getWalletType(){}

}
