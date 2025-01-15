FROM python:3.11-slim

WORKDIR /app

COPY ./API .

RUN pip install --upgrade pip

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

# Command to run the FastAPI application using uvicorn
CMD ["uvicorn", "myapi:app", "--host", "0.0.0.0", "--port", "8000"]