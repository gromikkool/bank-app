package com.k3sh.transactionservice.service.transaction;

import com.k3sh.common.model.TransactionInitResponse;
import com.k3sh.common.model.TransactionsTypeInitPostRequest;

public interface TransactionService {

     TransactionInitResponse initTransaction(String type, TransactionsTypeInitPostRequest request);
}
