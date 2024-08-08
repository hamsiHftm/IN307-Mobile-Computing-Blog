import 'package:flutter/cupertino.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';


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

  BlogModel() {
    fetchBlogs(); // Fetch blogs when the model is created
  }

  void toggleFavorite(int index) {
    _blogs[index].isFavorite = !_blogs[index].isFavorite;
    notifyListeners(); // Notify listeners that the data has changed
  }

  Future<void> fetchBlogs() async {
    try {
      _blogs = await BlogApi.instance.getBlogs();
      notifyListeners(); // Notify listeners that the data has changed
    } catch (e) {
      // Handle error
      print("Error fetching blogs: $e");
    }
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