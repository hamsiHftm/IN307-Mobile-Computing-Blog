import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';

class BlogErrorWidget extends StatelessWidget {
  // Error message to display
  final String message;

  // Callback function to retry the operation
  final VoidCallback onRetry;

  // Flag to determine if the widget should use a scaffold
  final bool withScaffold;

  // Constructor with required parameters and optional scaffold flag
  const BlogErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.withScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    // Main content of the error widget
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Minimize the column size
        children: [
          // Error image
          Image.asset(
            'assets/images/error.png',
            width: 250, // Width of the error image
            height: 250, // Height of the error image
          ),
          const SizedBox(height: 8), // Space between image and text
          // Error message text
          Text(
            message,
            textAlign: TextAlign.center, // Center-align the text
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white), // Style of the text
          ),
          const SizedBox(height: 8), // Space between text and retry button
          // Retry button
          IconButton(
            icon: const Icon(Icons.refresh), // Refresh icon
            color: Colors.white, // Icon color
            iconSize: 30, // Icon size
            onPressed: onRetry, // Retry action callback
          ),
        ],
      ),
    );

    // Return either the scaffolded version or just the content
    if (withScaffold) {
      return BlogScaffoldWidget(
        showBackButton: true, // Show back button in the scaffold
        body: content, // The main content of the scaffold
      );
    } else {
      return content; // Return content without scaffold
    }
  }
}