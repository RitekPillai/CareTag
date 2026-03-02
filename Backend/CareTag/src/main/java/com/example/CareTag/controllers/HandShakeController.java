package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.BlockRequestDTO;
import com.example.CareTag.Services.LinkingService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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


    @PostMapping("/accept")
    public ResponseEntity<String> accept(@RequestBody Map<String, String> payload) {
        log.info("Received request to accept link{}",payload);
        String doctor = payload.get("docId");
        log.info("doctor: " + doctor);

        Map<String, String> response = Map.of(
                "status", "APPROVED"
        );


        simpMessagingTemplate.convertAndSendToUser(doctor, "/queue/approval", response);
        linkingService.createLink( doctor );
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

    @PostMapping("/block")
    public ResponseEntity<String> block(@RequestBody BlockRequestDTO blockrequestDTO) {

        linkingService.blockDoctor(blockrequestDTO);
        log.info("block: " + blockrequestDTO);
        simpMessagingTemplate.convertAndSendToUser(blockrequestDTO.getDocID(),"/queue/approval",Map.of("status", "BLOCKED"));
        return ResponseEntity.ok("Blocked to doctor");
    }


}

