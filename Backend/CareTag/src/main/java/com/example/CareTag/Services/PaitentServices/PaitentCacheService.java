package com.example.CareTag.Services.PaitentServices;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

@Service
public class PaitentCacheService {
    @Autowired
    @Qualifier("paitentTemplate")
    private RedisTemplate<String,String> paitentRedisTemplate;

    public static final String KEY = "ID:";

    public void saveCareTagId(String id,String careTagId){
        paitentRedisTemplate.opsForValue().set(KEY+id,careTagId);
    }

    public String getCareTagId(String id){
        return paitentRedisTemplate.opsForValue().get(KEY+id);
    }
}
