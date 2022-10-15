# As per choice
FROM ubuntu:latest

# Change as per VPS
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Make Non-Interactive
# ENV DEBIAN_FRONTEND="noninteractive"

# Or Add Time Zone
ENV TZ=America/New_York # Add Zone Here
RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime
RUN echo "$TZ" > /etc/timezone

RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get -qq update

# Remove if using Gclone Library
RUN apt install unzip -y

RUN apt-get -qq install -y git python3 python3-pip
    
# Customize using Gclone Library without unzip
RUN wget https://github.com/mawaya/rclone/releases/download/fclone-v0.4.1/fclone-v0.4.1-linux-amd64.zip && unzip fclone-v0.4.1-linux-amd64.zip && \
    chmod +x fclone-v0.4.1-linux-amd64/fclone && mv fclone-v0.4.1-linux-amd64/fclone /usr/bin && \
    rm -r fclone-v0.4.1-linux-amd64

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    apt-get -qq purge git

COPY . .

RUN chmod +x run.sh

CMD ["bash","run.sh"]
