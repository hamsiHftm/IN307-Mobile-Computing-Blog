import 'package:flutter/material.dart';
import '../api/user_api.dart'; // Import your UserApi class
import '../model/user.dart';   // Import the User model

class UserProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  User? _user; // Store the logged-in user
  String? _errorMessage; // Store the error message if login fails

  bool get isLoggedIn => _isLoggedIn;
  User? get user => _user; // Getter to access the logged-in user
  String? get errorMessage => _errorMessage; // Getter for the error message

  // Method to handle login using UserApi
  Future<bool> login(String email, String password) async {
    try {
      // Call the UserApi to perform the login
      _user = await UserApi.instance.login(email, password);

      // If login is successful, update login state and notify listeners
      _isLoggedIn = true;
      _errorMessage = null; // Clear previous error messages
      notifyListeners();
      return true;
    } catch (e) {
      // Capture the error message from the exception and return false
      _errorMessage = e.toString();
      _isLoggedIn = false;
      _user = null;
      notifyListeners(); // Notify listeners about the error state
      return false;
    }
  }

  // Method to handle logout
  void logout() {
    _isLoggedIn = false;
    _user = null; // Clear the user info
    _errorMessage = null; // Clear error messages on logout
    notifyListeners(); // Notify listeners about the logout
  }

  signUp(String text, String text2, String text3, String text4) {}
}