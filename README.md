<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.


cheetah-core/
├── .gitignore
├── LICENSE
├── README.md
├── CHANGELOG.md
├── analysis_options.yaml
├── pubspec.yaml
├── tool/
│   └── build.dart          // Build scripts, code generation utilities, etc.
├── lib/
│   ├── cheetah_core.dart   // Exports the public API of cheetah-core.
│   ├── annotations/
│   │   ├── component.dart      // Annotation for marking components.
│   │   ├── controller.dart     // Annotation for REST controllers.
│   │   ├── repository.dart     // Annotation for data repositories.
│   │   ├── service.dart        // Annotation for service classes.
│   │   └── injectable.dart     // General-purpose injectable annotation.
│   ├── config/
│   │   ├── configuration.dart  // Core configuration classes.
│   │   └── auto_config.dart    // Auto-configuration engine.
│   ├── di/
│   │   ├── container.dart      // The DI container implementation.
│   │   ├── injector.dart       // Injection utilities and helpers.
│   │   └── providers.dart      // Provider definitions for DI.
│   ├── core/
│   │   ├── error.dart          // Custom exception and error handling.
│   │   ├── logging.dart        // Logging setup and utilities.
│   │   ├── utils.dart          // Common helper functions.
│   │   └── events.dart         // Event bus and publish/subscribe support.
│   └── modules/
│       ├── web.dart            // Web server integration, routing, and middleware.
│       ├── security.dart       // Security framework (authentication, authorization).
│       ├── data.dart           // Data access abstractions, ORM integration.
│       └── messaging.dart      // Messaging and event-driven communication.
├── test/
│   ├── annotations_test.dart   // Tests for annotation processing.
│   ├── di_container_test.dart  // Tests for dependency injection functionality.
│   ├── config_test.dart        // Tests for configuration and auto-config.
│   ├── core_utils_test.dart    // Tests for logging, error handling, etc.
│   └── modules_test.dart       // Tests for individual modules (web, security, etc.).
└── example/
    ├── main.dart              // A sample application using cheetah-core.
    └── config.yaml            // Example configuration file for the sample app.
