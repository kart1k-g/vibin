package com.kart1kg.vibin.spring_backend.Service;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.kart1kg.vibin.spring_backend.Models.Song;

@Service
public class CloudinaryService {
    private final Cloudinary cloudinary;
    public CloudinaryService(Cloudinary cloudinary){
        this.cloudinary=cloudinary;
    }

    public String uploadThumbnailImage(MultipartFile thumbnail, UUID id) throws IOException{
        var map=cloudinary.uploader().upload(thumbnail.getBytes(), Map.of(
            "folder", "thumbnails/"+id.toString()
        ));
        return (String)map.get("url");
    }
    
    public String uploadAudio(MultipartFile audio, UUID id) throws IOException{
        var map=cloudinary.uploader().upload(audio.getBytes(), Map.of(
            "folder", "audios/"+id.toString(),
            "resource_type", "auto"
        ));
        return (String)map.get("url");
    }

    public void removeUploadedSong(Song song) {
        removUploadedAudio(song);
        removUploadedThumbnail(song);
    }
    
    public void removUploadedAudio(Song song){
        try {
            if(song.getAudioUrl()!=null){
                String path="audios/"+song.getId().toString();
                cloudinary.api().deleteResourcesByPrefix(path, Map.of("resource_type", "video"));
                cloudinary.api().deleteFolder(path, null);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    
    public void removUploadedThumbnail(Song song){
        try {
            if(song.getThumbnailUrl()!=null){
                String path="thumbnails/"+song.getId().toString();
                cloudinary.api().deleteResourcesByPrefix(path, null);
                cloudinary.api().deleteFolder(path, null);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
