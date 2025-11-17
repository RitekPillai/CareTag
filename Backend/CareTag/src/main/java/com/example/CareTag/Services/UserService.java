package com.example.CareTag.Services;

import com.example.CareTag.DTOs.LoginRequestDTO;
import com.example.CareTag.DTOs.LoginResponseDTO;
import com.example.CareTag.DTOs.SignUpRequestDTO;
import com.example.CareTag.DTOs.SignUpResponseDTO;
import com.example.CareTag.Models.User;
import com.example.CareTag.Repos.UserRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service

@RequiredArgsConstructor
public class UserService {
        private final UserRepo userRepo;
        private final DatabaseSeqService databaseSeqService;
        private final PasswordEncoder passwordEncoder;
        private final JwtService jwtService;
        private final AuthenticationManager authenticationManager;

    public ResponseEntity<SignUpResponseDTO> signUp(SignUpRequestDTO req) throws Exception {
        /// for checking if the user is Already exsists
    User exUser  = userRepo.findByEmail(req.getEmail());
    if(exUser!=null){
        throw new Exception("Username Already Exsist");
    }
    long id = databaseSeqService.generateSequence(User.SEQUENCE_NAME);
   String encodePassword =  passwordEncoder.encode(req.getPassword());

    User user = User.builder()
            .id(id)
            .email(req.getEmail())
            .password(encodePassword)
            .username(req.getUsername()).build();

    userRepo.save(user);
log.info("User Created: Username:{} ",user.getUsername());
    return new ResponseEntity<>(new SignUpResponseDTO(user.getUsername(), user.getEmail()), HttpStatus.CREATED);


    }

    public ResponseEntity<LoginResponseDTO> login(LoginRequestDTO req)throws  Exception{
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(req.getEmail(),req.getPassword()));
            User user = (User) authentication.getPrincipal();
            String token = jwtService.generateToken(user);
            return new  ResponseEntity<>(new LoginResponseDTO(token, user.getUsername()),HttpStatus.ACCEPTED);
    }
}
