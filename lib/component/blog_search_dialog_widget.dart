import 'package:flutter/material.dart';

class BlogSearchDialog extends StatelessWidget {
  final Function(String) onSearch;

  const BlogSearchDialog({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return AlertDialog(
      title: Text(
        'Search Blog',
          style: Theme.of(context).textTheme.displaySmall,
      ),
      content: TextField(
        controller: _searchController,
        decoration: InputDecoration(hintText: 'Enter blog title'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onSearch(_searchController.text);
            Navigator.pop(context);
          },
          child: Text('Search'),
        ),
      ],
    );
  }
}