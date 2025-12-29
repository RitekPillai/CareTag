package com.example.CareTag.Services;

import com.example.CareTag.DTOs.LoginResponseDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizationSuccessHandler;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.UUID;

@Component
public class OAuthSuccessHandaler implements AuthenticationSuccessHandler {

    @Autowired
    private TokenExchangeService tokenExchangeService;

    @Autowired
    private OAuth2Service oAuth2Service;

    @SneakyThrows
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {

        OAuth2AuthenticationToken token = (OAuth2AuthenticationToken) authentication;
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();

        String registrationId = token.getAuthorizedClientRegistrationId();

        ResponseEntity<LoginResponseDTO> loginResponse = oAuth2Service.Oauth2Login(oAuth2User, registrationId);
        LoginResponseDTO dto = loginResponse.getBody();
        boolean isNew = dto.isNew();

        String exchangeToken = tokenExchangeService.createExchangeCode(dto);


        String flutterUrl = String.format("caretag://auth?code=%s&isNewUser=%b", exchangeToken,isNew);

        response.sendRedirect(flutterUrl);
    }
}
