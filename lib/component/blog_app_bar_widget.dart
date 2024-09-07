import 'package:flutter/material.dart';

class BlogAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  // Optional TabController for handling tab-based actions
  final TabController? tabController;

  // Callbacks for profile and search button actions
  final VoidCallback? onProfilePressed;
  final VoidCallback? onSearchPressed;

  // Flag to show or hide the back button
  final bool showBackButton;

  // Constructor with optional parameters and default values
  const BlogAppBarWidget({
    super.key,
    this.tabController,
    this.onProfilePressed,
    this.onSearchPressed,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0, // Remove shadow for a flat appearance
      backgroundColor: Colors.transparent, // Transparent background
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back), // Back button icon
        color: Colors.white, // Icon color
        onPressed: () {
          Navigator.of(context).pop(); // Navigate back when pressed
        },
      )
          : IconButton(
        icon: const Icon(Icons.person), // Profile button icon
        color: Colors.white, // Icon color
        onPressed: onProfilePressed, // Callback for profile button
      ),
      actions: [
        // Show search button only when tabController is provided and on the first tab
        if (tabController != null && tabController!.index == 0)
          IconButton(
            icon: const Icon(Icons.search), // Search button icon
            color: Colors.white, // Icon color
            onPressed: onSearchPressed, // Callback for search button
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Default height of the AppBar
}