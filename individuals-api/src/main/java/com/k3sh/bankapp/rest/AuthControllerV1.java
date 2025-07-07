package com.k3sh.bankapp.rest;

import com.k3sh.bankapp.dto.*;
import com.k3sh.bankapp.exception.UserNotFoundException;
import com.k3sh.bankapp.service.TokenService;
import com.k3sh.bankapp.service.UserService;
import com.k3sh.common.model.IndividualCreateDto;
import com.k3sh.common.model.IndividualDto;
import com.k3sh.common.model.UserCreateDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("api/v1/auth/")
@RequiredArgsConstructor
@Tag(name = "auth-controller-v-1", description = "API for registration, authentication, token refresh, and user data retrieval.")
public class AuthControllerV1 {

     private final UserService userService;
     private final TokenService tokenService;

     @Operation(summary = "Register a new user")
     @ApiResponses(value = {
             @ApiResponse(responseCode = "201", description = "Successful registration",
                     content = @Content(mediaType = "application/json",
                             schema = @Schema(implementation = TokenDto.class))),
             @ApiResponse(responseCode = "400", description = "Validation error in the request"),
             @ApiResponse(responseCode = "409", description = "User with this email already exists")
     })
     @PostMapping("registration")
     public Mono<TokenDto> registration(@RequestBody @Valid IndividualCreateDto userRegistrationDto) {
          return userService.registration(userRegistrationDto);
     }

     @Operation(summary = "User authentication (login)")
     @PostMapping("login")
     public Mono<TokenDto> login(@RequestBody LoginRequestDto loginRequestDto) {
          return tokenService.login(loginRequestDto);
     }

     @Operation(summary = "Refresh access and refresh tokens")
     @PostMapping("refresh-token")
     public Mono<TokenDto> refreshToken(@RequestBody RefreshTokenRequestDto refreshToken) {
          return tokenService.refreshToken(refreshToken.refreshToken());
     }

     public static String getBearerTokenHeader() {
          ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
          if (requestAttributes == null) return null;
          return requestAttributes.getRequest().getHeader("Authorization");
     }

     @Operation(summary = "Get current user details")
     @GetMapping("me")
     public Mono<IndividualDto> me() {
          String tokenHeader = getBearerTokenHeader();
          if (tokenHeader == null)
               return Mono.error(new UserNotFoundException("User not found"));
          return userService.me(tokenHeader);
     }
}
