import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_scape_new/splash_screen.dart';

// ignore: depend_on_referenced_packages

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
