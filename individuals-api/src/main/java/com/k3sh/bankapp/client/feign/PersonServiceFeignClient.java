package com.k3sh.bankapp.client.feign;

import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@FeignClient(name = "person-service", url = "${feign.url}")
public interface PersonServiceFeignClient {

     @GetMapping(value = "/individuals")
     List<IndividualDto> getAllUsers();

     @GetMapping(value = "/individuals/{id}")
     IndividualDto getUserById(@PathVariable String id);

     @GetMapping(value = "/individuals/email")
     IndividualDto getUserByEmail(@RequestParam(value = "email") String email);

     @PostMapping(value = "/individuals")
     IndividualDto createUser(IndividualCreateDto dto);

     @DeleteMapping(value = "/individuals/{id}")
     IndividualDto deleteUser(@PathVariable UUID id);
}
