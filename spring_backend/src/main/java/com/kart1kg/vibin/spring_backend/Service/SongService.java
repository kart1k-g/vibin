package com.kart1kg.vibin.spring_backend.Service;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kart1kg.vibin.spring_backend.Models.Song;

@Service
public class SongService {

    public ResponseEntity<List<Song>> getAllSongs;

    public ResponseEntity<Song> uploadSong(Song song, MultipartFile thumbnail) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'uploadSong'");
    }
    
}
