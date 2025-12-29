package com.example.CareTag.Services;


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


            if (!user.isVerified() && user.getAuthProvider() == AuthProvider.EMAIL) {
                throw new DisabledException("User email not verified. Please check your inbox...");
            }
            if(user.getAuthProvider()== AuthProvider.GOOGLE){
                throw new DisabledException("Email is already registered ");
            }
            if(user==null){
                throw new UsernameNotFoundException("User not found");
            }


        return user;

    }
}
