package com.k3sh.bankapp.rest;

import com.k3sh.bankapp.dto.*;
import com.k3sh.bankapp.service.TokenService;
import com.k3sh.bankapp.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("api/v1/auth/")
@RequiredArgsConstructor
public class AuthControllerV1 {

    private final UserService userService;
    private final TokenService tokenService;

    @PostMapping("registration")
    public Mono<TokenDto> registration(@RequestBody AuthRegistrationRequestDto authRegistrationRequestDto) {
        return userService.registration(authRegistrationRequestDto);
    }

    @PostMapping("login")
    public Mono<TokenDto> login(@RequestBody LoginRequestDto loginRequestDto) {
        return userService.login(loginRequestDto);
    }

    @PostMapping("refresh-token")
    public Mono<TokenDto> refreshToken(@RequestBody RefreshTokenRequestDto refreshToken) {
        return tokenService.refreshToken(refreshToken.refreshToken());
    }

    public static String getBearerTokenHeader() {
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (requestAttributes == null) return null;
        return requestAttributes.getRequest().getHeader("Authorization");
    }

    @GetMapping("me")
    public Mono<UserDto> me() {
        String tokenHeader = getBearerTokenHeader();
        if (tokenHeader == null) return Mono.empty();
        return userService.me(tokenHeader);
    }
}
