import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:in307_mobile_computing_blog/screens/blog_form_view.dart';
import 'package:in307_mobile_computing_blog/screens/blog_list_view.dart';
import 'package:in307_mobile_computing_blog/screens/profile_view.dart';
import 'package:provider/provider.dart';

final ThemeData blogThemeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFD12B41),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFD12B41), // Primary Color
    secondary: Color(0xFF412349), // Secondary Color
    surface: Colors.white, // Surface Color
    onPrimary: Color(0xFFE4A49B),
    onSecondary: Color(0xFF412349),
    onSurface: Colors.white,
  ),
  fontFamily: 'CenturyGothic',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w200),
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
    unselectedLabelColor: Colors.white, // Color for the unselected tab's icon and text
    indicatorSize: TabBarIndicatorSize.tab,
  ),
);

final ThemeData blogThemeDark = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFD12B41),
  colorScheme: ColorScheme.light(
    primary: const Color(0xFFD12B41), // Primary Color
    secondary: const Color(0xFF412349), // Secondary Color
    surface: Colors.white.withOpacity(0.2), // Surface Color
    onPrimary: const Color(0xFFE4A49B),
    onSecondary: const Color(0xFF412349),
    onSurface: Colors.white,
  ),
  fontFamily: 'CenturyGothic',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w200),
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
    unselectedLabelColor: Colors.white, // Color for the unselected tab's icon and text
    indicatorSize: TabBarIndicatorSize.tab,
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
        themeMode: ThemeMode.dark,
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
    return BlogScaffoldWidget(
      tabController: _tabController,
      onProfilePressed: _openProfilePage,
      onAddBlogPressed: () {
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
      onSearchPressed: _openSearchForm,
      body: Consumer<BlogModel>(
        builder: (context, blogModel, child) {
          return TabBarView(
            controller: _tabController,
            children: [
              const BlogListView(),
              Center(
                child: BlogFormView(
                  onSave: ({required Blog newBlog, Blog? oldBlog}) {
                    blogModel.addBlog(newBlog);
                    _tabController.animateTo(0);
                  },
                ),
              ),
              const BlogListView(),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary], // Customize the gradient colors
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          // color: Theme.of(context).colorScheme.surface
        ),
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.home_sharp), text: 'Home'),
            Tab(icon: Icon(Icons.menu_book_sharp), text: 'My Blogs'),
            Tab(icon: Icon(Icons.favorite_border_outlined), text: 'Favorites'),
          ],
        ),
      ),
    );
  }
}
