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

  Future<BlogResponse> getBlogs({
    int limit = 10,
    int offset = 0,
    bool favoritesOnly = false,
    String searchTitle = '',
    String? userId, // Optional userId parameter
    String orderBy = 'createdAt',
    bool asc = true,
  }) async {
    var queryParameters = {
      'limit': '$limit',
      'offset': '$offset',
      'asc': '$asc',
      'orderBy': orderBy,
      'searchTitle': Uri.encodeComponent(searchTitle),
      if (userId != null) 'userId': userId, // Add userId if it's not null
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

          // Retrieve the totalBlogs from the response
          int totalBlogs = blogsJson['data']['totalBlogs'];

          // Convert each blog JSON to a Blog object
          var blogs = blogsListJson.map((json) => Blog.fromJson(json)).toList();

          // Return the blogs list and the totalBlogs count
          return BlogResponse(blogs: blogs, totalBlogs: totalBlogs);
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

  // TODO
  Future<Blog> updateBlog(Blog blog) async {
    try {
      var body = "";
      final response = await http.patch(
          Uri.http(_baseUrl, "/public/blog/${blog.id}"),
          headers: _headers,
          body: body
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        return Blog.fromJson(data);
      } else {
        throw Exception('Failed to load blog. Status code: ${response.statusCode}');
      }
        return blog;
    } catch (e) {
      throw Exception('Failed to update blog. Exception: $e');
    }
  }

}

class BlogResponse {
  final List<Blog> blogs;
  final int totalBlogs;

  BlogResponse({required this.blogs, required this.totalBlogs});
}

