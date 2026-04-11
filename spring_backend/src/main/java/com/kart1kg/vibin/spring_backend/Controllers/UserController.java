package com.kart1kg.vibin.spring_backend.Controllers;

import org.apache.hc.client5.http.auth.InvalidCredentialsException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kart1kg.vibin.spring_backend.Exceptions.EmailAlreadyRegisteredException;
import com.kart1kg.vibin.spring_backend.Exceptions.UserNotFoundException;
import com.kart1kg.vibin.spring_backend.Models.Users;
import com.kart1kg.vibin.spring_backend.Service.UserService;
import com.kart1kg.vibin.spring_backend.dto.APIResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.ErrorResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.LoginResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.ResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.SignupResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.UserDetailsResponseDTO;


@RestController
@RequestMapping("/api/auth")
public class UserController {
    private final UserService service;
    public UserController(UserService service){
        this.service=service;
    }

    @PostMapping("/login")
    public ResponseEntity<ResponseDTO> loginUser(@RequestBody Users user) {
        try {
            LoginResponseDTO dto=service.loginUser(user);
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    "Success", 
                    dto), 
                HttpStatus.OK);
        } catch (UserNotFoundException e) {
            return new ResponseEntity<>(
                new ErrorResponseDTO("User with email "+user.getEmail()+" not found"), 
                HttpStatus.NOT_FOUND);
        } catch(InvalidCredentialsException e){
            return new ResponseEntity<>(
                new ErrorResponseDTO("Invalid Credentials"), 
                HttpStatus.UNAUTHORIZED);
        } catch(Exception e){
            return new ResponseEntity<>(
                new ErrorResponseDTO("An error occured. Retry\n"+e.toString()), 
                HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/signup")
    public ResponseEntity<ResponseDTO> signupUser(@RequestBody Users user) {
        try {
            SignupResponseDTO dto=service.signupUser(user);
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    "Success", 
                    dto), 
                HttpStatus.CREATED);
        } catch(EmailAlreadyRegisteredException e){
            return new ResponseEntity<>(
                new ErrorResponseDTO(user.getEmail()+" is already registered"), 
                HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            return new ResponseEntity<>(
                new ErrorResponseDTO("An error occured. Retry\n"+e.toString()), 
                HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/")
    public ResponseEntity<APIResponseDTO<UserDetailsResponseDTO>> getUser() {
        // Secuirty filters are up
        // Request will reach this controller only if token sent was valid and user exists in the db

        UserDetailsResponseDTO dto=service.getUser();
        return new ResponseEntity<>(
            new APIResponseDTO<>(
                "Success", 
                dto), 
            HttpStatus.OK);
    }
    
}
