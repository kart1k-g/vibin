package com.kart1kg.vibin.spring_backend.dto;

import com.kart1kg.vibin.spring_backend.Models.Users;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class UserDetailsResponseDTO {
    private final Users user;
}
