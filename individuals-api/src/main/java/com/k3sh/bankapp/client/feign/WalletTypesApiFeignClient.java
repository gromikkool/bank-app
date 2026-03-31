package com.k3sh.bankapp.client.feign;

import com.k3sh.common.api.WalletTypesApi;
import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "transaction-service", url = "${feign.transaction-service-url}")
public interface WalletTypesApiFeignClient extends WalletTypesApi {
}
