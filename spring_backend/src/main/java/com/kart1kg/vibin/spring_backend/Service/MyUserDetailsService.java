package com.kart1kg.vibin.spring_backend.Service;

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
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Users user=repo.findByEmail(email);
        if(user==null){
            throw new UsernameNotFoundException(email);
        }
        return new UserPrincipal(user);
    }
    
}
