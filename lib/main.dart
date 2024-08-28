import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/component/blog_list.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:in307_mobile_computing_blog/screens/blog_form_view.dart';
import 'package:in307_mobile_computing_blog/screens/blog_list_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

final ThemeData blogTheme = ThemeData(
  colorScheme: ColorScheme(
    primary: Color(0xFFC46A83), // Primary Color
    secondary: Color(0xFF6B5D73), // Secondary Color
    surface: Color(0xFFE89BB0), // Accent Color
    background: Color(0xFF8A5765), // Background Color
    error: Colors.red,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Color(0xFF352B3B), // Text Color
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xFFC46A83), // Primary Color for AppBar
    foregroundColor: Colors.white,
    elevation: 0, // Remove shadow for a cleaner look
    toolbarHeight: 60, // Adjust height
  ),
  scaffoldBackgroundColor: Colors.white, // Background Color for Scaffold
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 36,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    displayMedium: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 30,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    displaySmall: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    headlineLarge: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    headlineMedium: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    headlineSmall: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    titleLarge: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    titleMedium: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    titleSmall: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    bodyLarge: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    bodyMedium: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    bodySmall: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    labelLarge: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    labelMedium: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 12,
      fontWeight: FontWeight.w600,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    labelSmall: TextStyle(
      color: Color(0xFF352B3B),
      fontSize: 10,
      fontWeight: FontWeight.w600,
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFFC46A83), // Primary Color for Buttons
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white, backgroundColor: Color(0xFFC46A83),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners for buttons
      ),
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xFF352B3B), // Icon Color
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF6B5D73)), // Secondary Color for Borders
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFC46A83)), // Primary Color for Focused Borders
    ),
    labelStyle: TextStyle(
      color: Color(0xFF352B3B), // Label Color
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    hintStyle: TextStyle(
      color: Color(0xFF6B5D73), // Hint Color
      fontFamily: 'CenturyGothic', // Use Century Gothic
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding for inputs
  ),
  dividerTheme: DividerThemeData(
    color: Color(0xFF6B5D73), // Color for dividers
    thickness: 1,
    space: 24,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFF352B3B), // Background Color for SnackBars
    contentTextStyle: TextStyle(color: Colors.white),
  ),
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BlogModel(),
      child: MaterialApp(
        title: 'Blog-IN307',
        theme: blogTheme,
        home: DefaultTabController(
          length: 5,
          child: const MyBlogListPage(title: 'Blog'),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO add custom icon for app
      title: 'Blog-IN307',
      // TODO create custom theme
      home: DefaultTabController(
        length: 5,
        child: const MyBlogListPage(title: 'Blog'),
      ),
    );
  }
}

class MyBlogListPage extends StatefulWidget {
  const MyBlogListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyBlogListPage> createState() => _MyBlogListPageState();
}

class _MyBlogListPageState extends State<MyBlogListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), // TODO add search bar instead of text
      ),
      body: Consumer<BlogModel>(
        builder: (context, blogModel, child) {
          return TabBarView(
            controller: _tabController,
            children: [
              BlogListView(),
              BlogListView(),
              Center(
                child: BlogFormView(
                  onSave: ({required Blog newBlog, Blog? oldBlog}) {
                    blogModel.addBlog(newBlog);
                    _tabController.animateTo(0);
                  },
                ),
              ),
              Center(child: Text('Menu')), // TODO add blog list only created by the signed in user
              Center(child: Text('Profile')), // TODO add Profile page
            ],
          );
        },
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(icon: Icon(Icons.home), text: 'Home'),
          Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
          Tab(icon: Icon(Icons.add_circle), text: 'Add Blog'),
          Tab(icon: Icon(Icons.menu), text: 'My blogs'),
          Tab(icon: Icon(Icons.account_circle), text: 'Profile'),
        ],
      ),
    );
  }
}
