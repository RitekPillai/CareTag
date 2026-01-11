package com.example.CareTag.Services.AuthServices;

import com.example.CareTag.DTOs.authDTOs.PendingUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class CacheService {
    @Autowired

    /// so redistemplate is used for both otp and pendinguser so it cant differentate it between so quantifyier is uesed to classfiy between this 2 beans
    @Qualifier("pendingUserRedisTemplate")
    private RedisTemplate<String,PendingUser> pendingUserRedisTemplate;
    @Autowired
    @Qualifier("otpRedisTemplate")
    private RedisTemplate<String,String> otpRedisTemplate;

    public static final String CACHE_KEY = "PENDING_USERS:";

    public static final String OTP_KEY = "OTP:";

    public void savingOtp(String email,String otp){
        otpRedisTemplate.opsForValue().set(OTP_KEY+email,otp,Duration.ofMinutes(5));

    }
    public void deleteOtp(String email){
        otpRedisTemplate.delete(OTP_KEY+email);
    }
    public String fetchotp(String email){
        return otpRedisTemplate.opsForValue().get(OTP_KEY+email);
    }

    public void savingPendingUser(PendingUser pendingUser){
        pendingUserRedisTemplate.opsForValue().set(CACHE_KEY+pendingUser.getEmail(),pendingUser, Duration.ofHours(24));
    }

    public PendingUser getPendingUser(String email){
        return pendingUserRedisTemplate.opsForValue().get(CACHE_KEY+email);
    }

    public void removeFromCache(String email){
        pendingUserRedisTemplate.delete(CACHE_KEY+email);
    }
}
