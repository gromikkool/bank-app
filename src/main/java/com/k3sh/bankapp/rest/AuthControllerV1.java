package com.k3sh.bankapp.rest;

import com.k3sh.bankapp.dto.AuthRegistrationRequestDto;
import com.k3sh.bankapp.dto.LoginRequestDto;
import com.k3sh.bankapp.dto.TokenDto;
import com.k3sh.bankapp.service.TokenService;
import com.k3sh.bankapp.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("api/v1/auth/")
@RequiredArgsConstructor
public class AuthControllerV1 {

    private final UserService userService;
    private final TokenService tokenService;

    @PostMapping("registration")
    public Mono<TokenDto> registration(@RequestBody AuthRegistrationRequestDto authRegistrationRequestDto) {
        return userService.registerUser(authRegistrationRequestDto);
    }

    @PostMapping("login")
    public Mono<TokenDto> login(@RequestBody LoginRequestDto loginRequestDto) {
        return userService.login(loginRequestDto);
    }

    @PostMapping("refresh-token")
    public String refreshToken() {
        return "refreshToken";
    }

    @PostMapping("me")
    public String me() {
        return "me";
    }
}
