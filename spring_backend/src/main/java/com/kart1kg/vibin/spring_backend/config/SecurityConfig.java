package com.kart1kg.vibin.spring_backend.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.kart1kg.vibin.spring_backend.config.entryPoint.JWTAuthEntryPoint;
import com.kart1kg.vibin.spring_backend.config.filter.JwtFilter;

import jakarta.servlet.DispatcherType;


@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, 
        JwtFilter jwtFilter, 
        JWTAuthEntryPoint jwtAuthEntryPoint){
        
        // only way to authenticate is via login/signup route and get a jwt token
        // all other resources require jwt token auth

        return http.
            authorizeHttpRequests(request -> request.
                dispatcherTypeMatchers(DispatcherType.ERROR, DispatcherType.FORWARD).permitAll(). //for internal request forwarding
                requestMatchers("/api/auth/login", "/api/auth/signup").permitAll().
                anyRequest().authenticated()).
            httpBasic(basic -> basic.disable()).
            formLogin(form-> form.disable()).
            csrf(customizer -> customizer.disable()).
            sessionManagement(session-> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)).    //jwt auth is stateless
            addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class).
            exceptionHandling(ex-> ex.authenticationEntryPoint(jwtAuthEntryPoint)). //auth exceptions will be handled by this handler
            build();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config){
        return config.getAuthenticationManager();
    }
    
    @Bean
    public AuthenticationProvider authenticationProvider(
            BCryptPasswordEncoder encoder, 
            UserDetailsService userDetailsService){
        DaoAuthenticationProvider provider=new DaoAuthenticationProvider(userDetailsService);
        provider.setPasswordEncoder(encoder);
        return provider;
    }

    @Bean
    public BCryptPasswordEncoder getBCryptPasswordEncoder(
        @Value("${bcrypt.password.encoder.rounds}") int rounds){
        return new BCryptPasswordEncoder(rounds);
    }

}