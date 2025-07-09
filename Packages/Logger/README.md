# Logger

A simple, yet powerful logging utility for Swift applications, designed for flexible and configurable output.

## Features

-   **Multiple Log Levels:** Supports `verbose`, `debug`, `info`, `warning`, and `error` levels for granular control over log output.
-   **Console Output:** Prints logs directly to the Xcode console or terminal.
-   **File Output:** Optionally writes logs to a specified file for persistent storage and analysis.
-   **Conditional Logging:** Easily enable or disable logging based on build configurations (e.g., `DEBUG`).
-   **Thread-Safe:** Designed to be safe for use across multiple threads and concurrent operations.
-   **Print Database Path:** Utility to print the default database path for debugging purposes.

## Installation

The `Logger` package can be added to your project using Swift Package Manager.

1.  In Xcode, go to `File > Add Packages...`
2.  Enter the repository URL or select local package location.
3.  Select the `Logger` product.

## Usage

Import the `Logger` module into your Swift files:

```swift
import Logger
```

### Basic Logging

Use the static `Log` methods to output messages at different levels:

```swift
Log.verbose("This is a verbose message.")
Log.debug("Debugging information here.")
Log.info("Something important happened.")
Log.warning("This is a warning, pay attention!")
Log.error("An error occurred: \(error.localizedDescription)")
```

### Printing Database Path

To get the default database path (useful for Core Data, Realm, etc.):

```swift
Log.printDBPath()
```

### Conditional Logging (Example)

The logger can be configured to only output messages based on preprocessor macros. For example, to only log `debug` messages in `DEBUG` builds:

```swift
// In your Logger configuration (e.g., in an AppDelegate or initial setup)
// This is just an example, actual implementation might vary based on your setup.
#if DEBUG
Log.minimumLogLevel = .debug
#else
Log.minimumLogLevel = .info // Only show info, warning, error in release
#endif
```

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request.
