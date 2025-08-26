# syntax=docker/dockerfile:1
FROM python:3.11-slim

WORKDIR /app

# Install system deps (optional)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY app/ /app/

# Healthcheck (optional)
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s CMD curl -fsS http://127.0.0.1:5000/health || exit 1

EXPOSE 5000

# Use gunicorn in production
CMD ["gunicorn", "-b", "0.0.0.0:5000", "main:app"]
