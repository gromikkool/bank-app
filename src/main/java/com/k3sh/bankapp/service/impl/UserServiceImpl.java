package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final ExAuthApiClient keycloakApiClient;


    @Override
    public Mono<TokenDto> registerUser(AuthRegistrationRequestDto requestDto) {
        return keycloakApiClient.register(requestDto);
    }

    @Override
    public Mono<TokenDto> login(LoginRequestDto loginDto) {
        return keycloakApiClient.login(loginDto.email(), loginDto.password());
    }

}
