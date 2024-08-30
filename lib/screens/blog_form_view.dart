import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:in307_mobile_computing_blog/model/blog.dart';
import 'package:http/http.dart' as http;

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
  late TextEditingController _picUrlController;
  String? _picUrl; // To store the picture URL for preview
  bool _isFetchingPic = false;
  bool _isPicLoading = false;
  bool _picFetchedSuccessfully = true;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.blog?.title ?? '');
    _contentController = TextEditingController(text: widget.blog?.content ?? '');
    _picUrlController = TextEditingController(text: widget.blog?.picUrl ?? '');
    _picUrl = widget.blog?.picUrl;

    // Fetch image if URL is provided
    if (_picUrl != null && _picUrl!.isNotEmpty) {
      _fetchPic(_picUrl!);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _picUrlController.dispose();
    super.dispose();
  }

  Future<void> _fetchPic(String url) async {
    setState(() {
      _isFetchingPic = true;
      _isPicLoading = true;
      _picFetchedSuccessfully = false;
    });

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _picFetchedSuccessfully = true;
          _isPicLoading = false;
        });
      } else {
        setState(() {
          _picFetchedSuccessfully = false;
          _isPicLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _picFetchedSuccessfully = false;
        _isPicLoading = false;
      });
    } finally {
      setState(() {
        _isFetchingPic = false;
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      var editedBlog = Blog(
        id: widget.blog?.id ?? 0,
        title: _titleController.text,
        content: _contentController.text,
        createdAt: widget.blog?.createdAt ?? DateTime.now(),
        isFavorite: widget.blog?.isFavorite ?? false,
        picUrl: _picUrlController.text.isEmpty ? null : _picUrlController.text,
      );

      widget.onSave(newBlog: editedBlog, oldBlog: widget.blog);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlogScaffoldWidget(
      showBackButton: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Important: Allows Column to take only as much vertical space as needed
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
                TextFormField(
                  controller: _picUrlController,
                  decoration: InputDecoration(
                    labelText: 'Picture URL',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (url) {
                    setState(() {
                      _picUrl = url;
                      if (url.isNotEmpty) {
                        _fetchPic(url);
                      } else {
                        _picFetchedSuccessfully = false;
                        _isPicLoading = false;
                      }
                    });
                  },
                ),
                SizedBox(height: 20),
                if (_isFetchingPic) ...[
                  Center(child: CircularProgressIndicator()),
                ] else if (_picFetchedSuccessfully && _picUrl != null) ...[
                  Image.network(
                    _picUrl!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 100);
                    },
                  ),
                ] else ...[
                  Icon(Icons.image, size: 100), // Placeholder
                ],
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  child: Text(widget.blog == null ? 'Save' : 'Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}