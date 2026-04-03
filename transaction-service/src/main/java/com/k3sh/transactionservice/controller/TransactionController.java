package com.k3sh.transactionservice.controller;

import com.k3sh.common.api.TransactionsApi;
import com.k3sh.common.model.*;
import com.k3sh.transactionservice.service.transaction.TransactionService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class TransactionController implements TransactionsApi {

     private final TransactionService transactionService;

     @Override
     public ResponseEntity<TransactionInitResponse> transactionsTypeInitPost(@PathVariable String type, TransactionInitRequest request) {
          return ResponseEntity.ok(transactionService.initTransaction(type, request));
     }

     @Override
     public ResponseEntity<TransactionStatusResponse> transactionsTransactionIdStatusGet(String transactionId) {
          return null;
     }

     @Override
     public ResponseEntity<TransactionConfirmResponse> transactionsTypeConfirmPost(String type, TransactionsTypeConfirmPostRequest request) {
          return null;
     }
}
