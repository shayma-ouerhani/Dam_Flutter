import 'package:damdleaders_flutter/config/UserPreference/User_preferences.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;

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

  void logout() {
    _isLoggedIn = false;
    UserPreference.setUserLoggedIn(false); // Save the logout status
    notifyListeners(); // Notify listeners to update the UI
  }
}
