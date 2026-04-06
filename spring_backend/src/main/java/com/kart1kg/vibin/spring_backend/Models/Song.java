package com.kart1kg.vibin.spring_backend.Models;

import java.util.UUID;

import org.hibernate.annotations.UuidGenerator;
import org.springframework.data.annotation.Id;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import lombok.Data;

@Data
@Entity
public class Song{
    @Id
    @GeneratedValue()
    @UuidGenerator
    @Column(name="song_id")
    private UUID id;
    
    @Column(name="song_url")
    private String songUrl;

    @Column(name="thumbnail_url")
    private String thumbnailUrl;

    @Column(name="artist_name")
    private String artist;

    @Column(name="song_name")
    private String name;

    private String hexcode;
}
