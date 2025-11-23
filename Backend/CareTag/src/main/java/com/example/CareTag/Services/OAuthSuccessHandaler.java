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
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
@Component
public class OAuthSuccessHandaler implements AuthenticationSuccessHandler {

    private OAuth2Service oAuth2Service;
    @Autowired
    private   ObjectMapper objectMapper;
    @Autowired
    public void setOAuth2Service(OAuth2Service oAuth2Service) {
        this.oAuth2Service = oAuth2Service;
    }
    @SneakyThrows
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        OAuth2AuthenticationToken token = (OAuth2AuthenticationToken) authentication;
        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();

        String registrationid = token.getAuthorizedClientRegistrationId();
      ResponseEntity<LoginResponseDTO> loginResponse  =  oAuth2Service.Oauth2Login(oAuth2User,registrationid);
      response.setStatus(loginResponse.getStatusCode().value());
      response.setContentType(MediaType.APPLICATION_JSON_VALUE);
      response.getWriter().write(objectMapper.writeValueAsString(loginResponse.getBody()));

    }
}
