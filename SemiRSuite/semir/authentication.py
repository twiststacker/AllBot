from fastapi import Depends, HTTPException
from semir.auth import verify_token

@app.get("/protected")
def protected_endpoint(token: str = Depends(verify_token)):
    return {"message": "Access granted!"}
