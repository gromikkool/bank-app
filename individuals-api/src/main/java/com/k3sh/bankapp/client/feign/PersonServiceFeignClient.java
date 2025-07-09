package com.k3sh.bankapp.client.feign;

import com.k3sh.common.api.IndividualsApi;
import org.springframework.cloud.openfeign.FeignClient;

@FeignClient(name = "person-service", url = "${feign.url}")
public interface PersonServiceFeignClient extends IndividualsApi {
//
//     @GetMapping(value = "/individuals")
//     List<IndividualDto> getAllUsers();
//
//     @GetMapping(value = "/individuals/{id}")
//     IndividualDto getUserById(@PathVariable String id);
//
//     @GetMapping(value = "/individuals/email")
//     IndividualDto getUserByEmail(@RequestParam(value = "email") String email);
//
//     @PostMapping(value = "/individuals")
//     IndividualDto createUser(IndividualCreateDto dto);
//
//     @DeleteMapping(value = "/individuals/{id}")
//     IndividualDto deleteUser(@PathVariable UUID id);
}
