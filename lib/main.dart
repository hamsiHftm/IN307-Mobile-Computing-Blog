import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog-IN307',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const MyBlogListPage(title: 'Blog'),
    );
  }
}

class MyBlogListPage extends StatefulWidget {
  const MyBlogListPage({super.key, required this.title});

  final String title;

  @override
  State<MyBlogListPage> createState() => _MyBlogListPageState();
}

class _MyBlogListPageState extends State<MyBlogListPage> {
  var blogEntries = [
    BlogEntry("Flutter ist toll!", "Mit Flutter hebst du deune App-Entwicklung auf ein neues Level. Probier es aus!", DateTime(2024, 5, 24), false),
    BlogEntry("Der Kurs ist dabei abzuheben", "Fasten your seatbelts, we are ready for takeoff! Jetzt geht's ans Eingemachte. Bleib dabei!", DateTime(2024, 5, 22), true),
    BlogEntry("Klasse erzeugt eine super App", "Während dem aktiven Plenum hat die Klasse alles rausgeholt und eine tolle App gebaut. Alle waren beigeistert dabei und haben viel neues gelernt.", DateTime(2024, 5, 22), false),
  ];

  void _addBlog() {
    setState(() {
      blogEntries.add(BlogEntry("New Titel", "new Text", DateTime.now(), false));
    });
  }

  void _toggleFavorite(int index) {
    setState(() {
      blogEntries[index].isFavorite = !blogEntries[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _addBlog,
        ),
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary, // setting color background color
          title: Text(widget.title), // set appbar title
        ),
        body: ListView.builder(
            itemCount: blogEntries.length,
            itemBuilder: (context, index) {
              return BlogCard(
                  blog: blogEntries[index],
                  onFavoriteToggle: () => _toggleFavorite(index)
              );
            }
        ),
    );
  }
}

class BlogCard extends StatelessWidget {
  // constructor
  const BlogCard({
    super.key,
    required this.blog,
    required this.onFavoriteToggle,
  });

  final BlogEntry blog;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 25, 20, 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // blog title
                  Text(blog.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      )),
                  const SizedBox(height: 10,),
                  // blog text
                  Text(blog.text),
                  // date + favorite icon
                  const SizedBox(height: 15,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat("dd.M.yyyy").format(blog.date)),
                        IconButton(
                          onPressed: onFavoriteToggle,
                          icon: Icon(blog.isFavorite ? Icons.favorite : Icons.favorite_outline),
                        ),
                      ]),
                ]
            )
        )
    );
  }
}

class BlogEntry {
  String title;
  String text;
  DateTime date;
  bool isFavorite;

  BlogEntry(this.title, this.text, this.date, this.isFavorite);
}
