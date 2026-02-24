package com.example.CareTag.configs;


import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import javax.annotation.PostConstruct;
import java.io.InputStream;

@Configuration
public class FirebaseConfig {
    @PostConstruct
    public void init() {
        try{
            ClassPathResource resource = new ClassPathResource("firebase-service-account.json");
            InputStream inputStream = resource.getInputStream();
            FirebaseOptions options = FirebaseOptions.builder()
                    .setCredentials(GoogleCredentials.fromStream(inputStream))
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                System.out.println(" Firebase has been initialized successfully.");
            }
        }catch(Exception e){
            System.err.println(" Error initializing Firebase: " + e.getMessage());
        }
    }
}
