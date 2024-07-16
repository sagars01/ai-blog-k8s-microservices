from fastapi import FastAPI

app = FastAPI()

@app.get("/api/hello")
def read_root():
    return {"message": "Hello from Python API!"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)