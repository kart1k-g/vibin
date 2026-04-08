package com.kart1kg.vibin.spring_backend.dto;

import java.util.UUID;

import com.kart1kg.vibin.spring_backend.Models.Song;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SongResponseDTO {
    private final UUID id;   
    private final String audioUrl;
    private final String thumbnailUrl;
    private final String artist;
    private final String name;
    private final String hexcode;

    public static SongResponseDTO modelToDTO(Song song){
        return new SongResponseDTO(
            song.getId(), 
            song.getAudioUrl(), 
            song.getThumbnailUrl(), 
            song.getArtist(), 
            song.getName(), 
            song.getHexcode());           
    }
}
