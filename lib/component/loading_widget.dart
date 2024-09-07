import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'blog_scaffold_widget.dart';

class LoadingWidget extends StatelessWidget {
  // Determines whether to wrap the loading indicator in a BlogScaffoldWidget
  final bool withScaffold;

  // Constructor to initialize the widget with an optional BlogScaffoldWidget
  const LoadingWidget({
    Key? key,
    this.withScaffold = false, // Default value is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The content of the widget, displaying a Lottie animation
    Widget content = Center(
      child: Lottie.asset(
        'assets/animations/loading.json', // Path to the Lottie animation file
        width: 200, // Width of the animation
        height: 200, // Height of the animation
      ),
    );

    // Conditionally wrap the content with BlogScaffoldWidget if withScaffold is true
    if (withScaffold) {
      return BlogScaffoldWidget(
        showBackButton: true, // Show a back button in the scaffold
        body: content, // Set the content as the body of the scaffold
      );
    } else {
      // Return the content directly if no scaffold is needed
      return content;
    }
  }
}