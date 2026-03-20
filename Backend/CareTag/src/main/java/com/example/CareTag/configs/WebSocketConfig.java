package com.example.CareTag.configs;

import com.example.CareTag.Models.common.User;
import com.example.CareTag.Repos.common.UserRepo;
import com.example.CareTag.Services.AuthServices.AuthUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.simp.config.ChannelRegistration;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;

@Slf4j
@Configuration
@EnableWebSocketMessageBroker
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
  private final AuthUtil authUtil;
  private final UserRepo userRepo;

  @Override
  public void registerStompEndpoints(StompEndpointRegistry registry) {
    registry.addEndpoint("/ws").setAllowedOriginPatterns("*"); // Raw WebSocket

    registry.addEndpoint("/websocket")
        .setAllowedOriginPatterns("*")
        .withSockJS();
  }

  @Override
  public void configureMessageBroker(MessageBrokerRegistry config) {

    config.enableSimpleBroker("/topic", "/queue");
    config.setApplicationDestinationPrefixes("/app");

    config.setUserDestinationPrefix("/user");
  }

  @Override
  public void configureClientInboundChannel(ChannelRegistration registration) {
    registration.interceptors(new ChannelInterceptor() {
      @Override
      public Message<?> preSend(Message<?> message, MessageChannel channel) {
        StompHeaderAccessor accessor = MessageHeaderAccessor.getAccessor(message, StompHeaderAccessor.class);

        if (StompCommand.CONNECT.equals(accessor.getCommand())) {
          String authHeader = accessor.getFirstNativeHeader("Authorization");

          if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
              String email = authUtil.getUsernameFromToken(token);
              log.info("username = {}", email);
              User user = userRepo.findByEmail(email);
              UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(user, null,
                  user.getAuthorities());

              accessor.setUser(auth);
              System.out.println("WebSocket Authenticated User: " + user.getEmail());
            } catch (Exception e) {
              System.out.println("WebSocket Auth Failed: " + e.getMessage());
            }
          }
        }
        return message;
      }
    });
  }

}
