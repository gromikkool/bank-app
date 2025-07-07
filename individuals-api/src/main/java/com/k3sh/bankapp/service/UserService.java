package com.k3sh.bankapp.service;

import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import reactor.core.publisher.Mono;

public interface UserService {
     Mono<TokenDto> registration(IndividualCreateDto requestDto) ;
     Mono<IndividualDto> me(String accessToken);
}
