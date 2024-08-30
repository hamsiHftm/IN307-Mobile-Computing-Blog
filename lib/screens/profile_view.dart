import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:in307_mobile_computing_blog/component/profile_icon_widget.dart';
import '../model/user.dart';

class ProfileView extends StatelessWidget {
  final User user;
  final int totalBlogs;

  const ProfileView({
    Key? key,
    required this.user,
    required this.totalBlogs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlogScaffoldWidget(
      showBackButton: true,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure full width
          children: [
            // Display user profile picture if available
            const Center(
              // Center the ProfileIconWidget
              child: ProfileIconWidget(
                iconSize: 60,
                containerSize: 60,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                user.getDisplayName(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equally divide columns
              children: [
                // Blogs count
                Column(
                  children: [
                    Text(
                      totalBlogs.toString(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      "Blogs",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                // Comments count
                Column(
                  children: [
                    Text(
                      "30", // This would be dynamic if available
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      "Comments",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              // Expand the container to cover until the bottom
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ), // Top-only border radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure buttons are full width
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Theme',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Switch(
                          value: Theme.of(context).brightness == Brightness.dark,
                          onChanged: (bool value) {
                            // TODO: Implement theme change logic
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // Edit Profile button
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement edit profile logic
                      },
                      child: Text('Edit Profile'),
                    ),
                    const SizedBox(height: 16.0),
                    // Logout button
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement logout logic
                      },
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}