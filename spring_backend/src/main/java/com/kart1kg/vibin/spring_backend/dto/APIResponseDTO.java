package com.kart1kg.vibin.spring_backend.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class APIResponseDTO<T> {
    private final boolean success;
    private final String message;
    private final T data;
}
