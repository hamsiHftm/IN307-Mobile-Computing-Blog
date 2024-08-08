import 'dart:convert';
import '../model/blog.dart';
import 'package:http/http.dart' as http;

class BlogApi {
  // Static instance + private Constructor for simple Singleton-approach
  static BlogApi instance = BlogApi._privateConstructor();
  BlogApi._privateConstructor();

  static const String _baseUrl = "http://localhost:8080";

  Future<List<Blog>> getBlogs() async {
    var queryParameters = {
      'limit': '20',
      'offset': '0',
      'asc': 'true',
      'orderBy': 'createdAt',
      'searchTitle': ''
    };
    try {
      final response = await http.get(
        Uri.https(_baseUrl, "/blogs", queryParameters)
      );
      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = jsonDecode(response.body)["documents"];
        var blogs = blogsJson.map((json) => Blog.fromJson(json)).toList();
        return blogs;
      } else {
        throw Exception(
            'Failed to load blogs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blogs. Exception: $e');
    }
  }
}