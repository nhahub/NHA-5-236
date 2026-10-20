# Commit Ma3ana (Dashboard Version)

Commit Ma3ana Learning Management System is a platform designed to host programming courses for Computer Science students. The system is built to support courses containing videos, materials, and quizzes, enabling students to enroll and track their learning progress.

## Dashboard Features

It contains 2 roles:

* Admin role
* Instructor role

### Admin role features

* Manage all users
* Manage all courses
* Manage all quizzes
* Manage all materials
* Manage all videos

### Instructor role features

* Manage his courses
* Manage his quizzes
* Manage his materials
* Manage his videos

## Student App Features

* Enroll to any course
* Track your progress
* Earn points and certificates
* View course materials and videos
* Take quizzes

## Project Structure

The codebase is organized into four primary directories under `lib/`, each with a distinct responsibility:

```

lib/
├── core/                # The backbone of the application (Shared logic)
│   ├── di/              # Service locator (GetIt) configuration
│   ├── services/        # Data access wrappers (Dio, Shared Preferences)
│   ├── routing/         # Centralized route definitions (GoRouter)
│   └── theme/           # App-wide styling and localization (AR/EN)
├── features/            # Domain-specific logic (e.g., auth, course, explore)
│   ├── [feature_name]/
│   │   ├── data/        # Repository implementations & DTO models
│   │   ├── domain/      # Business logic & repository interfaces
│   │   └── presentation/# UI components & BLoC state management
├── root/                # Top-level navigation shell & Auth-state rendering
└── main.dart            # Entry point & Service Locator initialization

```

## Technical Stack

* **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) for predictable state transitions.
* **Networking**: [Dio](https://pub.dev/packages/dio) with a custom `ApiConsumer` abstraction.
* **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it) for lazy-loading services and repositories.
* **Navigation**: [GoRouter](https://pub.dev/packages/go_router) for deep-linking and declarative routing.
* **Data Consistency**: [dartz](https://pub.dev/packages/dartz) for functional error handling using `Either<Failure, Success>`.
* **UI Scaling**: [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) for responsive layouts across different screen sizes.

---

## New Screen Implementation Plan (For new Developers)

### Phase 1: Foundation

* **Build Structure**: Create `data/` (models, repo impl), `domain/` (repo interface, and entity 'if needed'), and `presentation/` (bloc, screens, widgets).
* **Data Modeling**: Create the Model class for the screen's data (in data layer).
* **Repository**: Define interface in `domain/` and implement in `data/` using `Dio`.
* **API**: Define new endpoints to `endpoints.dart` file if needed.
* **Shared Widgets**: Create new widget to `widgets/` folder if needed.

### Phase 2: Logic & DI

* **BLoC**: Implement Events (e.g., `GetDataEvent`) and States (Initial, Loading, Loaded, Error) then implement the BLoC.
* **Injection**: Inject the repository into the BLoC via named parameters.
* **Service Locator**: Register Repo and BLoC in `service_locator.dart` as `registerLazySingleton`.
* **Routing**: Register route in `router_generator.dart` and provide BLoC via `BlocProvider`.

### Phase 3: Assets & Localization

* **Localization**: Add strings to `en.json` and `ar.json`. Use `context.tr('key')` (ensure import).
* **Icons**: Add new icons to `app_icons.dart` if needed.
* **Images**: Add new images to `app_images.dart` if needed.
* **Assets**: Register new icons or images in `app_assets.dart` if needed.

### Phase 4: UI Development

* **Modularization**: Break screens into small widgets in the feature's `widgets/` folder.
* **Shared UI**: Use custom widgets from `features/widgets/` folder as `CustomPrimaryButton`, `LoadingIndicatorWidget` and so on.
* **Styling**:
  * Use `context.colorScheme` or `AppTheme` extensions (no static colors).
  * Use `ScreenUtil` (`.w`, `.h`, `.r`, `.sp`) for all dimensions.
* **State**: Use `BlocBuilder` to handle all states gracefully.

Objective: Deliver high-performance, fully responsive screens through a clean and maintainable codebase.

## Development Team

### Flutter Team

* [Abdallah Alqiran](https://github.com/Abdallah-Alqiran) "Team Leader"
* [Taha Saber](https://github.com/Taha-Saber)
* [Mayar Abdelrahim](https://github.com/Mayar-Abdelrahim)

### Front-End Team

* [Rawan Bahaa](https://github.com/Rawanbahaa142)
* [Reham Ahmed](https://github.com/reham14-ahmed)

### Back-End Team

* [Omnia Abdelnasser](https://github.com/Omnia-Abdelnasser)
* [Rana Badawy](https://github.com/Rana-A-Badawy)
* [Taha Fawzy](https://github.com/Taha-M-Fawy)
