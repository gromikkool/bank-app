package com.k3sh.bankapp.client;

import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import reactor.core.publisher.Mono;

public interface ExAuthApiClient {

    Mono<TokenDto> login(String email, String password);


    Mono<TokenDto> register(AuthRegistrationRequestDto authRegistrationRequestDto);

}
