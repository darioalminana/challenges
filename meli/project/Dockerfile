FROM python:3.13.0-alpine3.20

WORKDIR /app
COPY src .
COPY requirements.txt requirements.txt 

RUN pip install --root-user-action=ignore --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

