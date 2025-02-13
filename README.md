# DeepSeek Chat Application - README

Welcome to the **DeepSeek Chat Application** project! This README provides a comprehensive guide to understanding, setting up, and running the project. It covers everything from retrieving the API key, structuring the project, Docker best practices, and deploying the application using Docker Compose.

---

## Table of Contents
1. [Project Overview](#project-overview)
2. [Retrieving the API Key](#retrieving-the-api-key)
3. [Project Directory Structure](#project-directory-structure)
4. [Python Application Setup](#python-application-setup)
   - [Requirements](#requirements)
   - [Storing Secrets and Sensitive Data](#storing-secrets-and-sensitive-data)
5. [Docker Setup](#docker-setup)
   - [Docker Best Practices](#docker-best-practices)
   - [Building and Running the Docker Container](#building-and-running-the-docker-container)
6. [Docker Compose](#docker-compose)
7. [Running the Application](#running-the-application)
8. [Troubleshooting](#troubleshooting)
9. [Contributing](#contributing)
10. [License](#license)

---

## Project Overview
The DeepSeek Chat Application is a Python-based web application that interacts with the DeepSeek API to provide chat functionality. The application is built using **Flask** for the backend and is containerized using **Docker** for easy deployment. It follows best practices for security, such as storing sensitive data in environment variables and running the application as a non-root user in Docker.

---

## Retrieving the API Key
To use the DeepSeek API, you need an API key. Here’s how to retrieve it:

1. **Sign Up for DeepSeek**:
   - Visit the DeepSeek platform and create an account.
   - Navigate to the API section in your account dashboard.

2. **Generate the API Key**:
   - Look for the option to generate a new API key.
   - Copy the API key and store it securely.

---

## Project Directory Structure
The project is organized as follows:

```
deepseek-project/
│
├── app.py                  # Main Flask application
├── requirements.txt        # Python dependencies
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Docker Compose configuration
├── .env                    # Environment variables (sensitive data)
├── .dockerignore           # Files to ignore during Docker build
├── .gitignore              # Files to ignore in Git
├── static/                 # Static files (CSS, JS)
│   ├── styles.css          # CSS for the UI
│   └── script.js           # JavaScript for interactivity
└── templates/              # HTML templates
    └── index.html          # Main UI template
```

---

## Python Application Setup

### Requirements
The application requires the following Python packages:
- **Flask**: For the web server.
- **requests**: For making HTTP requests to the DeepSeek API.
- **python-dotenv**: For loading environment variables from a `.env` file.

These dependencies are listed in the `requirements.txt` file.

### Storing Secrets and Sensitive Data
Sensitive data, such as the API key, should never be hardcoded in the application. Instead, use environment variables:

1. **Create a `.env` File**:
   Add the API key to a `.env` file in the project root:
   ```plaintext
   DEEPSEEK_API_KEY=your_api_key_here
   ```

2. **Load Environment Variables in the App**:
   Use the `python-dotenv` package to load the `.env` file in your Flask app:
   ```python
   from dotenv import load_dotenv
   import os

   load_dotenv()
   DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")
   ```

---

## Docker Setup

### Docker Best Practices
1. **Multi-stage Builds**:
   - Use multi-stage builds to reduce the final image size.
   - Install dependencies in the first stage and copy only the necessary files to the final image.

2. **Non-root User**:
   - Run the application as a non-root user for security.

3. **Minimize Layers**:
   - Combine commands to minimize the number of layers in the Docker image.

4. **Environment Variables**:
   - Use environment variables for configuration.

### Building and Running the Docker Container
1. **Build the Docker Image**:
   ```bash
   docker build -t deepseek-app .
   ```

2. **Run the Container**:
   Pass the API key as an environment variable:
   ```bash
   docker run -d -p 5000:5000 -e DEEPSEEK_API_KEY=your_api_key_here --name deepseek-container deepseek-app
   ```

3. **Check the Logs**:
   ```bash
   docker logs deepseek-container
   ```

---

## Docker Compose
Docker Compose simplifies running multi-container applications. Here’s how to use it:

1. **Create a `docker-compose.yml` File**:
   ```yaml
   version: "3.8"
   services:
     deepseek-app:
       image: deepseek-app
       build: .
       ports:
         - "5000:5000"
       environment:
         - DEEPSEEK_API_KEY=your_api_key_here
       restart: unless-stopped
   ```

2. **Run the Application**:
   ```bash
   docker-compose up -d
   ```

---

## Running the Application
1. **Access the Application**:
   Open your browser and navigate to `http://localhost:5000/`.

2. **Test the Chat Functionality**:
   Enter a message and check the response from the DeepSeek API.

---

## Troubleshooting
1. **API Key Not Found**:
   - Ensure the API key is correctly set in the `.env` file or passed as an environment variable.

2. **Docker Container Fails to Start**:
   - Check the logs using `docker logs deepseek-container`.
   - Ensure all dependencies are installed and the `Dockerfile` is correctly configured.

3. **Module Not Found**:
   - Verify that all dependencies are listed in `requirements.txt` and installed during the Docker build.

---

## Contributing
Contributions are welcome! If you’d like to contribute:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request.

---

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
































docker run -d -p 5000:5000 -e DEEPSEEK_API_KEY=sk-dc4476dc504a4868a3496ed45bdd93fd --name deepseek-container deepseek-app