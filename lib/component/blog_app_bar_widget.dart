import 'package:flutter/material.dart';

class BlogAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final TabController? tabController;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onAddBlogPressed;
  final bool showBackButton;

  const BlogAppBarWidget({
    Key? key,
    this.tabController,
    this.onProfilePressed,
    this.onSearchPressed,
    this.onAddBlogPressed,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: showBackButton
          ? IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
          : IconButton(
        icon: const Icon(Icons.person),
        onPressed: onProfilePressed,
      ),
      actions: [
        if (tabController != null && tabController!.index == 0)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearchPressed,
          ),
        if (tabController != null && tabController!.index == 1)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddBlogPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}