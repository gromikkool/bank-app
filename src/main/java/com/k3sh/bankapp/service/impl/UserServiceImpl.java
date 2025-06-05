package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserDto;
import com.k3sh.bankapp.exception.PasswordDoesNotMatchException;
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

    //todo: jackson check password
    @Override
    public Mono<TokenDto> registration(AuthRegistrationRequestDto requestDto) {
        if (!requestDto.password().equals(requestDto.confirmPassword())) {
            log.error("Password confirmation does not match");
            return Mono.error(new PasswordDoesNotMatchException("Password confirmation does not match"));
        }
        return apiClient.registration(requestDto).
                then(login(new LoginRequestDto(requestDto.email(), requestDto.password())));
    }

    // todo: send to TokenService
    @Override
    public Mono<TokenDto> login(LoginRequestDto loginDto) {
        return apiClient.login(loginDto.email(), loginDto.password());
    }

    @Override
    public Mono<UserDto> me(String accessToken) {
        return apiClient.me(accessToken);
    }


}
