FROM ubuntu:24.04

WORKDIR /app

# Install real fortune and cowsay
RUN apt-get update && \
    apt-get install -y fortune cowsay netcat-openbsd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add /usr/games to PATH (where cowsay and fortune are installed)
ENV PATH="/usr/games:${PATH}"

COPY wisecow.sh .

RUN chmod +x wisecow.sh

EXPOSE 4499

CMD ["bash", "./wisecow.sh"]