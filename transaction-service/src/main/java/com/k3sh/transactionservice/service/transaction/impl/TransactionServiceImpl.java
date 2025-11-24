package com.k3sh.transactionservice.service.transaction.impl;

import com.k3sh.common.model.TransactionInitResponse;
import com.k3sh.common.model.TransactionsTypeInitPostRequest;
import com.k3sh.transactionservice.service.transaction.TransactionService;
import com.k3sh.transactionservice.service.transaction.TransactionType;
import com.k3sh.transactionservice.service.transaction.transactionhandler.TransactionHandler;
import com.k3sh.transactionservice.service.transaction.transactionhandler.TransactionHandlerFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TransactionServiceImpl implements TransactionService {

     private final TransactionHandlerFactory transactionHandlerFactory;

     @Override
     public TransactionInitResponse initTransaction(String type, TransactionsTypeInitPostRequest request) {
          Optional<TransactionHandler> handler = transactionHandlerFactory.getHandler(TransactionType.valueOf(type));
          return handler.map(transactionHandler -> transactionHandler.handle(request))
                  .orElseThrow(() -> new IllegalArgumentException("Unknown transaction type: " + type));
     }
}
