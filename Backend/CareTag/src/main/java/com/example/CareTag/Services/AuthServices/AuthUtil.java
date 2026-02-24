package com.example.CareTag.Services.AuthServices;

import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Repos.common.UserRepo;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;

import java.util.Date;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthUtil {

    @Value("${jwt.key}")
private String jwtSecretKeyBase64;
    private final UserRepo userRepo;
    private final DatabaseSeqService databaseSeqService;

    public SecretKey getSecretkey(){
        byte[] keyBytes = Decoders.BASE64.decode(jwtSecretKeyBase64);
return Keys.hmacShaKeyFor(keyBytes);
    }

public String generateToken(User user){
        log.info("userID:"+user.getId());
    List<String> roles = user.getRole().stream()
            .map(Enum::name)
            .toList();
        return Jwts.builder()
                .signWith(getSecretkey())

                .subject(user.getEmail())
                .claim("userId",user.getId())

                .claim("roles",roles)

                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis()+1000*60*10))
                .compact();
}
public String getUsernameFromToken(String Token){
    Claims claims = Jwts.parser()
            .verifyWith(getSecretkey())
            .build()
            .parseSignedClaims(Token)
            .getPayload();
    return claims.getSubject();
}

public AuthProvider getProviderFromRegID(String regID){
   return switch (regID.toLowerCase()){
       case "google" -> AuthProvider.GOOGLE;
       case "facebook" -> AuthProvider.FACEBOOK;
       case "apple" -> AuthProvider.APPLE;
       default -> throw new IllegalArgumentException("Unsupport Oauth2Provider:"+regID);
   };
}
public String getProperProviderId(OAuth2User oAuth2User,String registrationId){
        String providerId = switch (registrationId.toLowerCase()){
          case "google" -> oAuth2User.getAttribute("sub");
          case "apple" -> oAuth2User.getAttribute("sub");
          case "facebook"-> oAuth2User.getAttribute("id");
            default -> throw  new IllegalArgumentException("UnSupported providerId"+registrationId);
        };
        if(providerId==null|| providerId.isBlank()){
                log.info("Unable to determine proverId for provider :{}",providerId);
                throw new IllegalArgumentException("Unable to determine proverId for provider");
        }
        return providerId;
}

    public String getHtmlSuccessMessage() {
        return "<html>"
                + "<head><title>Verification Successful</title>"
                + "<style>body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; } .success { color: green; font-size: 24px; }</style>"
                + "</head>"
                + "<body>"
                + "<div class='success'>✅ Email Verified Successfully!</div>"
                + "<p>Your account is now active. You can close this window and proceed to login.</p>"
                + "</body>"
                + "</html>";
    }

    public String getHtmlErrorMessage(String error) {
        return "<html>"
                + "<head><title>Verification Failed</title>"
                + "<style>body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; } .error { color: red; font-size: 24px; }</style>"
                + "</head>"
                + "<body>"
                + "<div class='error'>❌ Verification Failed!</div>"
                + "<p>Reason: " + error + "</p>"
                + "<p>Please contact support or request a new verification link.</p>"
                + "</body>"
                + "</html>";
    }


}
