import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const String _key = "isLoggedIn";

  /// Enregistre la préférence pour l'état de connexion de l'utilisateur
  static Future<void> setUserLoggedIn(bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, value);
    } catch (e) {
      print("Erreur lors de l'enregistrement de l'état de connexion: $e");
    }
  }

  /// Récupère l'état de connexion de l'utilisateur
  static Future<bool> getUserLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_key) ?? false; // Valeur par défaut : false
    } catch (e) {
      print("Erreur lors de la récupération de l'état de connexion: $e");
      return false; // Retourner false en cas d'erreur
    }
  }
}
