package com.example.CareTag.Models;

import com.example.CareTag.Models.type.AuthProvider;
import com.example.CareTag.Models.type.RoleType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.MongoId;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.management.relation.Role;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

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
   private boolean isVerified = false;

   private Set<RoleType> role = new HashSet<>();
   ///  for password reset


   private String passwordResetToken;
   private LocalDateTime passwordRestExpiery;









    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return role.stream().map(roleType -> new SimpleGrantedAuthority("ROLE_"+roleType.name())).collect(Collectors.toSet());




    }


///  SignUp verification process



    /// is verified  = false
    /// signup->email password->save->randomUUID->sent to the email->user click the link->verify its -> and then sign up happy:)



}
