package com.example.CareTag.Services.AuthServices;


import com.example.CareTag.Models.User;
import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Repos.UserRepo;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor

@Service
public class CustomUserDeatilsService implements UserDetailsService {

 private final   UserRepo userRepo;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

        User user = userRepo.findByEmail(email);


            if (user == null) {
                throw new DisabledException("User email not verified. Please check your inbox...");
            }
            if(user.getAuthProvider()== AuthProvider.GOOGLE){
                throw new DisabledException("Email is already registered ");
            }



        return user;

    }
}
