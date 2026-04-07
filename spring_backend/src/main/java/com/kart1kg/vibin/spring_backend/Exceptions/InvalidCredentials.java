package com.kart1kg.vibin.spring_backend.Exceptions;

public class InvalidCredentials extends Exception {

    public InvalidCredentials() {
    }

    public InvalidCredentials(String message) {
        super(message);
    }
    
}
