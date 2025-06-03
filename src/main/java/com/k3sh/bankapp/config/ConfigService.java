package com.k3sh.bankapp.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class ConfigService {
    @Bean
    public WebClient webClient() {
        return WebClient.builder().build();
    }
}
