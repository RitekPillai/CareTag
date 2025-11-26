package com.example.CareTag.Models;

import com.example.CareTag.Models.type.AuthProvider;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.MongoId;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User implements UserDetails {
    @Transient
    public static final String SEQUENCE_NAME = "user_id_sequence";

    @MongoId
    @Id
    private long id;
    @Indexed(unique = true)
    private String email;
    private String password;
   private String username;
   private String providerId;
   private AuthProvider authProvider;
///  for password reset


   private String passwordResetToken;
   private LocalDateTime passwordRestExpiery;

   private boolean isVerified = false;







    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of();
    }


///  SignUp verification process
    /// is verified  = false
    /// signup->email password->save->randomUUID->sent to the email->user click the link->verify its -> and then sign up happy:)



}
