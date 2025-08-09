package com.k3sh.bankapp.client.feign;

import com.k3sh.common.api.IndividualsApi;
import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "person-service", url = "${feign.person-service-url}")
public interface PersonServiceFeignClient extends IndividualsApi //Person-service
{
}
