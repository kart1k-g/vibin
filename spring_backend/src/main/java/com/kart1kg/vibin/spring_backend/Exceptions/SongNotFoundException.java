package com.kart1kg.vibin.spring_backend.Exceptions;

public class SongNotFoundException extends Exception{

    public SongNotFoundException() {
    }

    public SongNotFoundException(String message) {
        super(message);
    }
    
}
