import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:in307_mobile_computing_blog/component/blog_search_dialog_widget.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:in307_mobile_computing_blog/provider/blog_provider.dart';
import 'package:in307_mobile_computing_blog/provider/user_provider.dart';
import 'package:in307_mobile_computing_blog/screens/blog_form_view.dart';
import 'package:in307_mobile_computing_blog/screens/blog_list_view.dart';
import 'package:in307_mobile_computing_blog/screens/login_view.dart';
import 'package:in307_mobile_computing_blog/screens/profile_view.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

final ThemeData blogThemeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFD12B41),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFD12B41), // Primary Color
    secondary: Color(0xFF412349),
    tertiary: Colors.white,// Secondary Color
    onPrimaryContainer: Color(0xFFD12B41), // Primary Color
    onSecondaryContainer: Color(0xFF412349),
    surface: Colors.white, // Surface Color
    onPrimary: Color(0xFFE4A49B),
    onSecondary: Color(0xFF412349),
    onSurface: Color(0xFF412349),
  ),
  fontFamily: 'CenturyGothic',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Color(0xFFD12B41)),
    displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w200, color: Color(0xFFD12B41)),
    displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w200, color: Color(0xFFD12B41)),
    headlineLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Color(0xFFD12B41)),
    headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Color(0xFFD12B41)),
    headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Color(0xFFD12B41)),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Color(0xFF412349)),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Color(0xFFE4A49B)),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Color(0xFF412349)),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Color(0xFFE4A49B)),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Color(0xFFE4A49B)),
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Color(0xFFE4A49B)),
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
    ),
    labelColor: Colors.white, // Color for the selected tab's label
    unselectedLabelColor: Colors.white, // Color for the unselected tab's icon and text
    indicatorSize: TabBarIndicatorSize.tab,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return const Color(0xFFD12B41);
        } else if (states.contains(WidgetState.pressed)) {
          return const Color(0xFFE4A49B); // Pressed color
        }
        return const Color(0xFF412349); // Default text color
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return const Color(0xFF412349).withOpacity(0.1); // Background color on hover
        } else if (states.contains(WidgetState.pressed)) {
          return const Color(0xFF412349).withOpacity(0.2); // Background color on pressed
        }
        return Colors.transparent; // Default background color
      }),
      overlayColor: WidgetStateProperty.all(const Color(0xFF412349).withOpacity(0.1)), // Ripple effect
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey; // Background color when the button is disabled
        }
        return const Color(0xFFD12B41); // Default background color
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white; // Text color when the button is disabled
        }
        return Colors.white; // Text color for all other states
      }),
      overlayColor: WidgetStateProperty.all(const Color(0xFF412349).withOpacity(0.1)), // Ripple effect
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    ),
  ),
);

final ThemeData blogThemeDark = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFFD12B41),
  colorScheme: ColorScheme.light(
    primary: Colors.white, // Primary Color
    secondary: const Color(0xFF412349),
    tertiary: Colors.transparent,
    onPrimaryContainer: const Color(0xFFD12B41), // Primary Color
    onSecondaryContainer: const Color(0xFF412349),// Secondary Color
    surface: Colors.white.withOpacity(0.2), // Surface Color
    onPrimary: const Color(0xFFE4A49B),
    onSecondary: const Color(0xFF412349),
    onSurface: Colors.white,
  ),
  fontFamily: 'CenturyGothic',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w200, color:  Color(0xFFD12B41)),
    displaySmall: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w200, color: Color(0xFFD12B41)),
    headlineLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.white),
    labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: Colors.white),
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
    ),
    labelColor: Colors.white, // Color for the selected tab's label
    unselectedLabelColor: Colors.white, // Color for the unselected tab's icon and text
    indicatorSize: TabBarIndicatorSize.tab,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return const Color(0xFFD12B41);
        } else if (states.contains(WidgetState.pressed)) {
          return const Color(0xFFE4A49B); // Pressed color
        }
        return const Color(0xFF412349); // Default text color
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.hovered)) {
          return const Color(0xFF412349).withOpacity(0.1); // Background color on hover
        } else if (states.contains(WidgetState.pressed)) {
          return const Color(0xFF412349).withOpacity(0.2); // Background color on pressed
        }
        return Colors.transparent; // Default background color
      }),
      overlayColor: WidgetStateProperty.all(const Color(0xFF412349).withOpacity(0.1)), // Ripple effect
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey; // Background color when the button is disabled
        }
        return const Color(0xFFD12B41); // Default background color
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white; // Text color when the button is disabled
        }
        return Colors.white; // Text color for all other states
      }),
      overlayColor: WidgetStateProperty.all(const Color(0xFF412349).withOpacity(0.1)), // Ripple effect
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      ),
    ),
  ),
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()), // Add UserProvider here
        ChangeNotifierProvider(create: (context) => BlogModel()), // Existing provider
      ],
      child: MaterialApp(
        title: 'Blog-IN307',
        theme: blogThemeLight,
        darkTheme: blogThemeDark,
        themeMode: ThemeMode.dark,
        home: const DefaultTabController(
          length: 3,
          child: MyBlogListPage(),
        ),
        // Define routes for navigation if needed
        routes: {
          '/login': (context) => const LoginView(),
          // Define other routes as needed
        },
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
    Navigator.of(context).push(
      MaterialPageRoute(
        // builder: (context) => ProfileView(
        //   user: User(
        //     id: 1,
        //     email: 'test@test.ch',
        //     firstname: 'test',
        //     lastname: 'jjsj',
        //   ),
        //   totalBlogs: 30,
        // ),
        builder: (context) => LoginView(

        ),
      ),
    );
  }

  void _openSearchForm() {
    showDialog(
      context: context,
      builder: (context) => BlogSearchDialog(
        onSearch: (searchTerm) {
          // When a search term is provided, update the blog list view
          Provider.of<BlogModel>(context, listen: false).fetchBlogs(
            refresh: true, // Refresh the list when searching
            searchTitle: searchTerm, // Pass the search term to filter the blogs
          );
          print('Searching for: $searchTerm'); // Debug print to show the search term
        },

      )
    );
  }


  @override
  Widget build(BuildContext context) {
    User currentUser = User(
        id: 1,
        email: "user@example.com",
        firstname: "John",
        lastname: "Doe",
        picUrl: "https://example.com/johndoe.png"
    );
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
              const BlogListView(showUserBlogsOnly: true),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.onPrimaryContainer, Theme.of(context).colorScheme.onSecondaryContainer], // Customize the gradient colors
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
