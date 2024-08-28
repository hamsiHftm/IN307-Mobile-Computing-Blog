import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/blog.dart';
import '../provider/blog_provider.dart';
import '../api/blog_api.dart';
import 'blog_form_view.dart';

class BlogDetailView extends StatefulWidget {
  final int blogId;

  const BlogDetailView({super.key, required this.blogId});

  @override
  _BlogDetailViewState createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  late Future<Blog?> _futureBlog;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _futureBlog = _fetchBlogDetails();
  }

  Future<Blog?> _fetchBlogDetails() async {
    try {
      final blog = await BlogApi.instance.getBlogById(widget.blogId);
      return blog;
    } catch (e) {
      setState(() {
        _errorMessage = 'Something went wrong. Please try again later.';
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Blog?>(
        future: _futureBlog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text(
                _errorMessage ?? 'An error occurred.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else {
            final blog = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * 0.4, // Adjust height as needed
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      blog.title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    background: blog.picUrl != null
                        ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          blog.picUrl!,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    )
                        : Container(color: Colors.grey), // Placeholder if no image
                    titlePadding: EdgeInsets.all(16.0),
                    collapseMode: CollapseMode.parallax,
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5), // Background color for the circle
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent, // Transparent to show the background image
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Swapped placement: Title now comes after the Created Date
                            Text(
                              DateFormat.yMMMMd().format(blog.createdAt),
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              blog.title,
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 16),
                            Text(
                              blog.content,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogFormView(
                                      blog: blog,
                                      onSave: ({required Blog newBlog, Blog? oldBlog}) {
                                        final blogModel = Provider.of<BlogModel>(context, listen: false);
                                        int index = blogModel.getIndexOfBlog(oldBlog!);
                                        blogModel.editBlog(index, newBlog);
                                      },
                                    ),
                                  ),
                                );
                              },
                              child: Text('Edit'),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Comments',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      // Display comments
                      for (var comment in blog.comments ?? [])
                        ListTile(
                          title: Text(comment.content),
                          subtitle: Text(
                            '${comment.user?.firstname ?? 'Anonymous'} ${comment.user?.lastname ?? ''} - ${DateFormat.yMMMd().format(comment.createdAt)}',
                          ),
                          trailing: Text('${comment.numberOfLikes} Likes'),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}