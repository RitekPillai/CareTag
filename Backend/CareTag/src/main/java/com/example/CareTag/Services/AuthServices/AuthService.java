package com.example.CareTag.Services.AuthServices;

import com.example.CareTag.DTOs.authDTOs.*;
import com.example.CareTag.Models.Paitent.PatientRecords;
import com.example.CareTag.Models.common.RefreshToken;
import com.example.CareTag.Models.common.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Models.type.RoleType;
import com.example.CareTag.Repos.Paitent.PatientRecordsRepo;
import com.example.CareTag.Repos.common.UserRepo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

import static java.rmi.server.LogStream.log;


@Slf4j
@Service

@RequiredArgsConstructor
public class AuthService {
        private final UserRepo userRepo;


        private final AuthUtil authUtil;
@Lazy
       private final  AuthenticationManager authenticationManager;
        private final RefereshTokenService refereshTokenService;
        private  final PatientRecordsRepo patientRecordsRepo;
        private final EmailService emailService;
        private final CacheService cacheService;
    private final PasswordEncoder passwordEncoder;
    private final DatabaseSeqService databaseSeqService;






//    @Transactional
//    public ResponseEntity<String> doctorSignUp(SignUpRequestDTO signUpRequestDTO) throws Exception {
//            User user = authUtil.getuser(signUpRequestDTO,AuthProvider.EMAIL,null, RoleType.DOCTOR);
//
//            log.info("Doctor Created: \n Email: "+user.getEmail()+" his Role "+user.getRole());
//       String token =      EmailVerificationToken(user);
//
//       /// one to one will create latter  (need to implement AES & RES )
//            return ResponseEntity.status(HttpStatus.OK).body(token);
//
//    }

    @Transactional
    public ResponseEntity<String> patientSignUp(SignUpRequestDTO signUpRequestDTO) throws Exception {


/// checkling if the yuser is already exsisit
        if(userRepo.existsByEmail(signUpRequestDTO.getEmail())){
            return  ResponseEntity.badRequest().body("Email already exists");
        }


        String token = UUID.randomUUID().toString();




        emailService.sendVerificationEmail(signUpRequestDTO.getEmail(), token);
            PendingUser pendingUser = PendingUser.builder()
                    .name(signUpRequestDTO.getUsername())
                    .email(signUpRequestDTO.getEmail())
                    .roleType(RoleType.PATIENT)
                    .password(passwordEncoder.encode(signUpRequestDTO.getPassword()))
                    .verificationToken(token)
                    .verificationTokenExpiryDate(LocalDateTime.now().plusMinutes(15))

                    .build();
        cacheService.savingPendingUser(pendingUser);
        AuthService.log.info("Pending User has been Successfully Saved In cache"+pendingUser);


        return ResponseEntity.status(HttpStatus.OK).body(token);

    }

    @Transactional
    public ResponseEntity<String> login(LoginRequestDTO req)throws  Exception{
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(req.getEmail(),req.getPassword()));
            User user = (User) authentication.getPrincipal();
        SecureRandom secureRandom = new SecureRandom();
        String otpcode = String.format("%06d", secureRandom.nextInt(1000000));
            AuthService.log.info("Login Otp code:{}",otpcode);
            cacheService.savingOtp(req.getEmail(),otpcode);
        emailService.sendOtpEmail(user.getEmail(),otpcode,"Login Verification");
            return new  ResponseEntity<>("The Otp Has Been Sent to your Email Please Check It:)",HttpStatus.ACCEPTED);
    }



    public void  verification(String email,String token) {

        PendingUser pendingUser = cacheService.getPendingUser(email);
        if(pendingUser==null){
            throw new RuntimeException("Registration session has been expired. Please sign up again.");
        }
        if(!pendingUser.getVerificationToken().equals(token)){
            throw new RuntimeException("Invalid Verification Token");
        }
        if(LocalDateTime.now().isAfter(pendingUser.getVerificationTokenExpiryDate())){
            cacheService.removeFromCache(pendingUser.getEmail());
            throw new RuntimeException("Verification  has Been Expired try SignUp Again ");
        }
        long id = databaseSeqService.generateSequence(User.SEQUENCE_NAME);
        User user = User.builder()
                .id(id)
                .email(pendingUser.getEmail())
                .username(pendingUser.getName())
                .password(pendingUser.getPassword())
                .authProvider(AuthProvider.EMAIL)
                .role(Set.of(pendingUser.getRoleType()))
                .isVerified(true)
                .build();
        userRepo.save(user);
        cacheService.removeFromCache(email);

    }

    public ResponseEntity<LogResponseDTO> verifyLogin(String  email,String requestOtp) {
       String otp = cacheService.fetchotp(email);


        if (otp==null) {
            throw new RuntimeException("Otp Has been Expired");
        }




        if(!otp.equals(requestOtp)){
            throw new RuntimeException("Invalid Otp Code.Code does not match");
        }
        cacheService.deleteOtp(email);
        User user = userRepo.findByEmail(email);
        if(user==null){
            throw new RuntimeException("User not found");
        }
     Optional<PatientRecords> patient =   patientRecordsRepo.findById(user.getId());
        boolean isPatient = patient.isPresent();

        log("IS patient is already Registered "+isPatient);

        String jwtToken = authUtil.generateToken(user);
        RefreshToken refreshToken = refereshTokenService.generateToken(user.getEmail());

        return ResponseEntity.ok(new LogResponseDTO(jwtToken, refreshToken.getToken(),isPatient));



    }


    public ResponseEntity<VerifyResponse> isMyEmailVerified(String email) throws Exception {

        User user = userRepo.findByEmail(email);
        if(user!=null){

            String jwtToken = authUtil.generateToken(user);
            RefreshToken refreshToken =refereshTokenService.generateToken(user.getEmail());
            AuthService.log.info("JWT TOKEN:{}",jwtToken);
            AuthService.log.info("REFRESH TOKEN:{}",refreshToken);

            return new ResponseEntity<>(new VerifyResponse(jwtToken, user.getUsername(), refreshToken.getToken()),HttpStatus.OK);

        }
        else{
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
        








        }


    public ResponseEntity<String> getCurrentUser(Principal principal) {

        if (principal == null) {
            AuthService.log.error("Principal is null");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Principal is null");
        }
        AuthService.log.info("Current User:{}",principal.getName());
        User user = userRepo.findByEmail(principal.getName());
        AuthService.log.info("Current User:{}", user.getEmail());
        if(user==null){
            AuthService.log.error("User not found");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User  not found");
        }
        log("Current user id:"+user.getId());
        System.out.println("Current user id:"+user.getId());

        Optional<PatientRecords> patient = patientRecordsRepo.findById(user.getId());

        if (patient.isEmpty()) {


            return ResponseEntity.status(HttpStatus.OK).body("REGISTRATION_INCOMPLETE");
        } else {
            System.out.println("Current user id:"+patient.get().getId());
            return ResponseEntity.status(HttpStatus.OK).body("AUTHENTICATED");
        }


    }

    public void doctorLogin(LoginRequestDTO loginRequestDTO) {
        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(loginRequestDTO.getEmail(),loginRequestDTO.getPassword()));
        User user = (User) authentication.getPrincipal();

        
    }
}




