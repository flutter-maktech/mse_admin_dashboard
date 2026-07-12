# Stage 1: Build the Flutter Web Application
FROM debian:latest AS build-env

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Clone the stable Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter

# Add flutter to environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-download development tools and run flutter doctor
RUN flutter doctor -v

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Fetch the pub dependencies
RUN flutter pub get

# Build the web application in release mode
RUN flutter build web --release

# Stage 2: Serve the build files using a lightweight Nginx web server
FROM nginx:alpine

# Copy the build files from the previous build stage
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
