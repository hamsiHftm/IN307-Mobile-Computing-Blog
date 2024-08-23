class Comment {
  int? id;
  String content;
  DateTime createdAt;
  DateTime ?updatedAt;
  int numberOfLikes = 0;

  Comment(this.content, this.createdAt);

  factory Comment.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
      'title': String title,
      'content': String content,
      'createdAt': DateTime createdAt,
      'numberOfLikes': int numberOfLikes
    } => Comment(
        title,
        createdAt
      ),
    _ => throw const FormatException('Failed to load comment'),
    };
  }
}