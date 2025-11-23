package com.example.CareTag.Services;

import com.example.CareTag.DTOs.RefreshTokenResponseDTO;
import com.example.CareTag.Models.RefreshToken;
import com.example.CareTag.Models.User;
import com.example.CareTag.Repos.RefreshTokenRepo;
import com.example.CareTag.Repos.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RefereshTokenService {
    private final RefreshTokenRepo refreshTokenRepo;
    private final UserRepo userRepo;
    private final AuthUtil authUtil;
    private final DatabaseSeqService databaseSeqService;

        public RefreshToken generateToken(String email){
RefreshToken refreshToken = new RefreshToken();
refreshToken.setToken(UUID.randomUUID().toString());
refreshToken.setEmail(email);
refreshToken.setId(databaseSeqService.generateSequence(RefreshToken.SEQUENCE_NAME));
long refreshTokenDurationMils =30 *24 *60*60*1000L;
refreshToken.setExpiryTime(Instant.now().plusMillis(refreshTokenDurationMils));
return refreshTokenRepo.save(refreshToken);
        }
    public Optional<RefreshToken> findToken(String token){
        return refreshTokenRepo.findByToken(token);
    }

    public RefreshToken verifyExpiration(RefreshToken token)  {
            if(token.getExpiryTime().isBefore(Instant.now())){
                throw new RuntimeException("Refresh Token Has been Expirey");
            }
            refreshTokenRepo.delete(token);
            return token;
}

public ResponseEntity<RefreshTokenResponseDTO> refreshToken(String Token) throws Exception{
return findToken(Token)
        .map( this::verifyExpiration)
        .map(RefreshToken::getEmail)
        .map(email->{
            User user = userRepo.findByEmail(email);
            String newJWT = authUtil.generateToken(user);
            Long id = user.getId();
            return ResponseEntity.ok(new RefreshTokenResponseDTO(Token, email,newJWT));
        }).orElseThrow(() -> new RuntimeException("Refresh token is not in database!"));

}

}
