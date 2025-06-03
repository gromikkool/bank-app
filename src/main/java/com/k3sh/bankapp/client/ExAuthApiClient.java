package com.k3sh.bankapp.client;

import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserDto;
import reactor.core.publisher.Mono;

public interface ExAuthApiClient {
    Mono<TokenDto> login(String email, String password);

    Mono<Void> registration(AuthRegistrationRequestDto authRegistrationRequestDto);

    Mono<UserDto> me(String accessToken);

    Mono<TokenDto> refreshToken(String refreshToken);
}
