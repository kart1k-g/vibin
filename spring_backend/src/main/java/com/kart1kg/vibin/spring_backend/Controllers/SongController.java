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
import com.kart1kg.vibin.spring_backend.dto.APIResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.ErrorResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.ResponseDTO;
import com.kart1kg.vibin.spring_backend.dto.SongResponseDTO;


@RestController
@RequestMapping("/api/song")
public class SongController {
    private final SongService service;
    public SongController(SongService service){
        this.service=service;
    }

    @GetMapping("/list")
    public ResponseEntity<APIResponseDTO<List<SongResponseDTO>>> getAllSongs() {
        List<SongResponseDTO> dto=service.getAllSongs();
        return new ResponseEntity<>(
            new APIResponseDTO<>(
                "Success", 
                dto),
            HttpStatus.OK);
    }

    @PostMapping("/upload")
    public ResponseEntity<ResponseDTO> uploadSong(@RequestPart Song song,
        @RequestPart("audio") MultipartFile audio,
        @RequestPart("thumbnail") MultipartFile thumbnail) {
        try {
            SongResponseDTO dto=service.uploadSong(song, audio, thumbnail);
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    "Success",
                    dto
                ),
                HttpStatus.CREATED);
        } catch (SongUploadException e) {
            return new ResponseEntity<>(
                new ErrorResponseDTO(
                    e.getMessage() == null ? "Error uploading song" : e.getMessage()),
                HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }   

    @DeleteMapping("/{id}")
    public ResponseEntity<ResponseDTO> postMethodName(@PathVariable UUID id) {
        try {
            service.deleteSongById(id);
            return new ResponseEntity<>(
                new APIResponseDTO<>(
                    "Song deleted successfully", 
                    id.toString()),
                HttpStatus.OK);
        } catch (SongNotFoundException e) {
            return new ResponseEntity<>(
                new ErrorResponseDTO("Song with id "+id.toString()+" not found"),
                HttpStatus.NOT_FOUND);
        }   
    }
    
}
