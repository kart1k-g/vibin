package com.kart1kg.vibin.spring_backend.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;

@Service
public class CloudinaryService {
    private final Cloudinary cloudinary;
    private final Map<String, String> thumbnailOptions, songOptions;
    public CloudinaryService(Cloudinary cloudinary){
        this.cloudinary=cloudinary;
        thumbnailOptions = new HashMap<>();
        thumbnailOptions.put("folder", "thumbnails");
        songOptions = new HashMap<>();
        songOptions.put("folder", "songs");
        songOptions.put("resource_type", "auto");
    }

    public String uploadThumbnailImage(MultipartFile thumbnail) throws IOException{
        var map=cloudinary.uploader().upload(thumbnail.getBytes(), thumbnailOptions);
        return (String)map.get("url");
    }
    
    public String uploadSong(MultipartFile song) throws IOException{
        var map=cloudinary.uploader().upload(song.getBytes(), songOptions);
        return (String)map.get("url");
    }
}
