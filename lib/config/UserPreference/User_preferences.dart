import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  // Clés pour les champs utilisateur
  static const String _keyName = "name";
  static const String _keyLastName = "lastname";
  static const String _keyEmail = "email";
  static const String _keyDomaine = "domaine";
  static const String _keyUserId = "userId";
  static const String _keyPhotoUrl = "photoUrl";
  static const String _keyPhoneNumber = "phoneNumber";
  static const String _keyCodePostal = "codePostal";
  static const String _keyWebsite = "website";
  static const String _keyRole = "role";
  static const String _keyFollow = "follow";
  static const String _keyFollowers = "followers";
  static const String _keyIsLoggedIn = "isLoggedIn";
  static const bool _KeyLogin = false;
  /// Méthode générique pour enregistrer une chaîne de caractères
  static Future<void> _setStringPreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Méthode générique pour récupérer une chaîne de caractères
  static Future<String?> _getStringPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Enregistre l'état de connexion
  static Future<void> setUserLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, value);
  }

  /// Récupère l'état de connexion
  static Future<bool> getUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Getters et Setters pour les champs utilisateur
  static Future<void> setName(String value) => _setStringPreference(_keyName, value);
  static Future<String?> getName() => _getStringPreference(_keyName);


  static Future<void> setLastName(String value) => _setStringPreference(_keyLastName, value);
  static Future<String?> getLastName() => _getStringPreference(_keyLastName);

  static Future<void> setEmail(String value) => _setStringPreference(_keyEmail, value);
  static Future<String?> getEmail() => _getStringPreference(_keyEmail);

  static Future<void> setDomaine(String value) => _setStringPreference(_keyDomaine, value);
  static Future<String?> getDomaine() => _getStringPreference(_keyDomaine);

  static Future<void> setUserId(String value) => _setStringPreference(_keyUserId, value);
  static Future<String?> getUserId() => _getStringPreference(_keyUserId);

  static Future<void> setPhotoUrl(String value) => _setStringPreference(_keyPhotoUrl, value);
  static Future<String?> getPhotoUrl() => _getStringPreference(_keyPhotoUrl);

  static Future<void> setPhoneNumber(String value) => _setStringPreference(_keyPhoneNumber, value);
  static Future<String?> getPhoneNumber() => _getStringPreference(_keyPhoneNumber);

  static Future<void> setCodePostal(String value) => _setStringPreference(_keyCodePostal, value);
  static Future<String?> getCodePostal() => _getStringPreference(_keyCodePostal);

  static Future<void> setWebsite(String value) => _setStringPreference(_keyWebsite, value);
  static Future<String?> getWebsite() => _getStringPreference(_keyWebsite);

  static Future<void> setRole(String value) => _setStringPreference(_keyRole, value);
  static Future<String?> getRole() => _getStringPreference(_keyRole);

  static Future<void> setFollow(String value) => _setStringPreference(_keyFollow, value);
  static Future<String?> getFollow() => _getStringPreference(_keyFollow);

  static Future<void> setFollowers(String value) => _setStringPreference(_keyFollowers, value);
  static Future<String?> getFollowers() => _getStringPreference(_keyFollowers);
}