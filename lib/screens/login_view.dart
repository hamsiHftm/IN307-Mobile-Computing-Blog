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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isLogin = true; // This will toggle between login and signup

  // Regular expression for validating email
  final RegExp _emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$',
    caseSensitive: false,
    multiLine: false,
  );

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (_loginFormKey.currentState?.validate() ?? false) {
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Login failed. Please try again.',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
          ),
        ));
      }
    }
  }

  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();

    if (_signUpFormKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      bool success = await Provider.of<UserProvider>(context, listen: false).signUp(
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (success) {
        Navigator.of(context).pop(true); // Pass true if sign-up is successful
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Sign-up failed. Please try again.',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textColorSecondary = colorScheme.secondary;
    final textColorPrimary = Theme.of(context).primaryColor;

    return BlogScaffoldWidget(
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Center(
              child: Card(
                elevation: 0,
                color: Colors.white, // Set background color to white
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: colorScheme.onSurface, width: 1),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      if (_isLogin) ...[
                        // Login Form
                        Text(
                          'Login',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 40.0,
                            color: textColorSecondary,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Please enter your email and password to log in.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: textColorSecondary,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: _loginFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                style: TextStyle(color: textColorSecondary), // Set input text color
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  suffixText: '*',
                                  labelStyle: TextStyle(color: textColorSecondary),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  errorStyle: TextStyle(color: textColorPrimary),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email cannot be empty.';
                                  }
                                  if (!_emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                style: TextStyle(color: textColorSecondary), // Set input text color
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixText: '*',
                                  labelStyle: TextStyle(color: textColorSecondary),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  errorStyle: TextStyle(color: textColorPrimary),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password cannot be empty.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
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
                                child: Text(
                                  'Don\'t have an account? Sign up',
                                  style: TextStyle(color: textColorSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        // Sign-up Form
                        Text(
                          'Sign Up',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 40.0,
                            color: textColorSecondary,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Create a new account by filling out the form below.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textColorSecondary,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: _signUpFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _firstNameController,
                                style: TextStyle(color: textColorSecondary), // Set input text color
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  labelStyle: TextStyle(color: textColorSecondary),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                ),
                                // First name is not required
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _lastNameController,
                                style: TextStyle(color: textColorSecondary), // Set input text color
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  labelStyle: TextStyle(color: textColorSecondary),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                ),
                                // Last name is not required
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _emailController,
                                style: TextStyle(color: textColorSecondary), // Set input text color
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  suffixText: '*',
                                  labelStyle: TextStyle(color: textColorSecondary),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  errorStyle: TextStyle(color: textColorPrimary),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email cannot be empty.';
                                  }
                                  if (!_emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email address.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _passwordController,
                                style: TextStyle(color: textColorSecondary), // Set input text color
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  suffixText: '*',
                                  labelStyle: TextStyle(color: textColorSecondary),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  errorStyle: TextStyle(color: textColorPrimary),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password cannot be empty.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                controller: _repeatPasswordController,
                                style: TextStyle(color: textColorSecondary), // Set input text color
                                decoration: InputDecoration(
                                  labelText: 'Repeat Password',
                                  suffixText: '*',
                                  labelStyle: TextStyle(color: textColorSecondary),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: textColorSecondary),
                                  ),
                                  errorStyle: TextStyle(color: textColorPrimary),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please repeat your password.';
                                  }
                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
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
                                child: Text(
                                  'Already have an account? Login',
                                  style: TextStyle(color: textColorSecondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}