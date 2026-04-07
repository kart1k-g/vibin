package com.kart1kg.vibin.spring_backend.Service;

import org.springframework.stereotype.Service;

import com.kart1kg.vibin.spring_backend.Exceptions.EmailAlreadyRegisteredException;
import com.kart1kg.vibin.spring_backend.Exceptions.UserNotFoundException;
import com.kart1kg.vibin.spring_backend.Models.Users;

@Service
public class UserService {

    public String loginUser(Users user) throws UserNotFoundException{
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'loginUser'");
    }

    public Users signupUser(Users user) throws EmailAlreadyRegisteredException {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'signupUser'");
    }
    
}
