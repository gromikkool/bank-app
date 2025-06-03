package com.k3sh.bankapp.service;

import com.k3sh.bankapp.dto.TokenDto;
import reactor.core.publisher.Mono;

public interface TokenService {
    Mono<TokenDto> refreshToken(String refreshToken);
}
