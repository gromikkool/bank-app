package com.k3sh.bankapp.client.feign;

import org.springframework.cloud.openfeign.FeignClient;

import com.k3sh.common.api.WalletsApi;

@FeignClient(name = "transaction-service", url = "${feign.transaction-service-url}")
public interface TransactionServiceFeignClient extends WalletsApi {
}
