import 'package:flutter/material.dart';

class BlogAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabController? tabController;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onAddBlogPressed;
  final bool showBackButton;

  const BlogAppBarWidget({
    super.key,
    this.tabController,
    this.onProfilePressed,
    this.onSearchPressed,
    this.onAddBlogPressed,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : IconButton(
        icon: const Icon(Icons.person),
        color: Colors.white,
        onPressed: onProfilePressed,
      ),
      actions: [
        if (tabController != null && tabController!.index == 0)
          IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: onSearchPressed,
          ),
        if (tabController != null && tabController!.index == 1)
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white,
            onPressed: onAddBlogPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}