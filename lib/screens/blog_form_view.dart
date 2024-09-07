import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';

import '../model/blog.dart';

class BlogFormView extends StatefulWidget {
  final Blog? blog;

  const BlogFormView({Key? key, this.blog}) : super(key: key);

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
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _contentController = TextEditingController(text: widget.blog?.content ?? '');
    _picUrlController = TextEditingController(text: widget.blog?.picUrl ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _picUrlController.dispose();
    super.dispose();
  }

  void _showImagePreview() {
    final url = _picUrlController.text;
    if (url.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Image Preview'),
          content: Image.network(
            url,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _saveBlog() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      // Assume you have a method to save the blog; replace with your actual implementation
      bool success = true; // Replace with actual save method

      if (success) {
        Navigator.of(context).pop(true); // Pass true if save is successful
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Saving blog failed. Please try again.',
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
      body: Padding(
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
                        'Create/Edit Blog',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 40.0,
                          color: textColorSecondary,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Fill out the form below to create or edit a blog post.',
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
                              decoration: InputDecoration(
                                labelText: 'Title',
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
                                  return 'Title cannot be empty.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _contentController,
                              maxLines: null, // Unlimited lines
                              decoration: InputDecoration(
                                labelText: 'Content',
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
                                  return 'Content cannot be empty.';
                                }
                                if (value.length > 10) {
                                  return 'Content cannot exceed 10 characters.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _picUrlController,
                              decoration: InputDecoration(
                                labelText: 'Image URL',
                                labelStyle: TextStyle(color: textColorSecondary),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: textColorSecondary),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: textColorSecondary),
                                ),
                                suffixIcon: _picUrlController.text.isNotEmpty
                                    ? IconButton(
                                  icon: const Icon(Icons.preview),
                                  onPressed: _showImagePreview,
                                )
                                    : null,
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
      ),
    );
  }
}