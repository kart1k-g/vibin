package com.kart1kg.vibin.spring_backend.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http){
        return http.
            authorizeHttpRequests(request -> request.
                requestMatchers("/api/login", "/api/signup").permitAll().
                anyRequest().authenticated()).
            httpBasic(Customizer.withDefaults()). //for api to enter credentials
            formLogin(form-> form.disable()).   //disables login via browser
            csrf(customizer -> customizer.disable()).
            sessionManagement(session-> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)).    //jwt auth is stateless
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