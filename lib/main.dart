import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/component/blog_list.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:in307_mobile_computing_blog/screens/blog_form_view.dart';
import 'package:in307_mobile_computing_blog/screens/blog_list_view.dart';
import 'package:in307_mobile_computing_blog/screens/profile_view.dart';
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

final ThemeData blogThemeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFE89BB0),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFC46A83), // Primary Color
    secondary: Color(0xFF6B5D73), // Secondary Color
    surface: Color(0xFFE89BB0), // Surface Color
    onPrimary: Colors.white,
    onSecondary: Color(0xFF352B3B),
    onSurface: Colors.white,
  ),
  fontFamily: 'CenturyGothic',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600),
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
    ),
    labelColor: Colors.white, // Color for the selected tab's label
    unselectedLabelColor: const Color(0xFF6B5D73), // Color for the unselected tab's icon and text
    unselectedLabelStyle: const TextStyle(color: Color(0xFF6B5D73)), // Text style for the unselected tab
    indicatorSize: TabBarIndicatorSize.tab,
  ),
);

final ThemeData blogThemeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF6B5D73),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF6B5D73), // Primary Color
    secondary: Color(0xFFC46A83), // Secondary Color
    surface: Color(0xFF8A5765), // Surface Color
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
  ),
  fontFamily: 'CenturyGothic',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600),
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      color: Colors.white.withOpacity(0.5), // White color with 50% opacity for selected tab
      borderRadius: BorderRadius.circular(60), // Oval shape for the selected tab
    ),
    labelColor: Colors.white, // Color for the selected tab's label
    unselectedLabelColor: Colors.red, // Color for the unselected tab's icon and text
    unselectedLabelStyle: TextStyle(color: Colors.red), // Text style for the unselected tab
    indicatorSize: TabBarIndicatorSize.tab,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
  ),
);

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BlogModel(),
      child: MaterialApp(
        title: 'Blog-IN307',
        theme: blogThemeLight,
        darkTheme: blogThemeDark,
        themeMode: ThemeMode.system,
        home: const DefaultTabController(
          length: 3,
          child: MyBlogListPage(),
        ),
      ),
    ),
  );
}

class MyBlogListPage extends StatefulWidget {
  const MyBlogListPage({Key? key}) : super(key: key);

  @override
  State<MyBlogListPage> createState() => _MyBlogListPageState();
}

class _MyBlogListPageState extends State<MyBlogListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _openProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileView()),
    );
  }

  void _openSearchForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Blog'),
        content: TextField(
          decoration: InputDecoration(hintText: 'Enter blog title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: _openProfilePage,
        ),

        // TODO replace search and add button
        actions: [
          // Show the search button only on the first tab (index 0)
          if (_tabController.index == 0)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _openSearchForm,
            ),
          // Show the add button only on the second tab (index 1)
          if (_tabController.index == 1)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogFormView(
                      onSave: ({required Blog newBlog, Blog? oldBlog}) {
                        Provider.of<BlogModel>(context, listen: false).addBlog(newBlog);
                        _tabController.animateTo(0);
                      },
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      body: Consumer<BlogModel>(
        builder: (context, blogModel, child) {
          return TabBarView(
            controller: _tabController,
            children: [
              BlogListView(),
              Center(
                child: BlogFormView(
                  onSave: ({required Blog newBlog, Blog? oldBlog}) {
                    blogModel.addBlog(newBlog);
                    _tabController.animateTo(0);
                  },
                ),
              ),
              BlogListView(),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary], // Customize the gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          // color: Theme.of(context).colorScheme.surface
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Home'),
            Tab(icon: Icon(Icons.add_circle), text: 'Add Blog'),
            Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
          ],
        ),
      ),
    );
  }
}
