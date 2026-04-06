package com.kart1kg.vibin.spring_backend.Controllers;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

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
        return service.getAllSongs;
    }

    @PostMapping("/upload")
    public ResponseEntity<Song> uploadSong(@RequestBody Song song, @RequestBody MultipartFile thumbnail) {
        System.out.println("Uploaded");
        return service.uploadSong(song, thumbnail);
    }   
}
