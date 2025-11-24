package com.k3sh.transactionservice.service.transaction.transactionhandler.impl;

import com.k3sh.common.model.DepositInitRequest;
import com.k3sh.common.model.TransactionInitResponse;
import com.k3sh.common.model.TransactionsTypeInitPostRequest;
import com.k3sh.transactionservice.service.transaction.TransactionType;
import com.k3sh.transactionservice.service.transaction.transactionhandler.TransactionHandler;
import org.springframework.stereotype.Component;

@Component
public class DepositTransactionHandler implements TransactionHandler {

     @Override
     public TransactionInitResponse handle(TransactionsTypeInitPostRequest request) {
          DepositInitRequest depositRequest = (DepositInitRequest) request;

          System.out.println("Handling DEPOSIT for amount: " + depositRequest.getAmount());

          // ... ваша логика для инициализации депозита ...

          return new TransactionInitResponse(/* ... */);
     }

     @Override
     public TransactionType getHandledType() {
          return TransactionType.DEPOSIT;
     }
}