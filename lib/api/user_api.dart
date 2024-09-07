import 'dart:convert';
import '../model/user.dart';
import 'package:http/http.dart' as http;

class UserApi{
  // Static instance + private Constructor for simple Singleton-approach
  static UserApi instance = UserApi._privateConstructor();
  UserApi._privateConstructor();

  static const String _baseUrl = "10.0.2.2:8080";
  final Map<String, String> _headers = {
    'Content-Type': '*/*',
    'Accept': '*/*'
  };

  Future<User> login(String email, String password) async {
    try {
      final body = jsonEncode({
        'email': email,
        'password': password,
      });

      final response = await http.post(
        Uri.http(_baseUrl, "/auth/login"),
        headers: _headers, body: body
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        var isSuccess = jsonDecode(response.body)['isSuccess'];
        if (isSuccess) {
          return User.fromJson(data);
        } else {
          throw Exception(data['errorMsg']);
        }
      } else {
        throw Exception('Failed to load blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blog. Exception: $e');
    }
  }
}