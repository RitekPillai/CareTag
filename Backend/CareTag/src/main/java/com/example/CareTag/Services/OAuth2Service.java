package com.example.CareTag.Services;

import com.example.CareTag.DTOs.LoginResponseDTO;
import com.example.CareTag.DTOs.SignUpRequestDTO;
import com.example.CareTag.Models.RefreshToken;
import com.example.CareTag.Models.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Repos.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
@RequiredArgsConstructor
@Component
public class OAuth2Service {

    private final AuthUtil authUtil;
    private final UserRepo userRepo;


    private final RefereshTokenService refereshTokenService;


    @Transactional
    public ResponseEntity<LoginResponseDTO> Oauth2Login(OAuth2User oAuth2User, String registrationid) throws Exception {
        AuthProvider authProvider = authUtil.getProviderFromRegID(registrationid);
        String providerid = authUtil.getProperProviderId(oAuth2User,registrationid);
        /// oauth user
        User user = userRepo.findByProviderIdAndAuthProvider(providerid,authProvider).orElse(null);
        String emaill  = oAuth2User.getAttribute("email");
        User emailUser = userRepo.findByEmail(emaill);
        if(user==null && emailUser==null){
            /// signUp
            String email = oAuth2User.getAttribute("email");
            String username = oAuth2User.getAttribute("name");
            user = authUtil.getuser(new SignUpRequestDTO(username,email,null),authProvider,providerid);


        }else if (user!=null){
            ///login
            if(emaill!=null && !emaill.isBlank() && !emaill.equals(user.getEmail())){
                user.setEmail(emaill);
                userRepo.save(user);
            }


        }else{
            throw new BadCredentialsException("This email is Already Registerd with :{}"+emailUser.getAuthProvider());
        }
        String token = authUtil.generateToken(user);
        RefreshToken refreshToken =refereshTokenService.generateToken(user.getEmail());

        LoginResponseDTO loginResponseDTO = new   LoginResponseDTO(token, user.getUsername(), refreshToken.getToken());
        return ResponseEntity.ok(loginResponseDTO);

    }
}
