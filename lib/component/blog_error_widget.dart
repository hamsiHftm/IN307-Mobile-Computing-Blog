// lib/component/error_widget.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BlogErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const BlogErrorWidget({
    Key? key,
    required this.message,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Lottie animation for a sad or error animation
          Image.asset(
            'assets/images/error.png',
            width: 250,
            height: 250,
          ),
          SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 20),
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.blue,
            iconSize: 30,
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}