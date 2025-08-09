package com.k3sh.bankapp.client.feign;

import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "transaction-service", url = "${feign.transaction-service-url}")
public interface TransactionServiceFeignClient {
}
