import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String _name = "DefaultName";
  String _lastName = "DefaultLastName";
  String _domaine = "DefaultDomain";

  String get username => _name;
  String get lastName => _lastName;
  String get domaine => _domaine;

  bool get isLoggedIn => _isLoggedIn;

  UserProvider() {
    _loadUserLoginStatus();
  }

  void _loadUserLoginStatus() async {
    _isLoggedIn = await UserPreference.getUserLoggedIn();
    notifyListeners(); // Notify listeners to update the UI
  }

  void login() {
    _isLoggedIn = true;
    UserPreference.setUserLoggedIn(true); // Save the login status
    notifyListeners(); // Notify listeners to update the UI
  }
    void updateUser(String username, String lastName, String domaine) {
    _name = username;
    _lastName = lastName;
    _domaine = domaine;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    UserPreference.setUserLoggedIn(false); // Save the logout status
    notifyListeners(); // Notify listeners to update the UI
  }
}

