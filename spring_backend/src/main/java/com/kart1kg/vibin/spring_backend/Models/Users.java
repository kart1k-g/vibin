package com.kart1kg.vibin.spring_backend.Models;

import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data
public class Users {
    @Id
    @Column(name="user_id")
    private UUID userId;

    private String name;
    private String email;
    private String password;
}
