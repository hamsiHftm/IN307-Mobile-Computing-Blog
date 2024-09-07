// lib/component/profile_widget.dart
import 'package:flutter/material.dart';

class ProfileIconWidget extends StatelessWidget {
  // URL for the profile picture; can be null
  final String? picUrl;
  // Size of the icon within the CircleAvatar
  final double iconSize;
  // Size of the CircleAvatar container
  final double containerSize;

  // Constructor with default values for iconSize and containerSize
  const ProfileIconWidget({
    super.key,
    this.picUrl,
    this.iconSize = 20.0,
    this.containerSize = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    // Check if picUrl is not null and not empty
    return picUrl != null && picUrl!.isNotEmpty
        ? CircleAvatar(
      radius: containerSize, // Radius of the CircleAvatar
      backgroundImage: NetworkImage(
        picUrl!, // Load image from the network using the provided URL
      ),
      onBackgroundImageError: (error, stackTrace) {
        // Handle the case where the image fails to load
        _buildPlaceholder(context); // Show placeholder icon
      },
    )
        : _buildPlaceholder(context); // Show placeholder icon if picUrl is null or empty
  }

  // Method to build a placeholder CircleAvatar when picUrl is not available
  Widget _buildPlaceholder(BuildContext context) {
    return CircleAvatar(
      radius: containerSize, // Radius of the CircleAvatar
      backgroundColor: Theme.of(context).colorScheme.surface, // Background color of the placeholder
      child: Icon(
        Icons.person_2_outlined, // Icon to display when no image is available
        color: Theme.of(context).colorScheme.onPrimary, // Color of the icon
        size: iconSize, // Size of the icon
      ),
    );
  }
}