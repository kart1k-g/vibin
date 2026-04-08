package com.kart1kg.vibin.spring_backend.Service;

import java.util.UUID;

import org.apache.hc.client5.http.auth.InvalidCredentialsException;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.kart1kg.vibin.spring_backend.Exceptions.EmailAlreadyRegisteredException;
import com.kart1kg.vibin.spring_backend.Exceptions.UserNotFoundException;
import com.kart1kg.vibin.spring_backend.Models.Users;
import com.kart1kg.vibin.spring_backend.repo.UserRepo;

@Service
public class UserService {
    private final UserRepo repo;
    private final JWTService jwtService;
    private final BCryptPasswordEncoder encoder;
    private final AuthenticationManager authenticationManager;
    public UserService(
        UserRepo repo, 
        JWTService jwtService, 
        BCryptPasswordEncoder encoder,
        AuthenticationManager authenticationManager){
        this.repo=repo;
        this.jwtService=jwtService;
        this.encoder=encoder;
        this.authenticationManager=authenticationManager;
    }

    public String loginUser(Users user) throws UserNotFoundException, InvalidCredentialsException{
        Users dbUser=repo.findByEmail(user.getEmail());
        if(dbUser==null){
            throw new UserNotFoundException();
        }

        // Verify user credentials
        Authentication auth=authenticationManager.authenticate(
            new UsernamePasswordAuthenticationToken(
                user.getEmail(),
                user.getPassword()));
        
        if(!auth.isAuthenticated()){
            throw new InvalidCredentialsException();
        }

        // generate and return a new jwt token if authentication via password is successful
        return getToken(user);
    }

    public Users signupUser(Users user) throws EmailAlreadyRegisteredException {
        Users dbUser=repo.findByEmail(user.getEmail());
        if(dbUser!=null){
            throw new EmailAlreadyRegisteredException();
        }

        // set user info
        // password encryption will be done by bcrypt
        dbUser=new Users(UUID.randomUUID(), user.getName(), user.getEmail(), encoder.encode(user.getPassword()));

        // save user info with encrypted password to db
        repo.save(dbUser);
        
        user.setUserId(dbUser.getUserId());
        user.setPassword("");
        return user;
    }

    public Users getUser() {
        String email=(String) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Users user=repo.findByEmail(email);
        user.setPassword(null);
        return user;
    }
    
    public String getToken(Users user){
        return jwtService.getToken(user.getEmail());
    }
}
