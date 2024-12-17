import 'package:damdleaders_flutter/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Nécessaire pour Provider
import 'package:shared_preferences/shared_preferences.dart'; // Nécessaire pour enregistrer les préférences

// Import des vues
import 'features/Home/Screens/ProfileHomeView.dart';
import 'features/Home/Screens/SettingsView.dart';
import 'features/Home/Screens/homeScreen.dart';
import 'features/Home/Screens/videoScreen.dart';
import 'features/auth/screens/welcome_screen.dart';

// Import du fournisseur de thème
import 'config/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Charger SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isSystemDarkMode =
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark;

  runApp(
    ChangeNotifierProvider(
      create: (_) =>
          ThemeProvider(prefs: prefs, isSystemDarkMode: isSystemDarkMode),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(), // Thème clair par défaut
      darkTheme: ThemeData.dark(), // Thème sombre par défaut
      themeMode: themeProvider.themeMode, // Thème géré dynamiquement
      home: HomeScreen(), // Définit HomeScreen comme écran d'accueil
    );
  }
}
