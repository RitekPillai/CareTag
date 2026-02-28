package com.example.CareTag.Services.PaitentServices;

import com.example.CareTag.Models.Paitent.Patient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class PaitentCacheService {

    @Autowired
    @Qualifier("patientProfile")
    private RedisTemplate<Long, Patient> patientProfiletRedisTemplate;





    public void savePatientProfile(Patient patient){
        patientProfiletRedisTemplate.opsForValue().set(patient.getId(),patient, Duration.ofHours(24));
    }

    public void deleteProfileCache(Long id) {
        patientProfiletRedisTemplate.delete(id);
    }
    public Patient getPatientProfile(Long id){
     return   patientProfiletRedisTemplate.opsForValue().get(id);
    }
}
