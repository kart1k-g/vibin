package com.kart1kg.vibin.spring_backend.Models;

import java.util.UUID;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity
public class Song{
    @Id
    @Column(name="song_id")
    private UUID id;
    
    @Column(name="audio_url")
    private String audioUrl;

    @Column(name="thumbnail_url")
    private String thumbnailUrl;

    @Column(name="artist_name")
    private String artist;

    @Column(name="song_name")
    private String name;

    private String hexcode;
}
