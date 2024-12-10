import 'package:damdleaders_flutter/features/Home/Screens/ProfileHomeView.dart';
import 'package:damdleaders_flutter/features/Home/Screens/SettingsView.dart';
import 'package:damdleaders_flutter/features/Home/Screens/homeScreen.dart';
import 'package:damdleaders_flutter/features/auth/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'features/Home/Screens/videoScreen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Supprime la bannière "Debug"
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(), // Définit WelcomeScreen comme écran d'accueil
    );
  }
}
