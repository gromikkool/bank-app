package com.k3sh.transactionservice.service.transaction.transactionhandler;

import com.k3sh.common.model.TransactionInitRequest;
import com.k3sh.common.model.TransactionInitResponse;
import com.k3sh.transactionservice.service.transaction.TransactionType;

public interface TransactionHandler {

     TransactionInitResponse handle(TransactionInitRequest request);

     TransactionType getHandledType();
}
