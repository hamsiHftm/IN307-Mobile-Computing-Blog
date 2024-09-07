import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_app_bar_widget.dart';

class BlogScaffoldWidget extends StatelessWidget {
  // Main content of the scaffold
  final Widget body;

  // Optional TabController for handling tab navigation
  final TabController? tabController;

  // Callbacks for profile and search button presses
  final VoidCallback? onProfilePressed;
  final VoidCallback? onSearchPressed;

  // Optional bottom navigation bar
  final Widget? bottomNavigationBar;

  // Flag to determine if the back button should be shown
  final bool showBackButton;

  // Constructor with required body and optional parameters
  const BlogScaffoldWidget({
    super.key,
    required this.body,
    this.tabController,
    this.onProfilePressed,
    this.onSearchPressed,
    this.bottomNavigationBar,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main container with a gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onPrimaryContainer, // Gradient start color
              Theme.of(context).colorScheme.onSecondaryContainer // Gradient end color
            ],
            begin: Alignment.centerLeft, // Gradient direction start
            end: Alignment.centerRight,   // Gradient direction end
          ),
        ),
        child: Column(
          children: [
            // Custom AppBar with optional parameters
            BlogAppBarWidget(
              tabController: tabController,
              onProfilePressed: onProfilePressed,
              onSearchPressed: onSearchPressed,
              showBackButton: showBackButton,
            ),
            // Main content of the scaffold
            Expanded(child: body),
          ],
        ),
      ),
      // Optional bottom navigation bar
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}