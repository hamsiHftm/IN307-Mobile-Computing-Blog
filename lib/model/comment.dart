import 'user.dart';

class Comment {
  final int id;
  final String content;
  final int numberOfLikes;
  final DateTime createdAt;
  final User user;

  Comment({
    required this.id,
    required this.content,
    required this.numberOfLikes,
    required this.createdAt,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      numberOfLikes: json['numberOfLikes'],
      createdAt: DateTime.parse(json['createdAt']),
      user: User.fromJson(json['user']),
    );
  }
}