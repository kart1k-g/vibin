package com.kart1kg.vibin.spring_backend.Controllers;

import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kart1kg.vibin.spring_backend.Exceptions.SongNotFoundException;
import com.kart1kg.vibin.spring_backend.Exceptions.SongUploadException;
import com.kart1kg.vibin.spring_backend.Models.Song;
import com.kart1kg.vibin.spring_backend.Service.SongService;


@RestController
@RequestMapping("/song")
public class SongController {
    private final SongService service;
    public SongController(SongService service){
        this.service=service;
    }

    @GetMapping("/list")
    public ResponseEntity<List<Song>> getAllSongs() {
        System.out.println("Listed");
        return new ResponseEntity<>(service.getAllSongs(), HttpStatus.OK);
    }

    @PostMapping("/upload")
    public ResponseEntity<?> uploadSong(@RequestPart Song song,
        @RequestPart("audio") MultipartFile audio,
        @RequestPart("thumbnail") MultipartFile thumbnail) {
        try {
            return new ResponseEntity<>(service.uploadSong(song, audio, thumbnail), HttpStatus.OK);
        } catch (SongUploadException e) {
            return new ResponseEntity<>("Error uploading song", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @DeleteMapping("/{id}")
    public ResponseEntity<String> postMethodName(@PathVariable UUID id) {
        try {
            service.deleteSongById(id);
            return new ResponseEntity<>("Song with id "+id.toString()+" deleted successfully", HttpStatus.OK);
        } catch (SongNotFoundException e) {
            return new ResponseEntity<>("Song with id "+id.toString()+" not found", HttpStatus.NOT_FOUND);
        }   
    }
    
}
