import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider package
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:in307_mobile_computing_blog/component/profile_icon_widget.dart';
import '../model/user.dart';
import '../provider/user_provider.dart';
import 'login_view.dart'; // Import UserProvider

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final isLoggedIn = userProvider.isLoggedIn;

    if (!isLoggedIn) {
      // User is not logged in
      return BlogScaffoldWidget(
        showBackButton: true,
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
            child: Text('Login'),
          ),
        ),
      );
    }

    // User is logged in
    return BlogScaffoldWidget(
      showBackButton: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display user profile picture if available
          Center(
            child: ProfileIconWidget(
              picUrl: user?.picUrl,
              iconSize: 60,
              containerSize: 60,
              // Optionally, pass the user's profile picture here
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              user!.getDisplayName(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          const SizedBox(height: 65),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'First Name: ${user?.firstname ?? 'Not Available'}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Last Name: ${user?.lastname ?? 'Not Available'}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Email: ${user?.email ?? 'Not Available'}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  // Logout button
                  ElevatedButton(
                    onPressed: () {
                      userProvider.logout(); // Logout using UserProvider
                      // Optionally, navigate to another screen if needed
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
