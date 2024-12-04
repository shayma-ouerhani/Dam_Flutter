import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
import 'package:damdleaders_flutter/features/auth/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'features/Home/Screens/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Supprime la bannière "Debug"
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginScreen(), // Définit WelcomeScreen comme écran d'accueil
    );
  }
}
