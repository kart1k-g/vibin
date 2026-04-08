package com.kart1kg.vibin.spring_backend.dto;

import com.kart1kg.vibin.spring_backend.Models.Users;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SignupResponseDTO {
    private final Users user;
    private final String token;
}
