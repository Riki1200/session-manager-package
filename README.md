<!--
This README describes the package. If you publish this package to pub.dev, 
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

## Session Manager

The session_manager package provides a set of widgets and functionalities designed to manage user sessions in a Flutter application. It includes a SessionActivityManager widget that handles user inactivity time and calls the corresponding callback functions when the user session expires or there is user activity.

## Usage

To use session_manager, add the package as a dependency in your pubspec.yaml file:
<!-- Create code     -->
To use session_manager, add the package as a dependency in your pubspec.yaml file:

```yaml

dependencies:
  session_manager: ^0.0.1
```

In your Dart code, import the session_manager library:

```dart
   import 'package:session_manager/session_manager.dart';
```

Then, wrap your root widget with the SessionActivityManager widget and specify the required parameters:

```dart
   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return SessionActivityManager(
         onSessionExpired: () {
           // Handle session expiration
         },
         sessionTimeout: Duration(minutes: 5),
         onSessionActivity: () {
            // handle session activity
         },
         child: MaterialApp(
           title: 'My App',
           home: MyHomePage(),
         ),
       );
     }
   }
```

In this example, SessionActivityManager wraps a MaterialApp widget as the child, and the onSessionExpired callback function is specified to handle the expiration of the user session.

Versioning
The current version of session_manager is 0.0.1.

We use semantic versioning to manage package versions. In short, the version number is in the format of MAJOR. MINOR. PATCH, where:

MAJOR is incremented when there are breaking changes
MINOR is incremented when new features are added
PATCH is incremented when bugs are fixed or minor changes are made
For more information, please refer to the changelog for this package.
