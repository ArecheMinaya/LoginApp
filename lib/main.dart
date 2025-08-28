import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/firebase_options.dart';
import 'package:login_app/src/app/presentation/app_widget.dart';
import 'package:login_app/src/app/redux/app_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final store = await createAppStore();
  runApp(MainApp(store: store));
}
