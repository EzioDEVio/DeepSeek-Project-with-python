# Stage 1: Build the application
FROM python:3.9-slim AS builder

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Stage 2: Create the final image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create a non-root user and switch to it
RUN useradd -m appuser
USER appuser
WORKDIR /home/appuser

# Copy installed dependencies from the builder stage
COPY --from=builder /usr/local/lib/python3.9/site-packages /home/appuser/.local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin/gunicorn /home/appuser/.local/bin/gunicorn
COPY --from=builder /app /home/appuser/app

# Ensure scripts in .local are usable
ENV PATH=/home/appuser/.local/bin:$PATH

# Expose the port the app runs on
EXPOSE 5000

# Set the working directory
WORKDIR /home/appuser/app

# Run the application using gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]