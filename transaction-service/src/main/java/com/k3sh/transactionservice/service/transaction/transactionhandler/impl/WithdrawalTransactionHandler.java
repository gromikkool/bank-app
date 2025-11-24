package com.k3sh.transactionservice.service.transaction.transactionhandler.impl;

import com.k3sh.common.model.TransactionInitResponse;
import com.k3sh.common.model.TransactionsTypeInitPostRequest;
import com.k3sh.common.model.WithdrawalInitRequest;
import com.k3sh.transactionservice.service.transaction.TransactionType;
import com.k3sh.transactionservice.service.transaction.transactionhandler.TransactionHandler;
import org.springframework.stereotype.Component;

@Component
public class WithdrawalTransactionHandler implements TransactionHandler {

     @Override
     public TransactionInitResponse handle(TransactionsTypeInitPostRequest request) {
          WithdrawalInitRequest withdrawalRequest = (WithdrawalInitRequest) request;

          System.out.println("Handling WITHDRAWAL for amount: " + withdrawalRequest.getAmount());

          // ... ваша логика для инициализации снятия ...

          return new TransactionInitResponse(/* ... */);
     }

     @Override
     public TransactionType getHandledType() {
          return TransactionType.WITHDRAWAL;
     }
}
