import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'blog_scaffold_widget.dart';

class LoadingWidget extends StatelessWidget {
  final bool withScaffold;

  const LoadingWidget({
    Key? key,
    this.withScaffold = false, // Default value is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Lottie.asset(
        'assets/animations/loading.json',
        width: 200,
        height: 200,
      ),
    );

    if (withScaffold) {
      return BlogScaffoldWidget(
        showBackButton: true,
        body: content,
      );
    } else {
      return content;
    }
  }
}
