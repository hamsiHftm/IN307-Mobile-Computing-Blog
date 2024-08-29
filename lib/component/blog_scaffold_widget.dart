import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_app_bar_widget.dart';

class BlogScaffoldWidget extends StatelessWidget {
  final Widget body;
  final TabController? tabController;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onAddBlogPressed;
  final Widget? bottomNavigationBar;
  final bool showBackButton;
  final bool disableAppBar; // New parameter to control visibility of the app bar

  const BlogScaffoldWidget({
    super.key,
    required this.body,
    this.tabController,
    this.onProfilePressed,
    this.onSearchPressed,
    this.onAddBlogPressed,
    this.bottomNavigationBar,
    this.showBackButton = false,
    this.disableAppBar = false, // Default value is false (app bar is shown by default)
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onPrimaryContainer,
              Theme.of(context).colorScheme.onSecondaryContainer
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
            // Conditionally render the app bar based on disableAppBar
            if (!disableAppBar)
              BlogAppBarWidget(
                tabController: tabController,
                onProfilePressed: onProfilePressed,
                onSearchPressed: onSearchPressed,
                onAddBlogPressed: onAddBlogPressed,
                showBackButton: showBackButton,
              ),
            Expanded(child: body),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}