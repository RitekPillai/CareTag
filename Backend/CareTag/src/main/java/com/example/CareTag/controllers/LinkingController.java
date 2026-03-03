package com.example.CareTag.controllers;

import com.example.CareTag.DTOs.PermissionRequestDTO;
import com.example.CareTag.Services.LinkingService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequestMapping("/link")
public class LinkingController {

    @Autowired
    LinkingService linkingService;

    @PostMapping("/request")
    public void requestPaitentPermission(@RequestBody String careTagId) throws InterruptedException {
log.info("called");
        linkingService.PermissionRequest(careTagId);


    }
}
