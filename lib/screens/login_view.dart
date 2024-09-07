import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _isLogin = true; // This will toggle between login and signup

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    // Validate login form
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Email and password cannot be empty.',
          style: TextStyle(color: Colors.red),
        ),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = await Provider.of<UserProvider>(context, listen: false).login(
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      Navigator.of(context).pop(true); // Pass true if login is successful
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Login failed. Please try again.',
          style: TextStyle(color: Colors.red),
        ),
      ));
    }
  }

  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();

    // Validate sign-up form
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _repeatPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'All fields are required.',
          style: TextStyle(color: Colors.red),
        ),
      ));
      return;
    }

    if (_passwordController.text != _repeatPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Passwords do not match. Please try again.',
          style: TextStyle(color: Colors.red),
        ),
      ));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = await Provider.of<UserProvider>(context, listen: false).signUp(
      _firstNameController.text,
      _lastNameController.text,
      _emailController.text,
      _passwordController.text,
    );

    if (success) {
      Navigator.of(context).pop(true); // Pass true if sign-up is successful
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Sign-up failed. Please try again.',
          style: TextStyle(color: Colors.red),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlogScaffoldWidget(
      showBackButton: true,
      resizeToAvoidBottomInset: true, // Ensure this is set if using a custom scaffold
      body: Padding(
        padding: const EdgeInsets.all(45.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLogin) ...[
                  // Login Form
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = false; // Switch to sign-up view
                      });
                    },
                    child: Text('Don\'t have an account? Sign up',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  ),
                ] else ...[
                  // Sign-up Form
                  TextField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _repeatPasswordController,
                    decoration: const InputDecoration(labelText: 'Repeat Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _signUp,
                    child: const Text('Sign Up'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = true; // Switch back to login view
                      });
                    },
                    child: Text('Already have an account? Login',
                        style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}