package com.example.CareTag.controllers;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/greet")
public class TestingController {
    @GetMapping("/hello")
    public String hello(){
        return "Hello";
    }
}
