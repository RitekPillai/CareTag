package com.example.CareTag.configs;

import com.example.CareTag.DTOs.authDTOs.PendingUser;
import com.example.CareTag.Models.Paitent.Patient;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.geo.GeoJsonPoint;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.GenericToStringSerializer;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

@Configuration
public class RedisConfig {

  @Bean(name = "pendingUserRedisTemplate")
  public RedisTemplate<String, PendingUser> redisTemplate(RedisConnectionFactory redisConnectionFactory) {
    RedisTemplate<String, PendingUser> redisTemplate = new RedisTemplate<>();
    redisTemplate.setConnectionFactory(redisConnectionFactory);

    /// the redis key is save in binary to save in normal text we have to implement
    /// this so that is is easy to fetch the data
    redisTemplate.setKeySerializer(new StringRedisSerializer());
    redisTemplate.setHashKeySerializer(new StringRedisSerializer());

    ObjectMapper objectMapper = new ObjectMapper();
    /// this is because jackson library does not know how to handle the
    /// Localdatetime one used in the pendingUser class
    objectMapper.registerModule(new JavaTimeModule());
    objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
    /// converting java obj to json and json to obj
    redisTemplate.setValueSerializer(new GenericJackson2JsonRedisSerializer());
    return redisTemplate;
  }

  @Bean(name = "otpRedisTemplate")
  public RedisTemplate<String, String> otpRedisTemplate(RedisConnectionFactory factory) {
    RedisTemplate<String, String> template = new RedisTemplate<>();
    template.setConnectionFactory(factory);

    template.setKeySerializer(new StringRedisSerializer());
    template.setValueSerializer(new StringRedisSerializer());

    return template;
  }

  @Bean(name = "patientProfile")
  public RedisTemplate<Long, Patient> paitentRedisTemplate(RedisConnectionFactory factory) {
    RedisTemplate<Long, Patient> template = new RedisTemplate<>();
    template.setConnectionFactory(factory);

    ObjectMapper objectMapper = new ObjectMapper();

    objectMapper.addMixIn(GeoJsonPoint.class, GeoJsonPointMixin.class);

    Jackson2JsonRedisSerializer<Patient> serializer = new Jackson2JsonRedisSerializer<>(objectMapper, Patient.class);
    template.setKeySerializer(new GenericToStringSerializer<>(Long.class));
    template.setValueSerializer(serializer);

    return template;
  }

  @Bean(name = "recentActivityTemplate")
  public RedisTemplate<String, Object> recentActivityTemplate(RedisConnectionFactory factory) {
    RedisTemplate<String, Object> template = new RedisTemplate<>();
    ObjectMapper objectMapper = new ObjectMapper();
    objectMapper.registerModule(new JavaTimeModule());
    objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
    template.setConnectionFactory(factory);
    template.setKeySerializer(new StringRedisSerializer());
    GenericJackson2JsonRedisSerializer jsonSerializer = new GenericJackson2JsonRedisSerializer(objectMapper);
    template.setValueSerializer(jsonSerializer);
    template.afterPropertiesSet();
    return template;
  }

}
