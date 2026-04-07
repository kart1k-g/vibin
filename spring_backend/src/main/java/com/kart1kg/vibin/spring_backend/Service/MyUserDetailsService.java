package com.kart1kg.vibin.spring_backend.Service;

import java.util.UUID;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kart1kg.vibin.spring_backend.Models.UserPrincipal;
import com.kart1kg.vibin.spring_backend.Models.Users;
import com.kart1kg.vibin.spring_backend.repo.UserRepo;

@Service
public class MyUserDetailsService implements UserDetailsService {
    private final UserRepo repo;
    public MyUserDetailsService(UserRepo repo){
        this.repo=repo;
    }

    @Override
    public UserDetails loadUserByUsername(String userID) throws UsernameNotFoundException {
        Users user=repo.findById(UUID.fromString(userID)).orElse(null);
        if(user==null){
            throw new UsernameNotFoundException(userID);
        }
        return new UserPrincipal(user);
    }
    
}
