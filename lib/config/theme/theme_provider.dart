import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String key = "isDarkTheme";
  late SharedPreferences _prefs; // Pas besoin de `?`, il devrait être initialisé
  late bool _isDarkMode;

  // Constructeur modifié pour mieux gérer l'initialisation
  ThemeProvider({SharedPreferences? prefs, bool? isSystemDarkMode}) {
    _isDarkMode = isSystemDarkMode ?? false;
    if (prefs != null) {
      _prefs = prefs;
      loadFromPrefs();
    }
  }

  bool get isDarkMode => _isDarkMode;

  // Initier les préférences plus tard
  Future<void> initPref(SharedPreferences prefs) async {
    _prefs = prefs;
    await loadFromPrefs(); // Charger les préférences après initialisation
  }

  // Charger les préférences depuis SharedPreferences
  Future<void> loadFromPrefs() async {
    _isDarkMode = _prefs.getBool(key) ?? _isDarkMode; // Défaut à l'état système si pas trouvé
    themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // Sauvegarder l'état dans les préférences
  Future<void> saveToPrefs() async {
    await _prefs.setBool(key, _isDarkMode);
    notifyListeners();
  }

  // Basculer le mode sombre/clair
  void toggleTheme(bool isOn) {
    _isDarkMode = isOn;
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    saveToPrefs();
  }
}

class MyThemes {
  // Définition des couleurs principales
  static const Color primaryColor = Color(0xFF130160);
  static const Color secondaryColor = Color(0xFFFCA34D);
  static const Color blackColor = Color(0xFF000000);
  static const Color greyColor = Color(0xFFF9F9F9);
  static const Color whiteColor = Color(0xFFFFFFFF);

  // Thème clair
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: const AppBarTheme(
      color: whiteColor,
      iconTheme: IconThemeData(color: blackColor),
      titleTextStyle: TextStyle(color: blackColor, fontSize: 18),
    ),
    iconTheme: const IconThemeData(color: blackColor),
    colorScheme: const ColorScheme.light(
      tertiary: secondaryColor,
      secondary: primaryColor,
      primary: primaryColor,
      onPrimary: whiteColor,
      surface: greyColor,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
    ),
  );

  // Thème sombre
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: blackColor,
    appBarTheme: const AppBarTheme(
      color: blackColor,
      iconTheme: IconThemeData(color: whiteColor),
      titleTextStyle: TextStyle(color: whiteColor, fontSize: 18),
    ),
    iconTheme: const IconThemeData(color: whiteColor),
    colorScheme: const ColorScheme.dark(
      tertiary: secondaryColor,
      secondary: primaryColor,
      primary: primaryColor,
      onPrimary: whiteColor,
      surface: Color(0xFF121212),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
    ),
  );
}
