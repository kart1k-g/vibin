package com.kart1kg.vibin.spring_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ErrorResponseDTO implements ResponseDTO{
    private final String message;
}
