import 'package:flutter/foundation.dart';
import 'user.dart';

class Blog {
  int id;
  String title;
  String content;
  DateTime createdAt;
  DateTime? updatedAt;
  bool isFavorite;
  int numberOfLikes;
  User? user;
  String? picUrl;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.updatedAt,
    this.isFavorite = false,
    this.numberOfLikes = 0,
    this.user,
    this.picUrl,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      numberOfLikes: json['numberOfLikes'] ?? 0,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}