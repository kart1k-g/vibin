package com.kart1kg.vibin.spring_backend.Controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kart1kg.vibin.spring_backend.Exceptions.EmailAlreadyRegisteredException;
import com.kart1kg.vibin.spring_backend.Exceptions.UserNotFoundException;
import com.kart1kg.vibin.spring_backend.Models.Users;
import com.kart1kg.vibin.spring_backend.Service.UserService;


@RestController
@RequestMapping("/api")
public class UserController {
    private final UserService service;
    public UserController(UserService service){
        this.service=service;
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody Users user) {
        System.out.println("login");
        try {
            String token=service.loginUser(user);
            return new ResponseEntity<>(token, HttpStatus.OK);
        } catch (UserNotFoundException e) {
            return new ResponseEntity<>("User with email "+user.getEmail()+" not found", HttpStatus.NOT_FOUND);
        } catch(Exception e){
            return new ResponseEntity<>("An error occured. Retry\n"+e.toString(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/signup")
    public ResponseEntity<?> signupUser(@RequestBody Users user) {
        System.out.println("signup");
        try {
            Users created=service.signupUser(user);
            return new ResponseEntity<>(created, HttpStatus.OK);
        } catch(EmailAlreadyRegisteredException e){
            return new ResponseEntity<>(user.getEmail()+" is already registered", HttpStatus.BAD_REQUEST);
        } 
        catch (Exception e) {
            return new ResponseEntity<>("An error occured. Retry\n"+e.toString(), HttpStatus.INTERNAL_SERVER_ERROR);
        }   
    }
    
}
