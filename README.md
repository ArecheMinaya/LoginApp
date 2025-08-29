# LoginApp

Una aplicación Flutter con funcionalidad de autenticación usando Redux para la gestión de estado y Firebase para autenticación en producción.

## 🚀 Funcionalidades

- **Sistema de Autenticación**: Inicio de sesión y registro de usuarios  
- **Configuración de Entornos**: Soporte para entornos DEV y PROD  
- **Gestión de Estado**: Redux con Redux Persist para persistencia de estado  
- **Pruebas**: Tests unitarios, de widgets y golden tests  
- **Integración con Firebase**: Autenticación lista para producción con Firebase Auth  
- **Soporte de Tema**: Modos claro y oscuro  

## 📁 Estructura del Proyecto

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


## 🔧 Configuración de Entornos

La app soporta dos entornos controlados por la variable `ENVIRONMENT`:

### Entorno de Desarrollo (DEV)
- Usa servicio de autenticación falso  
- Credenciales por defecto: `test@redux.com` / `123456`  
- No requiere conexión a Firebase  
- Ideal para desarrollo y pruebas  

### Entorno de Producción (PROD)
- Usa Firebase Authentication  
- Registro e inicio de sesión reales  
- Requiere configuración de Firebase  
- Autenticación lista para producción  

## 🚀 Configuraciones de Lanzamiento

El proyecto incluye configuraciones de VS Code para distintos entornos:

### LoginApp (DEV)
```json
{
  "name": "LoginApp (DEV)",
  "request": "launch",
  "type": "dart",
  "args": ["--dart-define=ENVIRONMENT=DEV"]
}
```

- Ejecuta la app en modo desarrollo
- Usa el servicio de autenticación falso
- No requiere Firebase
- Usuario por defecto: `test@redux.com` / `123456`

### LoginApp (PROD)
```json
{
  "name": "LoginApp (PROD)",
  "request": "launch",
  "type": "dart",
  "args": ["--dart-define=ENVIRONMENT=PROD"]
}
```

- Ejecuta la app en modo producción
- Usa Firebase Authentication
- Requiere configuración de Firebase
- Registro e inicio de sesión reales

  
## 🧪 Testing

La app incluye 3 tipos de pruebas:

### Unit Tests
- Reducers y acciones de Redux
- Ubicados en `test/features/auth/redux/`
- Archivos: `auth_reducer_test.dart`, `app_reducer_test.dart`, `settings_reducer_test.dart`

### Widget Tests
- Prueban widgets individuales
- Ubicados en `test/shared/widgets/`
- Archivo: `primary_button_test.dart`

### Golden Tests
- Pruebas de regresión visual
- Ubicados en `test/goldens/`
- Archivo: `home_page_golden_test.dart`

### Ejecución de Tests

1. **Generar imágenes de golden tests**:
   ```bash
   flutter test --update-goldens
   ```

2. **Ejecutar todos los tests**:
   ```bash
   flutter test
   ```

3. **Ejecutar un test específico**:
   ```bash
   flutter test test/features/auth/redux/auth_reducer_test.dart
   ```

## 🛠️ Instrucciones de Configuración

### Requisitos Previos

- Flutter SDK (^3.8.1)
- Dart SDK
- Android Studio o VS Code
- Git

### Primeros Pasos

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/ArecheMinaya/LoginApp.git
   cd LoginApp
   ```

2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```

3. **Ejecutar el app**:
   - Desarrollo: usar configuración "LoginApp (DEV)"
   - Producción: usar configuración "LoginApp (PROD)"

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
- `test`: Testing utilities

## 🏗️ Arquitectura

El app sigue una arquitectura basada en características:
- **Redux** para gestión de estado
- **Feature-based** folder structure
- Principios de **Clean Architecture**

## 📱 Plataformas Soportadas

- Android
- iOS
