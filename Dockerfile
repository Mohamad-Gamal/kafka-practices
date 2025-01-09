# Use an official image as a base
FROM python:3.9-slim

# Set working directory inside the container
WORKDIR /app

# Copy your application files
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Define the command to run the app
CMD ["python", "app.py"]
