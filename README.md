# IN307 - Mobile Computing / Blog App

The frontend for the Blog Project is an Android application developed using Flutter and Dart. This application provides a mobile interface for users to interact with the blog platform, allowing them to view, create, and manage blog posts, comments, likes, and ratings.

## Project Structure

The Flutter project follows a well-organized structure to ensure maintainability and clarity. Here is a breakdown of the key directories and files:

```
.
├── api
│   └── blog_api.dart              // API service definitions for interacting with the backend
├── component
│   ├── blog_card.dart             // UI component for displaying a single blog post
│   └── blog_list.dart             // UI component for displaying a list of blog posts
├── main.dart                      // Entry point of the application
├── model
│   ├── blog.dart                  // Data model for blog posts
│   └── user.dart                  // Data model for users
├── provider
│   └── blog_provider.dart         // Provider for managing blog-related state and business logic
├── screens
│   ├── blog_detail_view.dart      // Screen for viewing the details of a single blog post
│   └── blog_form_view.dart        // Screen for creating or editing a blog post
├── services
│   └── blog_repository.dart       // Repository for fetching and managing blog data
└── utils
    └── app_logger.dart            // Utility class for logging messages throughout the application
```

### Directory Descriptions

- **`api`**: Contains files responsible for API interactions. `blog_api.dart` defines the endpoints and methods for communication with the backend server.

- **`component`**: Contains reusable UI components. `blog_card.dart` and `blog_list.dart` are used for displaying blog posts in various formats.

- **`main.dart`**: The main entry point of the application. This file initializes the app and sets up global configurations.

- **`model`**: Contains data models that represent the core entities of the application. `blog.dart` and `user.dart` define the structure of blog posts and user profiles, respectively.

- **`provider`**: Manages the state of the application. `blog_provider.dart` handles the state and business logic related to blog posts.

- **`screens`**: Contains the various screens or views of the application. `blog_detail_view.dart` and `blog_form_view.dart` are used to display detailed views of a blog post and forms for creating or editing posts.

- **`services`**: Manages data fetching and business logic. `blog_repository.dart` interacts with `blog_api.dart` to fetch and manipulate data.

- **`utils` **: Contains utility classes and functions used throughout the application. `app_logger.dart` is a utility class for centralized logging.

## Getting Started

### Prerequisites

- Ensure you have [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
- Ensure you have [Android Studio](https://developer.android.com/studio) or another IDE configured for Flutter development.

### Setup

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/hamsiHftm/IN307-Mobile-Computing-Blog.git
    cd IN307-Mobile-Computing-Blog
    ```

2. **Install Dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the Application**:
    ```sh
    flutter run
    ```

   The application will launch on the connected device or emulator.

## Flavours and Environments

TODO

To support different environments (e.g., development, staging, production), we use Flutter flavours. Configure your `flutter` build flavors in `android/app/build.gradle` and use environment-specific configurations as needed.

### Configuring Flavours

1. **Define Flavours** in `build.gradle`:
    ```gradle
    android {
        ...
        flavorDimensions "env"
        productFlavors {
            dev {
                dimension "env"
                applicationIdSuffix ".dev"
                versionNameSuffix "-dev"
            }
            prod {
                dimension "env"
            }
        }
    }
    ```

2. **Create Environment Files**:
    - `lib/config/environment.dart` for environment-specific configurations.
