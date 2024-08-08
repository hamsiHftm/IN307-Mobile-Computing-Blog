import 'package:flutter/foundation.dart';

class Blog {
  int? id;
  String title;
  String text;
  DateTime createdAt;
  // DateTime ?updatedAt;
  bool isFavorite;
  int numberOfLikes = 0;

  Blog(this.title, this.text, this.createdAt, this.isFavorite);

  factory Blog.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'title': String title,
      'text': String text,
      'createdAt': DateTime createdAt,
      'numberOfLikes': int numberOfLikes
      } =>
          Blog(
            title,
            text,
            createdAt,
            false
          ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }

}
