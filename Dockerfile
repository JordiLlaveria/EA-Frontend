FROM cirrusci/flutter:stable as build-step
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter build web --dart-define=API_URL=https://ea1-backend.mooo.com

FROM nginx:1.20.2-alpine
COPY --from=build-step /app/build/web /usr/share/nginx/html