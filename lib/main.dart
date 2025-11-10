import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/app.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAA4GxTYxG4Yl8rh1C-BBMdc0teDs-t7IQ",
      authDomain: "user-register-66205.firebaseapp.com",
      projectId: "user-register-66205",
      storageBucket: "user-register-66205.firebasestorage.app",
      messagingSenderId: "307328466205",
      appId: "1:307328466205:web:59a3fc7083c7f73d6fb5f4",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "User Register",
      home: WelcomePage(),
    );
  }
}