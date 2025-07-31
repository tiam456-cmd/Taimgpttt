# Use official Python 3.10 image as base
# Use official Python 3.10 image as base
FROM python:3.10-slim
ENV DISPLAY=:99

# Install system dependencies including Xvfb and any others you need
RUN apt-get update && apt-get install -y \
    xvfb \
    libxrender1 libxext6 libsm6 libx11-6 \
    gcc \
    python3-dev \
    libevdev-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /app

# Copy your requirements and install Python dependencies
COPY required.txt .
RUN pip install -r required.txt

# Copy the rest of your app code
COPY . .

# Expose the port your app uses (adjust if needed)
EXPOSE 8000

# Command to run Xvfb in the background and then start your app
CMD ["sh", "-c", "Xvfb :99 -screen 0 1024x768x24 && uvicorn gpt:app --host 0.0.0.0 --port 8000"]
