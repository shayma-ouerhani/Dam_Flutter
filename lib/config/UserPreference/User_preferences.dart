import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const String _keyName = "name";
  static const String _keyLastName = "lastname";
  static const String _keyEmail = "email";
   static const String _keyDomaine = "domaine";
  static const String KeyuserId = "userId";
  

  
  static const String _key = "isLoggedIn";

  /// Enregistre la préférence pour l'état de connexion de l'utilisateur
  static Future<void> setUserLoggedIn(bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, value);
    } catch (e) {
      print("Erreur lors de l'enregistrement de l'état de connexion: $e");
    }
  }

  /// Récupère l'état de connexion de l'utilisateur
  static Future<bool> getUserLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_key) ?? false; // Valeur par défaut : false
    } catch (e) {
      print("Erreur lors de la récupération de l'état de connexion: $e");
      return false;
    }
  }
  static Future<void> setName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, value);
  }
  static Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }
  static Future<void> setLastName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastName, value);
  }

  static Future<String?> getLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastName);
  }


  static Future<void> setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, value);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  static Future<void> setDomaine(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDomaine, value);
  }

  static Future<String?> getDomaine() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDomaine);
  }
    /// Méthode privée pour enregistrer une chaîne de caractères
  static Future<void> _setStringPreference(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      print("Erreur lors de l'enregistrement de la préférence $key : $e");
    }
  }
    /// Méthode privée pour récupérer une chaîne de caractères
  static Future<String?> _getStringPreference(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      print("Erreur lors de la récupération de la préférence $key : $e");
      return null;
    }
  }
  static Future<void> setUserId(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(KeyuserId, value);
}
static Future<String?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(KeyuserId);
}



}
