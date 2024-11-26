FROM cirrusci/flutter:stable

WORKDIR /app

COPY . /app

RUN flutter pub get

EXPOSE 8080

CMD ["flutter", "run", "--no-sound-null-safety", "-d", "web-server", "--web-port", "8080"]
