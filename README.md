# LoginApp

A Flutter application with authentication functionality using Redux for state management and Firebase for production authentication.

## 🚀 Features

- **Authentication System**: Login and signup functionality
- **Environment Configuration**: Support for DEV and PROD environments
- **State Management**: Redux with Redux Persist for state persistence
- **Testing**: Unit tests, Widget tests, and Golden tests
- **Firebase Integration**: Production-ready authentication with Firebase Auth
- **Theme Support**: Light and dark theme modes

## 📁 Project Structure

```
LoginApp/
├── lib/
│   ├── assets/
│   │   └── images/                 # App images and icons
│   ├── src/
│   │   ├── app/
│   │   │   ├── config/
│   │   │   │   └── env.dart        # Environment configuration
│   │   │   ├── presentation/
│   │   │   │   ├── app_widget.dart # Main app widget
│   │   │   │   ├── root_router.dart # App routing
│   │   │   │   ├── routes.dart     # Route definitions
│   │   │   │   └── theme/          # Theme configurations
│   │   │   └── redux/              # App-level Redux setup
│   │   ├── core/
│   │   │   ├── services/           # Core services
│   │   │   └── utils/              # Utility functions
│   │   ├── features/
│   │   │   ├── auth/               # Authentication feature
│   │   │   │   ├── models/         # User models
│   │   │   │   ├── presentation/   # UI components
│   │   │   │   ├── redux/          # Auth Redux logic
│   │   │   │   └── service/        # Auth services
│   │   │   └── settings/           # Settings feature
│   │   └── shared/
│   │       └── widgets/            # Reusable widgets
│   ├── firebase_options.dart       # Firebase configuration
│   └── main.dart                   # App entry point
├── test/
│   ├── features/
│   │   └── auth/
│   │       └── redux/              # Auth Redux tests
│   ├── goldens/                    # Golden test files
│   └── shared/
│       └── widgets/                # Widget tests
└── android/ ios/ web/              # Platform-specific code
```

## 🔧 Environment Configuration

The app supports two environments controlled by the `ENVIRONMENT` flag:

### Development Environment (DEV)
- Uses fake authentication service
- Default credentials: `test@redux.com` / `123456`
- No Firebase connection required
- Suitable for development and testing

### Production Environment (PROD)
- Uses Firebase Authentication
- Real user registration and login
- Requires Firebase configuration
- Production-ready authentication

## 🚀 Launch Configurations

The project includes VS Code launch configurations for different environments:

### LoginApp (DEV)
```json
{
  "name": "LoginApp (DEV)",
  "request": "launch",
  "type": "dart",
  "args": ["--dart-define=ENVIRONMENT=DEV"]
}
```
- Runs the app in development mode
- Uses fake authentication service
- No Firebase setup required
- Default user: `test@redux.com` / `123456`

### LoginApp (PROD)
```json
{
  "name": "LoginApp (PROD)",
  "request": "launch",
  "type": "dart",
  "args": ["--dart-define=ENVIRONMENT=PROD"]
}
```
- Runs the app in production mode
- Uses Firebase Authentication
- Requires Firebase project setup
- Real user registration and login

## 🧪 Testing

The project includes comprehensive testing with three types of tests:

### Unit Tests
- Test Redux reducers and actions
- Located in `test/features/auth/redux/`
- Test files: `auth_reducer_test.dart`, `app_reducer_test.dart`, `settings_reducer_test.dart`

### Widget Tests
- Test individual widgets
- Located in `test/shared/widgets/`
- Test file: `primary_button_test.dart`

### Golden Tests
- Visual regression tests
- Located in `test/goldens/`
- Test file: `home_page_golden_test.dart`

### Running Tests

1. **Generate Golden Test Images**:
   ```bash
   flutter test --update-goldens
   ```

2. **Run All Tests**:
   ```bash
   flutter test
   ```

3. **Run Specific Test File**:
   ```bash
   flutter test test/features/auth/redux/auth_reducer_test.dart
   ```

## 🛠️ Setup Instructions

### Prerequisites
- Flutter SDK (^3.8.1)
- Dart SDK
- Android Studio / VS Code
- Git

### Getting Started

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd LoginApp
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   - For development: Use "LoginApp (DEV)" launch configuration
   - For production: Use "LoginApp (PROD)" launch configuration

### Firebase Setup (Production Only)

If you want to use the production environment with Firebase:

1. Create a Firebase project
2. Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
3. Configure Firebase Authentication
4. Use the "LoginApp (PROD)" launch configuration

## 📦 Dependencies

### Main Dependencies
- `flutter_redux`: Redux state management
- `redux_persist`: State persistence
- `firebase_core` & `firebase_auth`: Firebase integration
- `flutter_secure_storage`: Secure storage
- `dio`: HTTP client

### Dev Dependencies
- `flutter_test`: Testing framework
- `flutter_lints`: Code linting
- `json_serializable`: JSON serialization
- `test`: Testing utilities

## 🏗️ Architecture

The app follows a feature-based architecture with:
- **Redux** for state management
- **Feature-based** folder structure
- **Clean Architecture** principles
- **Dependency Injection** pattern
- **Repository Pattern** for data access

## 📱 Supported Platforms

- Android
- iOS
- Web
- macOS
- Linux
- Windows

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Run all tests to ensure they pass
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License.
