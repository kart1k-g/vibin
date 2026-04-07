package com.kart1kg.vibin.spring_backend.Exceptions;

public class UserNotFoundException extends Exception{

    public UserNotFoundException() {
    }

    public UserNotFoundException(String message) {
        super(message);
    }
    
}
