package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.service.TokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
public class TokenServiceImpl implements TokenService {
    private final ExAuthApiClient apiClient;

    @Override
    public Mono<TokenDto> refreshToken(String refreshToken) {
        return apiClient.refreshToken(refreshToken);
    }
}
