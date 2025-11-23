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





    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of();
    }


}
