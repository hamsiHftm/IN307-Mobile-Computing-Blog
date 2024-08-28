import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BlogScaffoldWidget(
      showBackButton: true,
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}