package com.example.CareTag.Services;

import com.example.CareTag.Models.User;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.SecretKey;

import java.util.Date;
@Service
public class JwtService {

    @Value("${jwt.key}")
private String jwtSecretKeyBase64;

    public SecretKey getSecretkey(){
        byte[] keyBytes = Decoders.BASE64.decode(jwtSecretKeyBase64);
return Keys.hmacShaKeyFor(keyBytes);
    }

public String generateToken(User user){
        return Jwts.builder()
                .signWith(getSecretkey())

                .subject(user.getEmail())
                .claim("userId",user.getId())
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
}
