# Commit Ma3ana — Learning Management System (LMS)

## Project Overview

Commit Ma3ana is a comprehensive Learning Management System (LMS) designed to help Computer Science students learn programming through structured courses, video lessons, downloadable learning materials, and interactive quizzes.

The platform provides an integrated learning environment consisting of a student mobile application, web applications for administrators and instructors, and a centralized backend responsible for managing users, courses, enrollments, assessments, notifications, and student progress.

This repository brings together the main application components and the DevOps configuration required to run them in a containerized environment using Docker and Docker Compose.

## System Architecture

The project consists of the following components:

- **Backend:** Django and Django REST Framework, providing RESTful APIs and application business logic.
- **Angular Frontend:** A web application for accessing and managing learning platform features.
- **Flutter Mobile Application:** A mobile application that enables students to access courses and learning resources.
- **Flutter Web Dashboard:** A web dashboard for administrators and instructors to manage platform content and monitor student performance.
- **Database:** MySQL for storing application data.
- **DevOps Setup:** Dockerfiles, Docker Compose configuration, and Docker networking for running the application services together.

## Features

### Student Features

- Browse and enroll in courses and packages.
- Watch course videos and access downloadable learning materials.
- Take quizzes and review results.
- Track learning progress.
- Earn points and certificates.
- Rate courses.
- Receive notifications and read instructor announcements.

### Admin Features

- Manage students and instructors.
- Manage courses and packages.
- Manage quizzes and questions.
- Manage videos and learning materials.
- View platform statistics.
- Manage announcements and platform content.

### Instructor Features

- Create and manage courses and packages.
- Upload videos and learning materials.
- Create quizzes and questions.
- View enrolled students.
- Track student performance.
- Publish announcements.

## Technology Stack

| Component | Technologies |
|---|---|
| Backend | Python, Django, Django REST Framework |
| Database | MySQL |
| Web Frontend | Angular, TypeScript, RxJS |
| Mobile Application | Flutter, Dart, BLoC |
| Web Dashboard | Flutter Web, Dart, BLoC |
| API Communication | RESTful APIs |
| Authentication | JWT Authentication |
| Backend Server | Gunicorn |
| Web Server | Nginx |
| Containerization | Docker |
| Multi-Container Management | Docker Compose |
| Container Networking | Docker Networks |

## DevOps Implementation — Dockerization

As part of the project's DevOps implementation, we containerized the main application components and integrated them into a unified multi-container environment using Docker and Docker Compose.

### Implemented Tasks

#### 1. Backend Containerization

- Created a Docker image for the Django backend.
- Configured the backend to run using Gunicorn.
- Configured database connectivity through the Docker network.
- Verified backend functionality and API accessibility through Swagger.

#### 2. Database Containerization

- Created and configured a MySQL container.
- Restored the existing database backup, including tables and data.
- Configured the backend to connect to the database through the Docker network.
- Verified successful communication between the backend and database.

#### 3. Angular Frontend Containerization

- Containerized the Angular web application.
- Configured the application to run in the Docker environment.
- Integrated it with the backend and other application services.
- Verified that it operated successfully within the integrated environment.

#### 4. Flutter Web Containerization

- Created a Docker image for the Flutter Web dashboard.
- Used a multi-stage build to compile the Flutter application and serve the generated files through Nginx.
- Configured API communication with the Django backend.
- Verified successful operation within the containerized environment.

#### 5. Docker Compose Integration

- Configured Docker Compose to manage the application services together.
- Defined the services and their runtime configurations.
- Connected the services through a shared Docker network.
- Configured the required environment variables and service communication.
- Verified that all containerized services ran successfully together.

#### 6. Integration and Testing

- Verified that all services started successfully.
- Tested backend connectivity with the MySQL database.
- Verified API accessibility through Swagger.
- Tested communication between the frontend applications and backend.
- Confirmed that the containerized components operated together as an integrated application.

## Dockerized Architecture

```text
                    Commit Ma3ana LMS
                            |
             +--------------+--------------+
             |                             |
      Angular Frontend              Flutter Web Dashboard
             |                             |
             +--------------+--------------+
                            |
                     Django Backend
                            |
                      MySQL Database

             All services run in Docker
             and communicate over a
             shared Docker network.
```

Docker Compose is used to manage the multi-container environment, while Docker networking enables communication between the relevant services.

The Flutter mobile application is also part of the overall platform and communicates with the backend API.

## Benefits of the DevOps Implementation

- **Consistent Environments:** Each service runs in its own container with its required dependencies.
- **Service Isolation:** Application components are packaged and managed independently.
- **Simplified Setup:** Docker Compose makes it easier to run the integrated application.
- **Network Integration:** Services communicate through a shared Docker network.
- **Maintainability:** The separation of services simplifies troubleshooting and future updates.
- **Deployment Foundation:** The project is prepared for further DevOps improvements and cloud deployment.

## Team Members

| Name | Role | GitHub |
|---|---|---|
| Taha Saber | Team Lead | [Taha-Saber](https://github.com/Taha-Saber) |
| Adham Mohamed | Team Member | [adham192](https://github.com/adham192) |
| Nouran Mahmoud | Team Member | [nouran8890](https://github.com/nouran8890) |
| Mostafa Ali | Team Member | [mostafaAli-17](https://github.com/mostafaAli-17) |
| Andrw | Team Member | [infinite556](https://github.com/infinite556) |



