# שלב 1: שלב הבנייה
FROM python:3.9-slim AS builder

RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# שלב 2: שלב הריצה
FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /install /usr/local

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]

