package com.kart1kg.vibin.spring_backend.config.filter;

import java.io.IOException;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.kart1kg.vibin.spring_backend.Service.JWTService;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class JwtFilter extends OncePerRequestFilter{
    private final JWTService jwtService;
    private final UserDetailsService userDetailsService;
    public JwtFilter(JWTService jwtService, UserDetailsService userDetailsService){
        this.jwtService=jwtService;
        this.userDetailsService=userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        String authHeader=request.getHeader("Authorization");

        if(authHeader!=null && authHeader.startsWith("Bearer ")){
            // Sample header: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJLIiwiaWF0IjoxNzc1MjI4MjEzLCJleHAiOjE3NzUyMzAwMTN9.KJumAEcWxO2B9Dl0Q6M6_RJ0FwYqqmNVtBbynim6t5o
            String token=authHeader.substring(7);
            String email=jwtService.extractEmail(token);

            // user exists and the request is not yet verified by any previous filter
            if(email!=null && SecurityContextHolder.getContext().getAuthentication()==null){
                // fetching user details from the db
                UserDetails userDetails=userDetailsService.loadUserByUsername(email);

                // if the token is valid
                if(jwtService.validateToken(token, userDetails)){
                    UsernamePasswordAuthenticationToken authToken=new UsernamePasswordAuthenticationToken(email, null, userDetails.getAuthorities());
                    authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                    
                    // set authentication status and pass auth token to the next filter
                    SecurityContextHolder.getContext().setAuthentication(authToken);
                }
            }
        }
        filterChain.doFilter(request, response);
    }
    
}
