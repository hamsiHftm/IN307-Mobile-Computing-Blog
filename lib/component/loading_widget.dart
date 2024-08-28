// lib/component/loading_widget.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading.json',  // Path to your Lottie animation
        width: 200,
        height: 400,
      ),
    );
  }
}