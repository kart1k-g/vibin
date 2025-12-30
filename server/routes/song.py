import uuid
from dotenv import load_dotenv
from fastapi import APIRouter, Depends, File, Form, UploadFile
import cloudinary
import cloudinary.uploader
import os
from sqlalchemy.orm import Session
from middleware.auth_middleware import auth_middleware
from database import get_db
from models.song import Song

load_dotenv()
router =APIRouter()

cloudinary.config( 
    cloud_name = os.getenv("CLOUDINARY_CLOUD_NAME"), 
    api_key = os.getenv("CLOUDINARY_API_KEY"), 
    api_secret = os.getenv("CLOUDINARY_API_SECRET"), 
    secure=True
)

@router.post("/upload", status_code=201)
def upload_song(
        song: UploadFile= File(...), 
        thumbnail: UploadFile= File(...), 
        artist: str= Form(...), 
        song_name: str= Form(...),
        hex_code:  str= Form(...),
        db: Session= Depends(get_db), # type: ignore
        auth_dict= Depends(auth_middleware),# type: ignore
    ): 
    song_id= str(uuid.uuid4())
    song_res= cloudinary.uploader.upload(song.file, folder= f'songs/{song_id}', resource_type="auto")
    thumbnail_res=cloudinary.uploader.upload(thumbnail.file,  folder= f'thumbnails/{song_id}', resource_type="image")
    new_song=Song(
        song_name= song_name,
        song_url= song_res['url'],
        thumbnail_url= thumbnail_res['url'],
        id= song_id,
        artist= artist,
        hex_code= hex_code
    )
    db.add(new_song)
    db.commit()
    db.refresh(new_song)
    return new_song

@router.get("/list")
def list_songs(db: Session=Depends(get_db), auth_details=Depends(auth_middleware)):
    songs= db.query(Song).all()
    return songs