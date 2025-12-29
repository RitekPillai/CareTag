package com.example.CareTag.Services;

import com.example.CareTag.DTOs.*;
import com.example.CareTag.Models.RefreshToken;
import com.example.CareTag.Models.User;
import com.example.CareTag.Models.VerificationToken;
import com.example.CareTag.DTOs.OtpDTO;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Repos.UserRepo;
import com.example.CareTag.Repos.VerificationTokenRepo;
import com.example.CareTag.Repos.OtpRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Map;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
@Service

@RequiredArgsConstructor
public class AuthService {
        private final UserRepo userRepo;


        private final AuthUtil authUtil;
@Lazy
       private final  AuthenticationManager authenticationManager;
        private final RefereshTokenService refereshTokenService;
        private final VerificationTokenRepo verificationTokenRepo;
        private final EmailService emailService;
        private final OtpRepo otpRepo;





            public ResponseEntity<SignUpResponseDTO> signUp(SignUpRequestDTO req) throws Exception {
        User user = authUtil.getuser(req,AuthProvider.EMAIL,null);
log.info("User Created: Username:{} ",user.getUsername());
String token = UUID.randomUUID().toString();


VerificationToken verificationToken = new  VerificationToken(token,user);
VerificationToken verificationToken1 =   verificationTokenRepo.save(verificationToken);
log.info("Token Created: Token:{} ",verificationToken1.getToken());
emailService.sendVerificationEmail(user.getEmail(), verificationToken.getToken());




    return new ResponseEntity<>(new SignUpResponseDTO(token), HttpStatus.CREATED);


    }

    /// loginController(typical email password)
    public ResponseEntity<String> login(LoginRequestDTO req)throws  Exception{
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(req.getEmail(),req.getPassword()));
            User user = (User) authentication.getPrincipal();
            String otpcode = String.format("%06d",new Random().nextInt(1000000));

            log.info("Login Otp code:{}",otpcode);
        OtpDTO OtpDTO = new OtpDTO(user.getEmail(),otpcode);

        otpRepo.save(OtpDTO);

        emailService.sendOtpEmail(user.getEmail(),otpcode,"Login Verification");
//            String token = authUtil.generateToken(user);
//        RefreshToken refreshToken =refereshTokenService.generateToken(user.getEmail());


            return new  ResponseEntity<>("The Otp Has Been Sent to your Email Please Check It:)",HttpStatus.ACCEPTED);
    }



    public void  verification(String token) {
        Optional<VerificationToken> tokenOptional = verificationTokenRepo.findByToken(token);
        if(tokenOptional.isEmpty()){
            throw new RuntimeException("Invalid verification token.");        }
        VerificationToken verificationToken  = tokenOptional.get();
        if(verificationToken.getExpiryDate().isBefore(LocalDateTime.now())){
            throw new RuntimeException("Verification token has expired.");        }

        User user = verificationToken.getUser();
        if(user.isVerified()){
          throw new RuntimeException("Email already verified. You can now log in.");
        }
//
        user.setVerified(true);
        userRepo.save(user);






    }

    public ResponseEntity<LoginResponseDTO> verifyLogin(OtpRequest otpRequest) {
        Optional<OtpDTO> otpOptional = otpRepo.findByEmail(otpRequest.getEmail());

        if (otpOptional.isEmpty()) {
            throw new RuntimeException("Invalid code. Please check your email.");
        }
        OtpDTO otp = otpOptional.get();

        if (otp.getExpire().isBefore(LocalDateTime.now())) {
            otpRepo.delete(otp);
            throw new RuntimeException("OTP has been Expired");
        }
        log.info("OTP ====:{}",otp.getOtp());
        log.info("form input otp:{}",otpRequest.getOtpCode());
        if (otpRequest.getOtpCode() == null || otpRequest.getOtpCode().isEmpty()) {
            throw new RuntimeException("OTP code cannot be empty.");
        }
        if (!otp.getOtp().trim().equals(otpRequest.getOtpCode().trim())) {
            otpRepo.delete(otp);
            throw new RuntimeException("OTP NOT SAME PLEASE ENTER VALID OTP");
        }
        otpRepo.delete(otp);
        User user = userRepo.findByEmail(otp.getEmail());
        String jwtToken = authUtil.generateToken(user);
        RefreshToken refreshToken = refereshTokenService.generateToken(user.getEmail());
        return ResponseEntity.ok(new LoginResponseDTO(jwtToken, user.getUsername(), refreshToken.getToken(),false));



    }


    public ResponseEntity<VerifyResponse> isMyEmailVerified(String token) throws Exception {
        Optional<VerificationToken> tokenOptional = verificationTokenRepo.findByToken(token);


        if(tokenOptional.isEmpty()){
            throw new RuntimeException("Invalid verification token is empty.");
        }
        log.info("token ====:{}",tokenOptional.get().getToken());

        VerificationToken verificationToken  = tokenOptional.get();



        User user = verificationToken.getUser();
        if(user.isVerified()){
            String jwtToken = authUtil.generateToken(user);
            RefreshToken refreshToken =refereshTokenService.generateToken(user.getEmail());
            log.info("JWT TOKEN:{}",jwtToken);
            log.info("REFRESH TOKEN:{}",refreshToken);
            verificationTokenRepo.delete(verificationToken);

            return new ResponseEntity<>(new VerifyResponse(jwtToken, user.getUsername(), refreshToken.getToken()),HttpStatus.OK);

        } else if (!user.isVerified()) {
            log.info("user is not verified.");
                throw  new Exception("user is not verified.");
        }
        else{
            log.info("something went wrong.");
            throw new Exception("something went wrong.");
        }


    }
}

