package com.example.CareTag.configs;

import com.example.CareTag.Filters.JWTfilter;
import com.example.CareTag.Repos.HttpCookieOAuth2AuthorizationRequestRepository;
import com.example.CareTag.Services.AuthServices.CustomUserDeatilsService;

import com.example.CareTag.Services.AuthServices.OAuthFailureHandler;
import com.example.CareTag.Services.AuthServices.OAuthSuccessHandaler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.util.List;

@EnableWebSecurity
@Configuration
@RequiredArgsConstructor
@Slf4j
public class SecurityConfig {
    private final JWTfilter jwTfilter;
    private final CustomUserDeatilsService customUserDeatilsService;
    private final @Lazy OAuthSuccessHandaler oAuthSuccessHandaler;
    private final HttpCookieOAuth2AuthorizationRequestRepository cookieRepository;
    private final PasswordEncoder passwordEncoder;
    private final OAuthFailureHandler oAuthFailureHandler;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http
                .csrf(AbstractHttpConfigurer::disable)
                .cors(Customizer.withDefaults())

                .authorizeHttpRequests(req -> req
                        .requestMatchers("/auth/**", "/exchange", "/login/**", "/oauth2/**", "/error").permitAll()
                        .requestMatchers("/doctor/**").hasRole("DOCTOR")
                        .requestMatchers("/auth/me").authenticated()
                        .anyRequest().authenticated()
                )
                .sessionManagement(session ->
                        // Change to IF_REQUIRED to allow the OAuth handshake to happen
                        session.sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                )
                .authenticationProvider(authenticationProvider())
                .addFilterBefore(jwTfilter, UsernamePasswordAuthenticationFilter.class)
                .oauth2Login(oauth2 -> oauth2
                        .authorizationEndpoint(auth -> auth
                                .baseUri("/oauth2/authorization")
                                .authorizationRequestRepository(cookieRepository)
                        )
                        .redirectionEndpoint(redirection -> redirection
                                .baseUri("/login/oauth2/code/*")
                        )
                        .successHandler(oAuthSuccessHandaler)
                        .failureHandler(oAuthFailureHandler)

                )
                .build();
    }

    @Bean
    public AuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(customUserDeatilsService);
        provider.setPasswordEncoder(passwordEncoder);
        return provider;
    }
}