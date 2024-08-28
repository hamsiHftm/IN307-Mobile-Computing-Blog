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

  const BlogScaffoldWidget({
    Key? key,
    required this.body,
    this.tabController,
    this.onProfilePressed,
    this.onSearchPressed,
    this.onAddBlogPressed,
    this.bottomNavigationBar,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: [
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