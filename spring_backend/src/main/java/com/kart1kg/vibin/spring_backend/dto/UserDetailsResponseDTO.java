package com.kart1kg.vibin.spring_backend.dto;

import java.util.UUID;

import com.kart1kg.vibin.spring_backend.Models.Users;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class UserDetailsResponseDTO {
    private final UUID userId;
    private final String name;
    private final String email;

    public static UserDetailsResponseDTO modelToDTO(Users user){
        return new UserDetailsResponseDTO(
            user.getUserId(), 
            user.getName(), 
            user.getEmail());
    }
}
