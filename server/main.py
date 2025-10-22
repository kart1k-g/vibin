from fastapi import FastAPI
from routes import auth
from models.base import Base
import database

app= FastAPI()
app.include_router(auth.router, prefix="/auth")


Base.metadata.create_all(database.engine) 