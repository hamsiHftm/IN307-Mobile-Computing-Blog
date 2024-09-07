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
  bool _isLogin = true; // Toggle between login and signup

  final RegExp _emailRegex = RegExp(
    r'^[^@]+@[^@]+\.[^@]+$',
    caseSensitive: false,
  );

  Future<void> _submitLogin() async {
    if (_loginFormKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      final success = await Provider.of<UserProvider>(context, listen: false).login(
        _emailController.text,
        _passwordController.text,
      );

      if (success) {
        Navigator.of(context).pop(true); // Pass true if login is successful
      } else {
        _showSnackBar('Login failed. Please try again.');
      }

      setState(() => _isLoading = false);
    }
  }

  Future<void> _submitSignUp() async {
    if (_signUpFormKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);

      final success = await Provider.of<UserProvider>(context, listen: false).signUp(
        firstname: _firstNameController.text,
        lastname: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (success) {
        Navigator.of(context).pop(true); // Pass true if sign-up is successful
      } else {
        _showSnackBar('Sign-up failed. Please try again.');
      }

      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required bool isPassword,
    String? suffixText,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      decoration: InputDecoration(
        labelText: labelText,
        suffixText: suffixText,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        errorStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlogScaffoldWidget(
      showBackButton: true,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Center(
              child: Card(
                elevation: 0,
                color: Colors.white,
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
                      Text(
                        _isLogin ? 'Login' : 'Sign Up',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 40.0,
                          color: colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        _isLogin
                            ? 'Please enter your email and password to log in.'
                            : 'Create a new account by filling out the form below.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Form(
                        key: _isLogin ? _loginFormKey : _signUpFormKey,
                        child: Column(
                          children: [
                            if (!_isLogin) ...[
                              _buildTextField(
                                controller: _firstNameController,
                                labelText: 'First Name',
                                isPassword: false,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: _lastNameController,
                                labelText: 'Last Name',
                                isPassword: false,
                              ),
                              const SizedBox(height: 20),
                            ],
                            _buildTextField(
                              controller: _emailController,
                              labelText: 'Email',
                              isPassword: false,
                              suffixText: '*',
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
                            _buildTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              isPassword: true,
                              suffixText: '*',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password cannot be empty.';
                                }
                                return null;
                              },
                            ),
                            if (!_isLogin) ...[
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: _repeatPasswordController,
                                labelText: 'Repeat Password',
                                isPassword: true,
                                suffixText: '*',
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
                            ],
                            const SizedBox(height: 20),
                            _isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                              onPressed: _isLogin ? _submitLogin : _submitSignUp,
                              child: Text(_isLogin ? 'Login' : 'Sign Up'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Don\'t have an account? Sign up'
                                    : 'Already have an account? Login',
                                style: TextStyle(color: colorScheme.secondary),
                              ),
                            ),
                          ],
                        ),
                      ),
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