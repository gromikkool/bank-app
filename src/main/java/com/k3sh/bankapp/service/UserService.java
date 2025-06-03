package com.k3sh.bankapp.service;

import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserDto;
import reactor.core.publisher.Mono;

public interface UserService {
     Mono<TokenDto> registration(AuthRegistrationRequestDto authRegistrationResponseDto) ;
     Mono<TokenDto> login(LoginRequestDto loginRequestDto);
     Mono<UserDto> me(String accessToken);
}
