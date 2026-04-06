package com.kart1kg.vibin.spring_backend.config;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.cloudinary.Cloudinary;

@Configuration
public class CloudinaryConfiguration {

    @Bean
    public Cloudinary cloudinary(
        @Value("${cloudinary.cloud_name}") String cloudName,
        @Value("${cloudinary.api_key}") String key,
        @Value("${cloudinary.api_secret}") String secret){


        return new Cloudinary(Map.of(
            "cloud_name", cloudName,
            "api_key", key,
            "api_secret", secret
        ));
    }   

}
