import 'package:flutter/foundation.dart';

class Blog {
  String title;
  String text;
  DateTime createdAt;
  // DateTime ?updatedAt;
  bool isFavorite;
  int numberOfLikes = 0;

  Blog(this.title, this.text, this.createdAt, this.isFavorite);
}

class BlogModel extends ChangeNotifier {
  List<Blog> _blogs = [
    Blog(
      "Flutter ist toll!",
      "Mit Flutter hebst du deine App-Entwicklung auf ein neues Level. Probier es aus!",
      DateTime(2024, 5, 24),
      false,
    ),
    Blog(
      "Der Kurs ist dabei abzuheben",
      "Fasten your seatbelts, we are ready for takeoff! Jetzt geht's ans Eingemachte. Bleib dabei!",
      DateTime(2024, 5, 22),
      true,
    ),
    Blog(
      "Klasse erzeugt eine super App",
      "Während dem aktiven Plenum hat die Klasse alles rausgeholt und eine tolle App gebaut. Alle waren begeistert dabei und haben viel neues gelernt.",
      DateTime(2024, 5, 22),
      false,
    ),
  ];

  List<Blog> get blogs => _blogs;

  void toggleFavorite(int index) {
    _blogs[index].isFavorite = !_blogs[index].isFavorite;
    notifyListeners(); // Notify listeners that the data has changed
  }

  int getIndexOfBlog(Blog blog) {
    return _blogs.indexOf(blog);
  }

  void addBlog(Blog newBlog) {
    _blogs.add(newBlog);
    notifyListeners(); // Notify listeners that the data has changed
  }

  void editBlog(int index, Blog editedBlog) {
    _blogs[index] = editedBlog;
    notifyListeners(); // Notify listeners that the data has changed
  }

}
