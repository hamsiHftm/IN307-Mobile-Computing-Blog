import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';

class BlogErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final bool withScaffold;

  const BlogErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.withScaffold = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/error.png',
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          IconButton(
            icon: const Icon(Icons.refresh),
            color: Colors.white,
            iconSize: 30,
            onPressed: onRetry,
          ),
        ],
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
