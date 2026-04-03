package com.k3sh.transactionservice.service.transaction;

import com.k3sh.common.model.TransactionInitRequest;
import com.k3sh.common.model.TransactionInitResponse;

public interface TransactionService {

     TransactionInitResponse initTransaction(String type, TransactionInitRequest request);
}
