package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserDto;
import com.k3sh.bankapp.exception.PasswordDoesNotMatchException;
import com.k3sh.bankapp.service.TokenService;
import com.k3sh.bankapp.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Service;

import reactor.core.publisher.Mono;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final ExAuthApiClient apiClient;
    private final TokenService tokenService;

    @Override
    public Mono<TokenDto> registration(AuthRegistrationRequestDto requestDto) {
        return apiClient.registration(requestDto)
                .then(tokenService.login(new LoginRequestDto(requestDto.email(), requestDto.password())));
    }

    @Override
    public Mono<UserDto> me(String accessToken) {
        return apiClient.me(accessToken);
    }


}
