package com.example.CareTag.Services.AuthServices;


import com.example.CareTag.DTOs.authDTOs.*;
import com.example.CareTag.Models.User;
import com.example.CareTag.Repos.UserRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
@RequiredArgsConstructor
public class PasswordResetService {
    private final UserRepo userRepo;
    private final EmailService emailService;
    private  final PasswordEncoder passwordEncoder;

//    public void sendOtp(ForgotPasswordRequest req){
//        User user = userRepo.findByEmail(req.getEmail());
//        String otp = String.format("%06d", new Random().nextInt(999999));
//
//        OtpDTO otpDTO =  new OtpDTO(user.getEmail(), otp);
////        user.setOtpcode(otp);
////        user.setOtpExpiery(LocalDateTime.now().plusMinutes(5));
////        userRepo.save(user);
//        otpRepo.save(otpDTO);
//
//        emailService.sendOtpEmail(req.getEmail(),otp,"Password Reset");
//
//    }
//    public ResetPasswordResponse verfiyOTPAndGenerateToken(VerfiyOtpRequest req){
//        Optional<OtpDTO> optioanlOtpDTO = otpRepo.findByEmail(req.getEmail());
//        if(optioanlOtpDTO.isEmpty()){
//            throw new RuntimeException("NULL");
//        }
//        OtpDTO otpDTO = optioanlOtpDTO.get();
//
//        if(!req.getOtp().equals(otpDTO.getOtp()) || otpDTO.getExpire().isBefore(LocalDateTime.now())){
//            log.info("Invalid or Expiry OTP");
//            throw new InvalidOneTimeTokenException("Invalid or Expiry OTP");
//        }
////        user.setOtpcode(null);
////        user.setOtpExpiery(null);
//        otpRepo.delete(otpDTO);
//
//        String resetToken = UUID.randomUUID().toString();
//        User user = userRepo.findByEmail(req.getEmail());
//        user.setPasswordResetToken(resetToken);
//        log.info(user.getPasswordResetToken());
//        user.setPasswordRestExpiery(LocalDateTime.now().plusMinutes(30));
//        userRepo.save(user);
//
//   return new  ResetPasswordResponse(resetToken);
//
//    }

    public void ResetPassword(ResetPasswordRequest req){
        User user  =  userRepo.findByPasswordResetToken(req.getResetToken()).orElseThrow(() -> new RuntimeException("not found"));

        if(user.getPasswordRestExpiery().isBefore(LocalDateTime.now())){
            user.setPasswordResetToken(null);
            user.setPasswordRestExpiery(null);
            userRepo.save(user);
            log.info("Password Reset Token Has been Expired");
            throw new RuntimeException("Password Reset Token Has been Expired");
        }
        user.setPassword(passwordEncoder.encode(req.getNewPassword()));
        user.setPasswordResetToken(null);
        user.setPasswordRestExpiery(null);
        userRepo.save(user);
    }


}
