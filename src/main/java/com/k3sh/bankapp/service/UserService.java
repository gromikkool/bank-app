package com.k3sh.bankapp.service;

import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import reactor.core.publisher.Mono;

public interface UserService {
     Mono<TokenDto> registerUser(AuthRegistrationRequestDto authRegistrationResponseDto) ;
     Mono<TokenDto> login(LoginRequestDto loginRequestDto);
}
