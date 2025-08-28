import 'package:login_app/src/app/redux/middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'app_state.dart';
import 'reducers.dart';

Future<Store<AppState>> createAppStore() async {
  // Serializer que acepta dynamic y castea a Map
  final serializer = JsonSerializer<AppState>((dynamic json) {
    if (json is Map) {
      return AppState.fromJson(Map<String, dynamic>.from(json));
    }
    return null; // primera vez no hay nada
  });

  // Storage multiplataforma (SharedPreferences / localStorage)
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(key: 'app_state_v1'),
    serializer: serializer,
    debug: false,
    throttleDuration: const Duration(milliseconds: 250),
  );

  // Cargar estado guardado
  final initialFromDisk = await persistor.load();

  // Crear Store
  final store = Store<AppState>(
    appReducer,
    initialState: initialFromDisk ?? AppState.initial(),
    middleware: [
      persistor.createMiddleware(), // <-- guarda automáticamente en cada cambio
      ...buildAppMiddlewares(),
    ],
  );

  return store;
}
