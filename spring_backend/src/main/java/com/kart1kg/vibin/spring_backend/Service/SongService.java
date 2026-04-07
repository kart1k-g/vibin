package com.kart1kg.vibin.spring_backend.Service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kart1kg.vibin.spring_backend.Exceptions.SongNotFoundException;
import com.kart1kg.vibin.spring_backend.Exceptions.SongUploadException;
import com.kart1kg.vibin.spring_backend.Models.Song;
import com.kart1kg.vibin.spring_backend.repo.SongRepo;

@Service
public class SongService {
    private final SongRepo repo;
    private final CloudinaryService cloudinaryService;
    public SongService(SongRepo repo, CloudinaryService cloudinaryService){
        this.repo=repo;
        this.cloudinaryService=cloudinaryService;
    }

    public List<Song> getAllSongs(){
        return repo.findAll();
    }

    public Song uploadSong(Song song ,MultipartFile audio, MultipartFile thumbnail) throws SongUploadException {
        try {
            song.setId(UUID.randomUUID());
            String audioUrl=cloudinaryService.uploadAudio(audio, song.getId());
            song.setAudioUrl(audioUrl);

            String thumbnailUrl=cloudinaryService.uploadThumbnailImage(thumbnail, song.getId());
            song.setThumbnailUrl(thumbnailUrl);

            repo.save(song);
            return song;
        } catch (IOException e) {
            cloudinaryService.removeUploadedSong(song);
            throw new SongUploadException();
        }
    }

    public void deleteSongById(UUID id) throws SongNotFoundException{
        Song song=repo.findById(id).orElse(null);
        if(song==null){
            throw new SongNotFoundException();
        }
        repo.delete(song);
        cloudinaryService.removeUploadedSong(song);
    }
}
