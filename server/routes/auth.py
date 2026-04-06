import uuid
import bcrypt
from fastapi import Depends, HTTPException, APIRouter, Header

from database import get_db
from models.users import User
from pydantic_schemas.user_create import UserCreate
from sqlalchemy.orm import Session

from pydantic_schemas.user_login import UserLogin

import os
from dotenv import load_dotenv
import jwt

from middleware.auth_middleware import auth_middleware

load_dotenv()

router=APIRouter()

@router.post("/signup", status_code=201)
def signup_user(user: UserCreate, db: Session= (Depends(get_db))):
    user_db=db.query(User).filter(User.email==user.email).first()
    if(user_db):
        raise HTTPException(400, "User already exists")

    hashed_pw=bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    user_db= User(id=str(uuid.uuid4()), name=user.name, email=user.email, password=hashed_pw)
    db.add(user_db)
    db.commit()

    db.refresh(user_db)
    return user_db


@router.post("/login")
def login_user(user: UserLogin, db: Session= (Depends(get_db))):
    user_db=db.query(User).filter(User.email==user.email).first()
    if not user_db:
        raise HTTPException(400, "User not found")
    
    is_authentic=bcrypt.checkpw(user.password.encode(), user_db.password) # type: ignore

    if not is_authentic:
        raise HTTPException(400, "Invalid Password")
    
    token=jwt.encode({"id": user_db.id}, os.getenv("JWT_KEY"))
    return {"token": token, "user": user_db}


@router.get("/")
def get_user_data(db: Session=Depends(get_db), user_dict=Depends(auth_middleware)):
    user=db.query(User).filter(User.id==user_dict['uid']).first()
    if not user:
        raise HTTPException(404, "User not found!")
    return user