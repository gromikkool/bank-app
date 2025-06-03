package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserDto;
import com.k3sh.bankapp.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final ExAuthApiClient apiClient;

    @Override
    public Mono<TokenDto> registration(AuthRegistrationRequestDto requestDto) {
        return apiClient.registration(requestDto).
                then(login(new LoginRequestDto(requestDto.email(), requestDto.password())));
    }

    @Override
    public Mono<TokenDto> login(LoginRequestDto loginDto) {
        return apiClient.login(loginDto.email(), loginDto.password());
    }

    @Override
    public Mono<UserDto> me(String accessToken) {
        return apiClient.me(accessToken);
    }


}
