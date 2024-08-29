// lib/component/profile_widget.dart
import 'package:flutter/material.dart';

class ProfileIconWidget extends StatelessWidget {
  final String? picUrl;
  final double iconSize;
  final double containerSize;

  const ProfileIconWidget({
    super.key,
    this.picUrl,
    this.iconSize = 20.0,
    this.containerSize = 15.0
  });

  @override
  Widget build(BuildContext context) {
    return picUrl != null && picUrl!.isNotEmpty
        ? CircleAvatar(
      radius: containerSize,
      backgroundImage: NetworkImage(
        picUrl!,
      ),
      onBackgroundImageError: (error, stackTrace) {
        // Handle broken image scenario
        _buildPlaceholder(context);
      },
    )
        : _buildPlaceholder(context);
  }

  Widget _buildPlaceholder(BuildContext context) {
    return CircleAvatar(
      radius: containerSize,
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Icon(
        Icons.person_2_outlined,
        color: Theme.of(context).colorScheme.onPrimary,
        size: iconSize,
      ),
    );
  }
}