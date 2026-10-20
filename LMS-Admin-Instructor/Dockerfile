# =========================
# Stage 1: Build Flutter Web
# =========================
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

COPY pubspec.* ./

RUN flutter pub get

COPY . .

ARG BASE_URL=http://localhost:8000/api/

RUN flutter build web --release \
    --dart-define=BASE_URL=$BASE_URL


# =========================
# Stage 2: Nginx
# =========================
FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
