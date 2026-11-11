FROM python:3.11-slim

# system deps — psutil এর জন্য gcc লাগে
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# servers ফোল্ডার আগে থেকে বানিয়ে রাখি
RUN mkdir -p servers static/images

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "1", "--timeout", "120", "--keep-alive", "5", "app:app"]