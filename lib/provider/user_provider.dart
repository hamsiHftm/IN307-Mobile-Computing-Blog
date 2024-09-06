import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    // Implement your login logic here. This is just a dummy example.
    if (email == 'test@test.com' && password == 'password') {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}