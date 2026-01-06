package com.example.CareTag.Services.AuthServices;

import com.example.CareTag.DTOs.authDTOs.LoginResponseDTO;
import com.example.CareTag.DTOs.authDTOs.SignUpRequestDTO;
import com.example.CareTag.Models.DatabaseSequence;
import com.example.CareTag.Models.Patient;
import com.example.CareTag.Models.RefreshToken;
import com.example.CareTag.Models.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Repos.PatientRepo;
import com.example.CareTag.Repos.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@RequiredArgsConstructor
@Component
public class OAuth2Service {

    private final AuthUtil authUtil;
    private final UserRepo userRepo;
    private final DatabaseSeqService databaseSeqService;
    private  final PatientRepo patientRepo;


    private final RefereshTokenService refereshTokenService;




    @Transactional
    public ResponseEntity<LoginResponseDTO> Oauth2Login(OAuth2User oAuth2User, String registrationid) throws Exception {
        AuthProvider authProvider = authUtil.getProviderFromRegID(registrationid);
        String providerid = authUtil.getProperProviderId(oAuth2User, registrationid);
        String email = oAuth2User.getAttribute("email");

        User user = userRepo.findByProviderIdAndAuthProvider(providerid, authProvider).orElse(null);
        User emailUser = userRepo.findByEmail(email);

        boolean isRegister = false;
        Optional<Patient> patient = patientRepo.findById(user.getId());

        if(patient.isPresent()){

            isRegister = true;
        }

        boolean isNew = false;
        if (user == null && emailUser == null) {
            isNew = true;
            long id = databaseSeqService.generateSequence(User.SEQUENCE_NAME);
            user = User.builder()
                    .id(id)
                    .email(email)
                    .authProvider(authProvider)
                    .providerId(providerid)
                    .isVerified(true)
                    .username(oAuth2User.getAttribute("name"))
                    .build();
            userRepo.save(user); // CRITICAL: Save new user
        } else if (user != null) {
            if (email != null && !email.equals(user.getEmail())) {
                user.setEmail(email);
                userRepo.save(user); // Update existing user email
            }
        } else {
            throw new BadCredentialsException("Email already registered with another provider");
        }

        String token = authUtil.generateToken(user);
        RefreshToken refreshToken = refereshTokenService.generateToken(user.getEmail());

        return ResponseEntity.ok(new LoginResponseDTO(token, user.getUsername(), refreshToken.getToken(), isNew,isRegister));
    }
}
