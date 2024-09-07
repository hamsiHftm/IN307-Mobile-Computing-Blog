import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/blog_provider.dart';
import '../provider/user_provider.dart';
import 'login_view.dart';

class BlogFormView extends StatefulWidget {
  const BlogFormView({Key? key}) : super(key: key);

  @override
  _BlogFormViewState createState() => _BlogFormViewState();
}

class _BlogFormViewState extends State<BlogFormView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _picUrlController;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _picUrlController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _picUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveBlog() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Get the BlogModel instance from the provider
        final blogModel = Provider.of<BlogModel>(context, listen: false);
        final user = Provider.of<UserProvider>(context, listen: false).user;

        // Call the addBlog method from BlogModel
        await blogModel.addBlog(
          title: _titleController.text,
          content: _contentController.text,
          picUrl: _picUrlController.text,
          user: user ?? User(id: 1, email: ''), // Use user from UserProvider
        );

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Blog saved successfully!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.green, // Green background for success
          ),
        );

        // Clear the form fields
        _titleController.clear();
        _contentController.clear();
        _picUrlController.clear();
      } catch (e) {
        // Handle error and show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Saving blog failed. Please try again.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.red, // Red background for error
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isLoggedIn = userProvider.isLoggedIn;

    if (!isLoggedIn) {
      // User is not logged in
      return Scaffold(
        appBar: AppBar(
          title: Text('Login Required'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
            child: Text('Login to Create Blog'),
          ),
        ),
      );
    }

    // User is logged in
    final colorScheme = Theme.of(context).colorScheme;
    final textColorSecondary = colorScheme.secondary;
    final textColorPrimary = Theme.of(context).primaryColor;

    final inputDecoration = InputDecoration(
      labelStyle: TextStyle(color: textColorSecondary),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: textColorSecondary),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: textColorSecondary),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                      'Create Blog',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 40.0,
                        color: textColorSecondary,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'Fill out the form below to create a new blog post.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: textColorSecondary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _titleController,
                            style: TextStyle(color: textColorSecondary),
                            decoration: inputDecoration.copyWith(
                              labelText: 'Title *',
                              suffixText: '*',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Title cannot be empty.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _contentController,
                            maxLines: null,
                            style: TextStyle(color: textColorSecondary),
                            decoration: inputDecoration.copyWith(
                              labelText: 'Content *',
                              suffixText: '*',
                              hintText: 'min. 10 characters',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Content cannot be empty.';
                              }
                              if (value.length < 10) {
                                return 'Content must be at least 10 characters.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _picUrlController,
                            style: TextStyle(color: textColorSecondary),
                            decoration: inputDecoration.copyWith(
                              labelText: 'Image URL',
                              hintText: 'Network image URL',
                            ),
                          ),
                          const SizedBox(height: 20),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                            onPressed: _saveBlog,
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}