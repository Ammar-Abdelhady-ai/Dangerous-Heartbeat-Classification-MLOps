FROM python:3.11-slim

WORKDIR /app

COPY ./API .
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

CMD ["uvicorn", "myapi:app", "--host", "0.0.0.0", "--port", "8000"]