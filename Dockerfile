FROM mcr.microsoft.com/devcontainers/universal:2-linux

RUN apt-get update 
FROM mcr.microsoft.com/devcontainers/universal:2-linux


USER root

# Update apt and install OS deps
RUN apt-get update && apt-get install -y \
    curl gnupg ca-certificates lsb-release \
    && rm -rf /var/lib/apt/lists/*

# MongoDB 

RUN curl -fsSL https://pgp.mongodb.com/server-7.0.asc | \
    gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg \
 && echo "deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg] https://repo.mongodb.org/apt/ubuntu $(lsb_release -sc)/mongodb-org/7.0 multiverse" \
    > /etc/apt/sources.list.d/mongodb-org-7.0.list \
 && apt-get update \
 && apt-get install -y mongodb-org \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data/db && chown -R vscode:vscode /data/db

# Python (Django + Flask)

RUN pipx install pipenv || true
RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir Django Flask


USER vscode
