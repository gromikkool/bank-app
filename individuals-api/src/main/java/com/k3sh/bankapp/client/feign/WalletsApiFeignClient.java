package com.k3sh.bankapp.client.feign;

import com.k3sh.common.api.WalletsApi;
import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(
        name = "wallets-api-client",
        url = "${feign.transaction-service-url}",
        path = "/wallets"
)
public interface WalletsApiFeignClient extends WalletsApi {
}
