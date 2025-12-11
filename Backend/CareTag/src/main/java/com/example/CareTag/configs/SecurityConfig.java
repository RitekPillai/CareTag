package com.example.CareTag.configs;

import com.example.CareTag.Filters.JWTfilter;
import com.example.CareTag.Services.CustomUserDeatilsService;
import com.example.CareTag.Services.OAuthSuccessHandaler;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@EnableWebSecurity

@Configuration
@RequiredArgsConstructor
@Slf4j
public class  SecurityConfig {
    private final  JWTfilter jwTfilter;
private final CustomUserDeatilsService customUserDeatilsService;
    private final @Lazy OAuthSuccessHandaler oAuthSuccessHandaler; //
    private final PasswordEncoder passwordEncoder;
@Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http)throws Exception{
        return http.csrf(AbstractHttpConfigurer::disable)
                    .cors(Customizer.withDefaults())
                .authorizeHttpRequests(req -> req

                        .requestMatchers("/auth/**").permitAll()
                        .requestMatchers("/auth/forgot-password/**").permitAll() // Covers request-otp and verify-otp
                        .requestMatchers("/auth/reset-password").permitAll()






                        .anyRequest().authenticated()
                )

                .sessionManagement(session ->
                        session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                // .formLogin(AbstractAuthenticationFilterConfigurer::permitAll)
                .authenticationProvider(authenticationProvider())

                .addFilterBefore(jwTfilter, UsernamePasswordAuthenticationFilter.class)
                .oauth2Login(oauth2 ->oauth2.failureHandler((request, response, exception) -> log.info("oauth error:{}",exception.getMessage())

                )
                                .successHandler(oAuthSuccessHandaler)
                )

                .build();

    }
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // 1. Allow all origins for development (e.g., your Flutter app, emulator, browser)
        configuration.setAllowedOrigins(List.of("*"));

        // 2. Allow common methods
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));

        // 3. Allow all headers
        configuration.setAllowedHeaders(List.of("*"));

        // Important for JWT and session cookies
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        // Apply this configuration to all paths
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
@Bean
public AuthenticationProvider authenticationProvider(){
        DaoAuthenticationProvider daoAuthenticationProvider = new  DaoAuthenticationProvider(customUserDeatilsService);
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder);
        return daoAuthenticationProvider;

}





}
