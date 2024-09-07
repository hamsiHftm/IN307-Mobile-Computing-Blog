import 'dart:convert';
import '../model/user.dart';
import 'package:http/http.dart' as http;

class UserApi {
  // Singleton pattern: Private constructor and static instance
  static UserApi instance = UserApi._privateConstructor();

  UserApi._privateConstructor();

  static const String _baseUrl = "10.0.2.2:8080";
  final Map<String, String> _headers = {
    'Content-Type': '*/*', // Specify the content type for requests
    'Accept': '*/*'       // Specify the acceptable response content types
  };

  // Login a user with email and password
  Future<User> login(String email, String password) async {
    try {
      // Serialize login credentials to JSON
      final body = jsonEncode({
        'email': email,
        'password': password,
      });

      final response = await http.post(
        Uri.http(_baseUrl, "/auth/login"),
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        final Map<String, dynamic> data = responseJson['data'];
        var isSuccess = responseJson['isSuccess'];
        if (isSuccess) {
          return User.fromJson(data); // Convert JSON to User object
        } else {
          throw Exception(data['errorMsg']); // Handle error message from the server
        }
      } else {
        throw Exception(
            'Failed to login user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login user. Exception: $e');
    }
  }

  // Signup a new user with required and optional parameters
  Future<User> signup({
    required String email,
    required String password,
    String firstname = '',
    String lastname = '',
  }) async {
    try {
      // Serialize user data to JSON
      final body = jsonEncode({
        'email': email,
        'password': password,
        'firstname': firstname,
        'lastname': lastname,
      });

      final response = await http.post(
        Uri.http(_baseUrl, "/user"),
        headers: _headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        final Map<String, dynamic> data = responseJson['data'];
        var isSuccess = responseJson['isSuccess'];
        if (isSuccess) {
          return User.fromJson(data); // Convert JSON to User object
        } else {
          throw Exception(data['errorMsg']); // Handle error message from the server
        }
      } else {
        throw Exception(
            'Failed to create user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create user. Exception: $e');
    }
  }
}