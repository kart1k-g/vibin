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
import com.kart1kg.vibin.spring_backend.dto.LoginResponseDTO;
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
    public ResponseEntity<APIResponseDTO<LoginResponseDTO>> loginUser(@RequestBody Users user) {
        try {
            LoginResponseDTO dto=new LoginResponseDTO(service.loginUser(user));
            return ResponseEntity.ok(
                new APIResponseDTO<>(true, "Success", dto));
        } catch (UserNotFoundException e) {
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    false,
                    "User with email "+user.getEmail()+" not found",
                    null), 
                HttpStatus.NOT_FOUND);
        } catch(InvalidCredentialsException e){
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    false,
                    "Invalid Credentials",
                    null), 
                HttpStatus.UNAUTHORIZED);
        } catch(Exception e){
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    false,
                    "An error occured. Retry\n"+e.toString(),
                    null), 
                HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/signup")
    public ResponseEntity<APIResponseDTO<SignupResponseDTO>> signupUser(@RequestBody Users user) {
        try {
            Users created=service.signupUser(user);
            String token=service.getToken(user);
            SignupResponseDTO dto=new SignupResponseDTO(created, token);
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    true, 
                    "Success", 
                    dto), 
                HttpStatus.OK);
        } catch(EmailAlreadyRegisteredException e){
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    false, 
                    user.getEmail()+" is already registered", 
                    null), 
                HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    false, 
                    "An error occured. Retry\n"+e.toString(), 
                    null), 
                HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/")
    public ResponseEntity<APIResponseDTO<UserDetailsResponseDTO>> getUser() {
        // Secuirty filters are up
        // Request will reach this controller only if token sent was valid and user exists in the db

        UserDetailsResponseDTO dto=new UserDetailsResponseDTO(service.getUser());
        return new ResponseEntity<>(
            new APIResponseDTO<>(
                true, 
                "Success", 
                dto), 
            HttpStatus.OK);
    }
    
}
