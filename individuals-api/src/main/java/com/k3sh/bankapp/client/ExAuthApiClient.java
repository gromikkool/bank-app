package com.k3sh.bankapp.client;

import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.dto.UserCreationDto;
import com.k3sh.bankapp.dto.KeycloakUserDto;
import reactor.core.publisher.Mono;

public interface ExAuthApiClient {
    Mono<TokenDto> login(String email, String password);

    Mono<UserCreationDto> registration(AuthRegistrationRequestDto authRegistrationRequestDto);

    Mono<KeycloakUserDto> me(String accessToken);

    Mono<TokenDto> refreshToken(String refreshToken);
}
