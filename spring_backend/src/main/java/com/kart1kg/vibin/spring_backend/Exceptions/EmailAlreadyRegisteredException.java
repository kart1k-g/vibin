package com.kart1kg.vibin.spring_backend.Exceptions;

public class EmailAlreadyRegisteredException extends Exception {

    public EmailAlreadyRegisteredException() {
    }

    public EmailAlreadyRegisteredException(String message) {
        super(message);
    }
    
}
