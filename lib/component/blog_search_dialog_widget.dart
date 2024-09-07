import 'package:flutter/material.dart';

class BlogSearchDialog extends StatefulWidget {
  // Callback function to be called with the search query
  final Function(String) onSearch;

  // Constructor to initialize the dialog with a callback function for search action
  const BlogSearchDialog({super.key, required this.onSearch});

  @override
  _BlogSearchDialogState createState() => _BlogSearchDialogState();
}

class _BlogSearchDialogState extends State<BlogSearchDialog> {
  // Controller for the search input field
  final TextEditingController searchController = TextEditingController();

  // Flag to determine if the search button should be active
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();
    // Add listener to update button state based on text input
    searchController.addListener(_checkIfTextIsEntered);
  }

  // Method to check if the input text is not empty
  void _checkIfTextIsEntered() {
    setState(() {
      isButtonActive = searchController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Remove listener and dispose of the controller when the widget is removed
    searchController.removeListener(_checkIfTextIsEntered);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // Title of the dialog
      title: Text(
        'Search Blog',
        style: Theme.of(context).textTheme.displaySmall,
      ),
      content: TextField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: 'Enter blog title',
          // Styling for hint text
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          // Styling for the enabled border
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 2.0,
            ),
          ),
          // Styling for the focused border
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 2.0,
            ),
          ),
        ),
        // Styling for the input text
        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
      ),
      actions: [
        // Cancel button to close the dialog
        TextButton(
          onPressed: () {
            Navigator.pop(
                context); // Closes the dialog without performing any action
          },
          child: const Text('Cancel'),
        ),
        // Search button to perform the search action
        ElevatedButton(
          onPressed: isButtonActive
              ? () {
            // Trigger search action and close the dialog if the button is active
            widget.onSearch(searchController.text);
            Navigator.pop(context);
          }
              : null, // Disable the button when the input is empty
          child: const Text('Search'),
        ),
      ],
    );
  }
}