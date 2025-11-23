package com.example.CareTag.Services;

import com.example.CareTag.DTOs.LoginRequestDTO;
import com.example.CareTag.DTOs.LoginResponseDTO;
import com.example.CareTag.DTOs.SignUpRequestDTO;
import com.example.CareTag.DTOs.SignUpResponseDTO;
import com.example.CareTag.Models.RefreshToken;
import com.example.CareTag.Models.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Repos.UserRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service

@RequiredArgsConstructor
public class AuthService {
        private final UserRepo userRepo;


        private final AuthUtil authUtil;
@Lazy
       private final  AuthenticationManager authenticationManager;
        private final RefereshTokenService refereshTokenService;






            public ResponseEntity<SignUpResponseDTO> signUp(SignUpRequestDTO req) throws Exception {
        User user = authUtil.getuser(req,AuthProvider.EMAIL,null);
log.info("User Created: Username:{} ",user.getUsername());

String token = authUtil.generateToken(user);
        RefreshToken refreshToken =refereshTokenService.generateToken(user.getEmail());
    return new ResponseEntity<>(new SignUpResponseDTO(user.getUsername(), user.getEmail(),token), HttpStatus.CREATED);


    }
    /// loginController(typical email password)
    public ResponseEntity<LoginResponseDTO> login(LoginRequestDTO req)throws  Exception{
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(req.getEmail(),req.getPassword()));
            User user = (User) authentication.getPrincipal();
            String token = authUtil.generateToken(user);
        RefreshToken refreshToken =refereshTokenService.generateToken(user.getEmail());
            return new  ResponseEntity<>(new LoginResponseDTO(token, user.getUsername(),refreshToken.getToken()),HttpStatus.ACCEPTED);
    }

}
