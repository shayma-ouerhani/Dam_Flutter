import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const String _key = "isDarkTheme";

  /// Enregistre la préférence pour le thème sombre
  static Future<void> setDarkTheme(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, value);
    } catch (e) {
      // Optionnel: gérer l'erreur ici (par exemple, loguer l'erreur)
      print("Erreur lors de l'enregistrement du thème sombre: $e");
    }
  }

  /// Récupère la préférence pour le thème sombre
  static Future<bool> getTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_key) ?? false; // Valeur par défaut : false
    } catch (e) {
      // Optionnel: gérer l'erreur ici (par exemple, loguer l'erreur)
      print("Erreur lors de la récupération du thème sombre: $e");
      return false; // Retourner false en cas d'erreur
    }
  }
}
