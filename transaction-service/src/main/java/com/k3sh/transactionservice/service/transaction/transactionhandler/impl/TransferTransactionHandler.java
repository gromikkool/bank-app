package com.k3sh.transactionservice.service.transaction.transactionhandler.impl;

import com.k3sh.common.model.TransactionInitRequest;
import com.k3sh.common.model.TransactionInitResponse;
import com.k3sh.common.model.TransferInitRequest;
import com.k3sh.transactionservice.service.transaction.TransactionType;
import com.k3sh.transactionservice.service.transaction.transactionhandler.TransactionHandler;
import org.springframework.stereotype.Component;

@Component
public class TransferTransactionHandler implements TransactionHandler {

     @Override
     public TransactionInitResponse handle(TransactionInitRequest request) {
          TransferInitRequest transferInitRequest = (TransferInitRequest) request;

          System.out.println("Handling WITHDRAWAL for amount: " + transferInitRequest.getAmount());

          // ... ваша логика для инициализации снятия ...

          return new TransactionInitResponse(/* ... */);
     }

     @Override
     public TransactionType getHandledType() {
          return TransactionType.TRANSFER;
     }
}
