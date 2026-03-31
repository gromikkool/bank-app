package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.client.feign.PersonServiceFeignClient;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.exception.CreateUserException;
import com.k3sh.bankapp.exception.KeycloakRegistrationException;
import com.k3sh.bankapp.exception.PartialRollbackException;
import com.k3sh.bankapp.exception.UserAlreadyExists;
import com.k3sh.bankapp.service.TokenService;
import com.k3sh.bankapp.service.UserService;
import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
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

     @Override
     public Mono<TokenDto> registration(IndividualCreateDto requestDto) {
          return Mono.fromCallable(() -> personServiceFeignClient.createIndividual(requestDto))
                  .subscribeOn(Schedulers.boundedElastic()) // read about this
                  .onErrorResume(FeignException.class, ex -> {
                       if (ex.status() == 409) {
                            return Mono.error(new UserAlreadyExists("User with this email already exists"));
                       }
                       log.error("Person-service is not available", ex);
                       return Mono.error(new CreateUserException("User creation failed, person-service is not available"));
                  })
                  .flatMap(individual -> apiClient.registration(new AuthRegistrationRequestDto(
                                          individual.getBody().getId(),
                                          individual.getBody().getUser().getEmail(),
                                          requestDto.getUser().getPassword(),
                                          requestDto.getUser().getConfirmPassword(),
                                          individual.getBody().getUser().getFirstName(),
                                          individual.getBody().getUser().getLastName()
                                  ))
                                  .onErrorResume(ex -> {
                                               log.error("Keycloak registration failed", ex);
                                               log.error("Delete user with id {} from person-service", individual.getBody().getId());
                                               return Mono.fromCallable(() -> personServiceFeignClient.rollbackRegistration(individual.getBody().getId()))
                                                       .subscribeOn(Schedulers.boundedElastic())
                                                       .retryWhen(Retry.backoff(3, Duration.ofSeconds(1)))
                                                       .onErrorResume(deleteEx -> {
                                                            log.error("Failed to delete user with id {} after registration failed", individual.getBody().getId(), deleteEx);
                                                            return Mono.error(new PartialRollbackException("User partially created and could not be rolled back", deleteEx));
                                                       })
                                                       .then(Mono.error(new KeycloakRegistrationException("Keycloak registration failed", ex)));
                                          }
                                  )
                                  .then(tokenService.login(new LoginRequestDto(requestDto.getUser().getEmail(), requestDto.getUser().getPassword())))
                  );
     }

     @Override
     public Mono<IndividualDto> me(String accessToken) {
          return apiClient.me(accessToken).
                  flatMap(keycloakUser ->
                          Mono.fromCallable(() -> personServiceFeignClient.getIndividualById(keycloakUser.globalUuid()).getBody())
                                  .subscribeOn(Schedulers.boundedElastic()));

     }

}

// контекстная диаграмма, sequence диаграмма, общий docker-compose, cmake.