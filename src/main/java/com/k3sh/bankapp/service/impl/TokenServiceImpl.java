package com.k3sh.bankapp.service.impl;

import com.k3sh.bankapp.client.ExAuthApiClient;
import com.k3sh.bankapp.client.KeycloakProperties;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.service.TokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TokenServiceImpl implements TokenService {
    private final ExAuthApiClient apiClient;
    private final KeycloakProperties keycloakProperties;
    private TokenDto adminToken;


    @Override
    public String refreshToken(String refreshToken) {
        return "";
    }

}
