# Tiny Journal APP

## Description

A simple Flutter-based journaling application that allows users to record their daily thoughts and moments. This app demonstrates best practices in mobile app development with Firebase integration and clean architecture patterns.

## Folder Structure
```
lib
│
├── models                # Model (MVVM)
│   └── journal_model.dart
│
├── services              # Data layer (API / Firebase / Database)
│   ├── auth_service.dart
│   └── journal_service.dart
│
├── providers             # ViewModel (state management & business logic)
│   ├── auth_provider.dart
│   └── journal_provider.dart
│
├── screens               # View (UI Pages)
│   ├── add_journal_screen.dart
│   ├── home_screen.dart
│   ├── login_screen.dart
│   └── register_screen.dart
│
├── widgets               # Reusable UI components
│   └── journal_card.dart
│
├── statics               # App constants / themes
│   └── app_theme.dart
│
├── firebase_options.dart # Firebase configuration
└── main.dart             # App entry point
```

## Packages Used

- **`provider`** - State management solution for managing app state
- **`firebase_core`** - Core Firebase SDK for Flutter
- **`firebase_auth`** - Firebase authentication for user login and registration
- **`cloud_firestore`** - Cloud database for storing journal entries


## Key Learning Points

### Testing

- Unit testing for business logic
- Widget testing for UI components
- Integration testing patterns

### Firebase Authentication

- User registration and login implementation
- Session management
- Password reset functionality
- Secure credential handling

### Firestore

- Real-time database operations
- CRUD operations for journal entries
- Data querying and filtering
- Data synchronization

### Simple Architecture

- Separation of concerns with Models, Services, and UI layers
- Repository pattern for data access
- Clean code organization
- Scalable project structure

### Provider State Management

- Provider setup and configuration
- ChangeNotifier pattern
- Consumer widget implementation
- Efficient state updates and rebuilds
- Dependency injection using MultiProvider


