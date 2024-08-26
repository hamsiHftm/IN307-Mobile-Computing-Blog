import 'dart:convert';
import '../model/blog.dart';
import 'package:http/http.dart' as http;

class BlogApi {
  // Static instance + private Constructor for simple Singleton-approach
  static BlogApi instance = BlogApi._privateConstructor();
  BlogApi._privateConstructor();

  static const String _baseUrl = "10.0.2.2:8080";
  final Map<String, String> _headers = {
    'Content-Type': '*/*',
    'Accept': '*/*'
  };

  Future<List<Blog>> getBlogs({int limit = 10, int offset = 0, bool favoritesOnly = false}) async {
    var queryParameters = {
      'limit': '$limit',
      'offset': '$offset',
      'asc': 'true',
      'orderBy': 'createdAt',
      'searchTitle': ''
    };

    try {
      final response = await http.get(
        Uri.http(_baseUrl, "/public/blog", queryParameters),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> blogsJson = jsonDecode(response.body);
        var isSuccess = blogsJson['isSuccess'];
        if (isSuccess) {
          final List<dynamic> blogsListJson = blogsJson['data']['blogs'];
          var blogs = blogsListJson.map((json) => Blog.fromJson(json)).toList();
          return blogs;
        } else {
          throw Exception('Failed to load blogs. isSuccess=False');
        }
      } else {
        throw Exception(
            'Failed to load blogs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blogs. Exception: $e');
    }
  }

  Future<Blog?> getBlogById(int id) async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, "/public/blog/$id"),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        return Blog.fromJson(data);
      } else {
        throw Exception('Failed to load blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blog. Exception: $e');
    }
  }

}