from fastapi import HTTPException, Header
import jwt
import os
from dotenv import load_dotenv

load_dotenv()

def auth_middleware(x_auth_token=Header()):
    try:
        # get token from the header
        if(not x_auth_token):
            raise HTTPException(401, "No auth token, Access Denied!")

        # decode the token
        decoded_token=jwt.decode(x_auth_token, os.getenv("JWT_KEY"), algorithms="HS256")
        if not decoded_token:
            raise HTTPException(401, "Token verification failed, Authorization Denied!")

        # check if token is valid

        uid=decoded_token.get("id")
        return {"uid": uid, "token": x_auth_token}
        # return the user info
    except jwt.PyJWTError:
        raise HTTPException(401, "Invalid jwt token, Authosization failed")
