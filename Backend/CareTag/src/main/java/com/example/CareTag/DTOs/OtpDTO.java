package com.example.CareTag.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor@NoArgsConstructor
@Document(collection = "otps")
public class OtpDTO {

    @Id
    private String id;
    @Indexed(unique = true)
    private String email;
    private String otp;
    private LocalDateTime expire;

    public OtpDTO(String email, String otp){
        this.expire = LocalDateTime.now().plusMinutes(15);
        this.email = email;
        this.otp = otp;
    }
}
