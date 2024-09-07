import 'package:flutter/material.dart';
import '../api/user_api.dart'; // Import your UserApi class
import '../model/user.dart'; // Import the User model

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user; // Store the logged-in user
  String? _errorMessage; // Store the error message if login or signup fails

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user; // Getter to access the logged-in user
  String? get errorMessage => _errorMessage; // Getter for the error message

  // Method to handle login
  Future<bool> login(String email, String password) async {
    try {
      _user = await UserApi.instance.login(email, password);
      _isLoggedIn = true;
      _errorMessage = null; // Clear previous error messages
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoggedIn = false;
      _user = null;
      notifyListeners();
      return false;
    }
  }

  // Method to handle logout
  void logout() {
    _isLoggedIn = false;
    _user = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Method to handle signup
  Future<bool> signUp({
    required String email,
    required String password,
    String firstname = '',
    String lastname = '',
  }) async {
    try {
      _user = await UserApi.instance.signup(
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname,
      );
      _isLoggedIn = true;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoggedIn = false;
      _user = null;
      notifyListeners();
      return false;
    }
  }
}