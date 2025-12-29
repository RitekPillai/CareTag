package com.example.CareTag.Services;

import com.example.CareTag.DTOs.LoginResponseDTO;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
@Service
public class TokenExchangeService {private final Map<String, LoginResponseDTO> exchangeCache = new ConcurrentHashMap<>();
    public String createExchangeCode(LoginResponseDTO data) {
        String code = UUID.randomUUID().toString();
        exchangeCache.put(code, data);

        new java.util.Timer().schedule(new java.util.TimerTask() {
            @Override
            public void run() {
                exchangeCache.remove(code);
            }
        }, 5 * 60 * 1000);

        return code;
    }

    public LoginResponseDTO consumeCode(String code) {
        return exchangeCache.remove(code);
    }

}
