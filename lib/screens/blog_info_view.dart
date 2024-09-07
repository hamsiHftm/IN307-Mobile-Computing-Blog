import 'package:flutter/material.dart';
import 'package:in307_mobile_computing_blog/component/blog_error_widget.dart';
import 'package:in307_mobile_computing_blog/component/blog_scaffold_widget.dart';
import 'package:in307_mobile_computing_blog/component/comment_list_widget.dart';
import 'package:in307_mobile_computing_blog/component/loading_widget.dart';
import '../api/blog_api.dart';
import '../model/blog.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogInfoView extends StatefulWidget {
  final int blogId;

  const BlogInfoView({super.key, required this.blogId});

  @override
  _BlogInfoViewState createState() => _BlogInfoViewState();
}

class _BlogInfoViewState extends State<BlogInfoView> {
  late Future<Blog?> _futureBlog;
  String? _errorMessage;
  ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _futureBlog = _fetchBlogDetails();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double offset = _scrollController.offset;
    double maxOffset = 150.0; // Adjust this value based on your needs

    setState(() {
      _appBarOpacity = (offset / maxOffset).clamp(0.0, 1.0);
    });
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
      body: FutureBuilder<Blog?>(
        future: _futureBlog,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget(withScaffold: true);
          } else if (snapshot.hasError || snapshot.data == null) {
            return BlogErrorWidget(
              message: _errorMessage ?? 'An error occurred',
              onRetry: () {},
              withScaffold: true,
            );
          } else {
            final blog = snapshot.data!;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  expandedHeight: 350.0,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      final top = constraints.biggest.height;
                      final titleVisible = top < 110.0;

                      return FlexibleSpaceBar(
                        titlePadding: EdgeInsetsDirectional.only(
                          start: 56.0,
                          bottom: 16.0,
                          end: 56.0,
                        ),
                        title: AnimatedOpacity(
                          opacity: titleVisible ? 1.0 : 0.0,
                          duration: Duration(milliseconds: 300),
                          child: Text(
                            blog.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Background image
                            blog.picUrl != null && blog.picUrl!.isNotEmpty
                                ? Image.network(
                                    blog.picUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                      Icons.broken_image,
                                      size: MediaQuery.of(context).size.width *
                                          0.5,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Center(
                                    child: Icon(
                                      Icons.image_sharp,
                                      size: MediaQuery.of(context).size.width *
                                          0.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                            // Gradient overlay
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(_appBarOpacity),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                            // Background color and opacity for the title visibility
                            Container(
                              color: Colors.black
                                  .withOpacity(_appBarOpacity * 0.6),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: IconButton(
                        icon: Icon(Icons.edit_sharp),
                        onPressed: () {
                          // Edit action
                        },
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.onPrimaryContainer,
                          Theme.of(context).colorScheme.onSecondaryContainer,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 12.0,
                              backgroundImage: NetworkImage(
                                blog.user?.picUrl ??
                                    'https://cdn.dribbble.com/users/1630853/screenshots/8575298/travel_blog_2x_4x.jpg',
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              blog.user?.firstname ?? 'Anonymous',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Icon(
                              Icons.access_time,
                              color: Colors.black,
                              size: 16.0,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              timeago.format(blog.createdAt),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          blog.content,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 16.0),
                        blog.comments != null && blog.comments!.isNotEmpty
                            ? CommentListWidget(comments: blog.comments!)
                            : Center(
                                child: Text('No comments yet.'),
                              ),
                      ],
                    ),
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
