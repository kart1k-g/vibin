package com.kart1kg.vibin.spring_backend.repo;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.kart1kg.vibin.spring_backend.Models.Song;

@Repository
public interface SongRepo extends JpaRepository<Song, UUID>{
    
}
