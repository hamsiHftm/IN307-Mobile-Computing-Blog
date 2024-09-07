import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:in307_mobile_computing_blog/component/comment_list_widget.dart';
import 'package:in307_mobile_computing_blog/component/loading_widget.dart';
import 'package:in307_mobile_computing_blog/component/blog_error_widget.dart';
import '../api/blog_api.dart';
import '../component/profile_icon_widget.dart';
import '../model/blog.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogDetailView extends StatefulWidget {
  final int blogId;

  const BlogDetailView({super.key, required this.blogId});

  @override
  _BlogDetailViewState createState() => _BlogDetailViewState();
}

class _BlogDetailViewState extends State<BlogDetailView> {
  late Future<Blog?> _futureBlog;
  String _errorMessage = 'An error occurred';

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
    return BlogScaffoldWidget(
      showBackButton: true,
      body: FutureBuilder<Blog?>(
        future: _futureBlog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(withScaffold: false);
          } else if (snapshot.hasError || snapshot.data == null) {
            return BlogErrorWidget(
              message: _errorMessage,
              onRetry: () {
                setState(() {
                  _futureBlog = _fetchBlogDetails();
                });
              },
              withScaffold: true,
            );
          } else {
            final blog = snapshot.data!;
            return Container(
              color: Theme.of(context).colorScheme.tertiary,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Profile
                    Row(
                      children: [
                        ProfileIconWidget(
                          picUrl: blog.user?.picUrl,
                          iconSize: 50.0,
                          containerSize: 40.0,
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog.user!.getDisplayName(),
                              style: Theme.of(context).textTheme.headlineMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(timeago.format(blog.createdAt)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // Blog Heading
                    Text(
                      blog.title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 16.0),
                    // Blog Image
                    blog.picUrl != null && blog.picUrl!.isNotEmpty
                        ? Image.network(
                      blog.picUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: Theme.of(context).colorScheme.surface,
                          child: Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 250,
                            ),
                          ),
                        );
                      },
                    )
                        : Container(
                      height: 250,
                      color: Theme.of(context).colorScheme.surface,
                      child: Center(
                        child: Icon(
                          Icons.image,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 150,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Blog Tags
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                          },
                          icon: const Icon(
                             Icons.favorite,
                             color: Colors.white,
                          ),
                          label: Text('${blog.numberOfLikes} likes'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.comment),
                          label: Text('${blog.comments?.length ?? 0} comments'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // Blog Content
                    Text(
                      blog.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      "Comments",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    // Comment List
                    blog.comments != null && blog.comments!.isNotEmpty
                        ? CommentListWidget(comments: blog.comments!)
                        : Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/no_comment.png',
                            width: 250,
                            height: 250,
                          ),
                          const Text('Be the first to comment')
                        ],
                      ),
                    ),
                    const SizedBox(height: 70.0),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}