package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.client.feign.PersonServiceFeignClient;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.KeycloakUserDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.exception.CreateUserException;
import com.k3sh.bankapp.exception.UserAlreadyExists;
import com.k3sh.bankapp.service.TokenService;
import com.k3sh.bankapp.service.UserService;
import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import com.k3sh.common.model.UserDto;
import feign.FeignException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import reactor.core.scheduler.Schedulers;
import reactor.util.retry.Retry;

import java.time.Duration;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

     private final ExAuthApiClient apiClient;
     private final TokenService tokenService;
     private final PersonServiceFeignClient personServiceFeignClient;

     @Override //todo: confirm pass
     public Mono<TokenDto> registration(IndividualCreateDto requestDto) {
          return Mono.fromCallable(() -> personServiceFeignClient.createUser(requestDto))
                  .subscribeOn(Schedulers.boundedElastic())
                  .onErrorResume(FeignException.class, ex -> {
                       if (ex.status() == 409) {
                            return Mono.error(new UserAlreadyExists("User with this email already exists"));
                       }
                       log.error("Person-service is not available", ex);
                       return Mono.error(new CreateUserException("User creation failed, person-service is not available"));
                  })
                  .flatMap(individual -> apiClient.registration(new AuthRegistrationRequestDto(
                                          requestDto.getUser().getEmail(),
                                          requestDto.getUser().getPassword(),
                                          requestDto.getUser().getConfirmPassword(),
                                          requestDto.getUser().getFirstName(),
                                          requestDto.getUser().getLastName()
                                  ))
                          //todo: rollback rename user
                                  .onErrorResume(ex -> {
                                               log.error("Delete user with id {} from person-service", individual.getId());
                                               return Mono.fromCallable(() -> personServiceFeignClient.deleteUser(individual.getId()))
                                                       .subscribeOn(Schedulers.boundedElastic())
                                                       .retryWhen(Retry.backoff(3, Duration.ofSeconds(1)))
                                                       .onErrorResume(deleteEx -> {
                                                            log.error("Failed to delete user with id {} after registration failed", individual.getId(), deleteEx);
                                                            return Mono.error(new IllegalStateException("User partially created and could not be rolled back", deleteEx));
                                                       })
                                                       .then(Mono.error(ex));
                                          }
                                  )
                                  .then(tokenService.login(new LoginRequestDto(requestDto.getUser().getEmail(), requestDto.getUser().getPassword())))
                  );
     }

     @Override
     public Mono<IndividualDto> me(String accessToken) {
          return apiClient.me(accessToken).
                  flatMap(keycloakUser ->
                          Mono.fromCallable(() -> personServiceFeignClient.getUserByEmail(keycloakUser.email()))
                                  .subscribeOn(Schedulers.boundedElastic()));

     }

}
