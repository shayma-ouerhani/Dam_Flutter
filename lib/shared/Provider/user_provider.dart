import 'package:damdleaders_flutter/Models/Auth/LoginResponse.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  LoginResponse? _user;

  LoginResponse? get user => _user;

  void setUser(LoginResponse user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}