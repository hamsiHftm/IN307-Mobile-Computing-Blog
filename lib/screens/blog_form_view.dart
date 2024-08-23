import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';

class BlogFormView extends StatefulWidget {
  final Function({required Blog newBlog, Blog? oldBlog}) onSave;
  final Blog? blog;

  BlogFormView({Key? key, required this.onSave, this.blog}) : super(key: key);

  @override
  State<BlogFormView> createState() => _BlogFormViewState();
}

class _BlogFormViewState extends State<BlogFormView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    // Initialize controllers based on whether blog is null or not
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _contentController = TextEditingController(text: widget.blog?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      var editedBlog = Blog(
        id: widget.blog?.id ?? 0,
        title: _titleController.text,
        content: _contentController.text,
        createdAt: widget.blog?.createdAt ?? DateTime.now(), // Use existing date or current date
        isFavorite: widget.blog?.isFavorite ?? false, // Use existing favorite status or false
      );

      widget.onSave(newBlog: editedBlog, oldBlog: widget.blog); // Call onSave with edited or new blog
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog == null ? 'Add Blog Entry' : 'Edit Blog Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 10) {
                    return 'Please enter some content. The length should be minimum 10 characters.';
                  }
                  return null;
                },
                maxLines: null, // Allow multiple lines for content
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(widget.blog == null ? 'Save' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
