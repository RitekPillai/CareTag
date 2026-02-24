package com.example.CareTag.Services;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/link")
@RequiredArgsConstructor
public class HandShakeController {

    private final  SimpMessagingTemplate simpMessagingTemplate;

private  final LinkingService linkingService;
/// Server(paitent) to doctor
    @PostMapping("/accept")
    public ResponseEntity<String> accept(@RequestBody Map<String, String> payload) {
        String doctor = payload.get("docEmail");
        log.info("doctor: " + doctor);
        String encryptedKeyBundle = payload.get("encryptedAesBlob");
        Map<String, String> response = Map.of(
                "status", "APPROVED",
                "encryptedAesBlob", encryptedKeyBundle
        );


        simpMessagingTemplate.convertAndSendToUser(doctor, "/queue/approval", response);
        linkingService.createLink( doctor, encryptedKeyBundle );
        return ResponseEntity.ok("Handshake pushed to doctor");
    }
    @PostMapping("/deny")
    public ResponseEntity<String> deny(@RequestBody String docId) {
        log.info("docId: " + docId);
        simpMessagingTemplate.convertAndSendToUser(
                docId,
                "/queue/approval",
                Map.of("status", "DENIED")
        );
        return ResponseEntity.ok("Denial pushed to doctor");
    }


}

