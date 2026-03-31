package com.k3sh.transactionservice.service.transaction.transactionhandler;

import com.k3sh.transactionservice.service.transaction.TransactionType;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.function.Function;
import java.util.stream.Collectors;

@Component
public class TransactionHandlerFactory {

     private final Map<TransactionType, TransactionHandler> handlerMap;

     public TransactionHandlerFactory(List<TransactionHandler> handlers) {
          this.handlerMap = handlers.stream()
                  .collect(Collectors.toMap(TransactionHandler::getHandledType, Function.identity()));
     }

     public Optional<TransactionHandler> getHandler(TransactionType type) {
          return Optional.ofNullable(handlerMap.get(type));
     }
}