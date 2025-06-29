# שלב ראשון: התקנת התשתיות
FROM python:3.9-slim

# התקנת חבילות מערכת שדרושות כדי להתקין mysqlclient
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    build-essential \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# יצירת תיקייה לאפליקציה
WORKDIR /app

# העתקת הקבצים
COPY requirements.txt .

# התקנת התלויות של פייתון
RUN pip install --no-cache-dir -r requirements.txt

# העתקת שאר קבצי הפרויקט
COPY . .

# חשיפת פורט
EXPOSE 5000

# הרצת האפליקציה
CMD ["python", "app.py"]

