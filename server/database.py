from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

DATABASE_URL='postgresql://postgres:12345678@localhost:5432/vibin_db'
engine=create_engine(DATABASE_URL)

SessionLocal=sessionmaker(autocommit= False, autoflush=False, bind=engine)
db=SessionLocal()

def get_db():
    db=SessionLocal()
    try:
        yield db
    finally:
        db.close()