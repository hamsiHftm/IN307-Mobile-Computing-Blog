import 'dart:convert';
import '../model/blog.dart';
import 'package:http/http.dart' as http;

class BlogApi {
  // Singleton pattern: Private constructor and static instance
  static BlogApi instance = BlogApi._privateConstructor();

  BlogApi._privateConstructor();

  static const String _baseUrl = "10.0.2.2:8080";
  final Map<String, String> _headers = {
    'Content-Type': '*/*', // Specify the content type for requests
    'Accept': '*/*'       // Specify the acceptable response content types
  };

  // Fetch a list of blogs with optional filters
  Future<BlogResponse> getBlogs({
    int limit = 10,
    int offset = 0,
    bool favoritesOnly = false,
    String searchTitle = '',
    int? userId, // Optional userId parameter
    String orderBy = 'createdAt',
    bool asc = true,
  }) async {
    // Build query parameters for the request
    var queryParameters = {
      'limit': '$limit',
      'offset': '$offset',
      'asc': '$asc',
      'orderBy': orderBy,
      'searchTitle': Uri.encodeComponent(searchTitle),
      if (userId != null) 'userId': '$userId', // Include userId if provided
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

          // Retrieve the total number of blogs from the response
          int totalBlogs = blogsJson['data']['totalBlogs'];

          // Convert each blog JSON object to a Blog instance
          var blogs = blogsListJson.map((json) => Blog.fromJson(json)).toList();

          // Return the list of blogs and the total count
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

  // Fetch a single blog by its ID
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
        throw Exception(
            'Failed to load blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blog. Exception: $e');
    }
  }

  // Update an existing blog
  Future<Blog> updateBlog(Blog blog) async {
    try {
      // Serialize the blog object to JSON
      var body = "";
      final response = await http.patch(
        Uri.http(_baseUrl, "/blogs/${blog.id}"),
        headers: _headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        return Blog.fromJson(data);
      } else {
        throw Exception(
            'Failed to update blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update blog. Exception: $e');
    }
  }

  // Add a new blog
  Future<Blog> addBlog({
    required String title,
    required String content,
    required int userId,
    String picUrl = '',
  }) async {
    try {
      // Serialize the blog details to JSON
      var body = jsonEncode({
        'title': title,
        'content': content,
        'picUrl': picUrl,
        'userId': '$userId'
      });
      final response = await http.post(
        Uri.http(_baseUrl, "/blogs"),
        headers: _headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body)['data'];
        return Blog.fromJson(data);
      } else {
        throw Exception(
            'Failed to add blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to add blog. Exception: $e');
    }
  }
}

// Class to encapsulate the response for a list of blogs
class BlogResponse {
  final List<Blog> blogs;
  final int totalBlogs;

  BlogResponse({required this.blogs, required this.totalBlogs});
}