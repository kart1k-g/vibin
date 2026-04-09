package com.kart1kg.vibin.spring_backend.dto;

import java.util.UUID;

import com.kart1kg.vibin.spring_backend.Models.Users;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class LoginResponseDTO {
    private final UUID userId;
    private final String name;
    private final String email;
    private final String token;

    public static LoginResponseDTO modelToDTO(Users user, String token){
        return new LoginResponseDTO(
            user.getUserId(), 
            user.getName(), 
            user.getEmail(),
            token);
    }
}
