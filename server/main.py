from fastapi import FastAPI
from routes import auth
from models.base import Base
import database
from routes import song

app= FastAPI()
app.include_router(auth.router, prefix="/auth")
app.include_router(song.router, prefix="/song")


Base.metadata.create_all(database.engine) 