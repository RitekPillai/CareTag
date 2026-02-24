package com.example.CareTag.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/link")
public class HandShakeController {
    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

/// Server(paitent) to doctor
    @PostMapping("/accept")
    public ResponseEntity<String> accept(@RequestBody Map<String, String> payload) {
        String doctor = payload.get("docName");
        String encryptedKeyBundle = payload.get("encryptedAesBlob");
        Map<String, String> response = Map.of(
                "status", "APPROVED",
                "encryptedAesBlob", encryptedKeyBundle
        );

        simpMessagingTemplate.convertAndSendToUser(doctor, "/queue/approval", response);
        return ResponseEntity.ok("Handshake pushed to doctor");
    }
    @PostMapping("/deny")
    public ResponseEntity<String> deny(@RequestBody String docId) {
        simpMessagingTemplate.convertAndSendToUser(
                docId,
                "/queue/approval",
                Map.of("status", "DENIED")
        );
        return ResponseEntity.ok("Denial pushed to doctor");
    }


}

