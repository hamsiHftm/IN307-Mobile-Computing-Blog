# Blog-IN307

## Overview

This is a Flutter-based blog application that integrates with a local backend. It provides features such as viewing blogs, adding new posts, and managing user profiles.

## Features

- View and manage blogs
- Add new blog posts
- User authentication and profile management
- Search functionality

## Project Structure

The project is organized into several directories and files, each serving a specific purpose:

```
.
├── api
│   ├── blog_api.dart              # Contains API endpoints related to blogs
│   └── user_api.dart              # Contains API endpoints related to users
├── component
│   ├── blog_app_bar_widget.dart   # Widget for the blog app bar
│   ├── blog_card_widget.dart      # Widget for displaying a blog card
│   ├── blog_error_widget.dart     # Widget for displaying error messages
│   ├── blog_list.dart             # Widget for listing blogs
│   ├── blog_scaffold_widget.dart  # Scaffold widget for blog-related screens
│   ├── blog_search_dialog_widget.dart # Dialog widget for searching blogs
│   ├── comment_card_widget.dart   # Widget for displaying a comment card
│   ├── comment_list_widget.dart   # Widget for listing comments
│   ├── loading_widget.dart        # Widget for showing loading indicators
│   └── profile_icon_widget.dart   # Widget for displaying user profile icon
├── main.dart                      # Entry point of the Flutter application
├── model
│   ├── blog.dart                  # Blog model class
│   ├── comment.dart               # Comment model class
│   └── user.dart                  # User model class
├── provider
│   ├── blog_provider.dart         # Provider for managing blog data
│   └── user_provider.dart         # Provider for managing user data
├── screens
│   ├── blog_detail_view.dart      # Screen for viewing blog details
│   ├── blog_form_view.dart        # Screen for adding/editing a blog post
│   ├── blog_info_view.dart        # Screen for blog information
│   ├── blog_list_view.dart        # Screen for listing blogs
│   ├── login_view.dart            # Screen for user login
│   └── profile_view.dart          # Screen for user profile
└── utils
    └── app_logger.dart            # Utility for logging application events
```

### PROJECT STRUCTURE

- **`api`**: This folder contains files that handle communication with the backend server. It includes the code for making API requests and processing responses related to blogs and user data.

- **`component`**: This folder holds reusable widgets and UI elements used throughout the app. These components are designed to be used in multiple places to maintain a consistent look and feel.

- **`main.dart`**: The main entry point of the application. It sets up the app's configuration, including the theme, providers, and initial routes.

- **`model`**: This folder contains classes that define the data structures used in the app, such as blogs, comments, and user information.

- **`provider`**: This folder includes classes that manage the app's state and business logic. Providers connect the user interface with the data and handle operations like fetching and updating data.

- **`screens`**: Contains the main screens or pages of the app. Each screen represents a different part of the user interface, such as the blog list, blog details, or user profile.

- **`utils`**: Holds utility functions or classes that provide general support across the app, like logging and debugging tools.


## Prerequisites

1. **Flutter SDK**: Ensure that you have the Flutter SDK installed on your system. Follow the [Flutter installation guide](https://flutter.dev/docs/get-started/install) if you haven't set it up yet.
2. **Dart SDK**: The Dart SDK is included with Flutter, so installing Flutter will also install Dart.
3. **Local Backend**: This application connects to a local backend service. The backend repository can be found [here](https://github.com/hamsiHftm/IN306-Blog-Project.git) on the branch `in307-flutter-project`.

## Setup and Installation

### 1. Clone the Backend Repository

First, clone the backend repository:

```bash
git clone -b in307-flutter-project https://github.com/hamsiHftm/IN306-Blog-Project.git
```

### 2. Set Up the Backend

Navigate to the cloned backend repository and follow the backend's setup instructions to run it locally. Typically, this involves:

```bash
cd IN306-Blog-Project
# Follow backend setup instructions, e.g., installing dependencies and running the server
```

### 3. Configure the API Endpoints

Make sure the API endpoints in the Flutter project are correctly set to connect to your local backend. Open the files `lib/api/blog_api.dart` and `lib/api/user_api.dart` and check the `_baseUrl` configuration:

```dart
// lib/api/blog_api.dart
static const String _baseUrl = "http://10.0.2.2:8080"; // Ensure this URL is correct

// lib/api/user_api.dart
static const String _baseUrl = "http://10.0.2.2:8080"; // Ensure this URL is correct
```

### 4. Run the Flutter Application

1. **Install Dependencies**: Navigate to your Flutter project directory and install dependencies:

    ```bash
    flutter pub get
    ```

2. **Run the App**: Start the application using:

    ```bash
    flutter run
    ```

   Ensure that the emulator or connected device is running and properly configured. The application should launch and connect to the local backend.

## Troubleshooting

- **Local Backend Issues**: If the app cannot connect to the local backend, verify that the backend is running and accessible. Ensure that the URL `http://10.0.2.2:8080` matches the backend's URL and port.
- **Network Configuration**: For physical devices, replace `10.0.2.2` with the IP address of your machine where the backend is running.
- **Emulator Configuration**: `10.0.2.2` is used for Android emulators to access localhost. If using a different setup, adjust the `_baseUrl` accordingly.


## User Experience Focus

Throughout the development of this app, my primary focus was on enhancing user experience. Here’s how I’ve incorporated that:

- **Smooth Navigation**: The app features smooth transitions and intuitive navigation. For example, in the blog list view, pagination buttons are enabled and disabled based on the available pages. This ensures users can navigate seamlessly between pages. The search functionality is also designed to be responsive, showing empty result messages with illustrations if no results are found and providing relevant blog posts when a search term yields results.

- **Error Handling and Feedback**: Clear error handling and feedback mechanisms are integrated throughout the app. For instance, when the backend service is down, the app shows error messages with illustrations to inform users. During loading states, animations from the Lottie library are used to keep users engaged while data is being fetched.

- **Validation and Guidance**: The app includes robust validation for forms. For example, when signing up or logging in, users receive immediate feedback on errors such as invalid email addresses or mismatched passwords. This helps users correct mistakes quickly. Similarly, when creating a new blog, the app ensures that the title and content are provided and that the content length exceeds ten characters before submission. Hint text and required field indicators are used to guide users through filling out forms correctly.

- **Detailed Blog Views**: Blog posts are presented with comprehensive details. For example, each blog detail view includes the blog title, content, image, number of likes, and a list of comments. If there are no comments, an image placeholder is shown. This approach offers a rich and engaging experience, making it easy for users to interact with and appreciate the content.

- **Consistent Design**: A consistent theme and design elements are used throughout the app. The design includes clear visual and interactive elements, such as consistent button styles and theme colors. This attention to detail enhances overall usability and provides a cohesive and pleasant user experience.


## FEEDBACK AND MY FOCUS - UX

- **Time Constraints**: I had limited time and spent a lot of it working on authentication issues with the backend. Despite this, I focused on making the user experience (UX) as good as possible.
- **Attention to Detail**: I chose to focus on UX, so I paid close attention to every detail. Here’s what I added:
   - **Error Handling**: Created a widget to show error messages clearly.
   - **Loading Indicators**: Added an animated loading widget to improve the experience while waiting for data.
   - **Illustrations**: Used illustrations to show helpful messages when there are no blogs or when search results are empty.
   - **Form Validation**: Included checks for login, signup, and blog submission forms to ensure they are filled out correctly.

