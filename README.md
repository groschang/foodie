# Foodie

<p align="center">A food catalogue iOS application built with SwiftUI.</p>

<p align="center">
<img style="width: 250pxpx" src="Assets/screen5.png">
<img style="width: 250pxpx" src="Assets/screen.png">
</p>
<p align="center">
<img style="width: 250pxpx" src="Assets/screen1.png">
<img style="width: 250pxpx" src="Assets/screen4.png">
<img style="width: 250pxpx" src="Assets/screen2.png">
</p>

## About The Project

Foodie is an iOS app that allows users to browse a catalogue of meals. It's built with modern SwiftUI principles and showcases a clean, scalable architecture. The project has been successfully migrated to Swift 6, including the adoption of the new `#Preview` macro and the migration of tests to the new Testing API. This ensures the project is up-to-date with the latest Swift language features and best practices. This migration also brings improved concurrency safety, making the app more robust and reliable.

### Features

*   Browse meal categories
*   View meal details
*   Asynchronous image loading
*   Parallax scrolling effects
*   Widget extension for quick access

## Technical Stack & Architecture

*   **UI:** SwiftUI
*   **Architecture:** Clean Architecture with MVVM-like presentation layer
*   **Navigation:** Custom Router implementation
*   **Dependency Injection:** Custom dependency container
*   **Networking:** URLSession with async/await
*   **Persistence:** CoreData, Realm, and SwiftData explorations (as seen in `foodieTests/Persistence`)
*   **Testing:** XCTest for unit and UI tests, with extensive mocking
*   **Automation:** Fastlane for automating builds, tests, and screenshots
*   **Logging:** Custom local Swift Package for logging

## Getting Started

### Prerequisites

*   Xcode 14 or later
*   An Apple Developer account might be required for certain features

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/foodie.git
   ```
2. Navigate to the project directory:
   ```sh
   cd foodie
   ```
3. Install Ruby dependencies:
   ```sh
   bundle install
   ```
4. Open the project in Xcode:
   ```sh
   open foodie.xcodeproj
   ```

## Running Tests

You can run tests via Xcode's Test navigator or by using Fastlane:

```sh
fastlane tests
```

## API

This project uses the [TheMealDB API](https://www.themealdb.com/api.php) to fetch meal data.

## Project Structure

```
foodie/
├── foodie/                  # Main app target
│   ├── App/                 # App entry point and main components
│   ├── Commons/             # Shared utilities and extensions
│   ├── Extensions/          # SwiftUI extensions
│   ├── Models/              # Data models
│   ├── Networking/          # API clients and networking
│   ├── Styles/              # Custom styles and view modifiers
│   └── utils/               # Utility functions
├── foodieTests/             # Unit tests
├── foodieUITests/           # UI tests
├── widget/                  # Widget extension
├── Packages/                # Local Swift packages
├── Previews/                # Preview providers
├── fastlane/                # Automation scripts
└── Assets/                  # Images and media assets
```

## Development

### Architecture Overview

The project follows Clean Architecture principles with a MVVM-like presentation layer. The architecture is designed to align with SOLID principles, promoting a modular, maintainable, and testable codebase:

1. **View Layer**: SwiftUI views that observe ViewModels
2. **ViewModel Layer**: Business logic and state management
3. **Service Layer**: Data fetching and persistence
4. **Model Layer**: Data models and entities

### Dependency Injection

The project uses a custom dependency injection container that provides services and dependencies throughout the app lifecycle.

### Navigation

Navigation is handled through a custom Router implementation that works with SwiftUI's NavigationStack.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## TODO Checklist

### Features
- [ ] Vibrations
- [ ] iPad split screen
- [ ] Search bar

### Improvements
- [ ] Model enhancements
- [ ] Async view states
- [ ] Extract and clean text styles
- [ ] Use EmbedInStackModifier
- [ ] Localization
- [ ] Check styles
- [ ] Mocks + previews
- [ ] Services concurrency locks instead of ViewModels
- [ ] Extract mappers
- [ ] Rename protocol segregation naming
- [ ] Font improvements
- [ ] Mocked container target improvements
- [ ] DependencyContainerType & DI cleanup
- [ ] CoreData stubs
 
### Ideas
- [ ] DTO approach
- [ ] Service as Actor
- [ ] Dependency container library
- [ ] IdentifiableObject
- [ ] Create additional packages

### Fixes
- [ ] MotionManager handling and optimization (utilize core)
- [ ] Iterate over TODOs
- [ ] Remove routers / RouterProtocol
- [ ] Factories: remove doubled services
- [ ] Fix searchable

### Completed
- [x] Swift 6 migration
- [x] Migrate tests to Testing API
- [x] #Preview macro migration
- [x] Create new target for mocked container
- [x] Rename MealsServiceVMock into MealsAsyncService
- [x] Rename ViewBuilderProtocol into TheViewBuilder
- [x] Rename MealsClosureServiceTypeNew
- [x] Rename MealsServiceType
- [x] Rename MealsServiceAsync into MealsAsyncService
- [x] Rename MealsServiceVIType into MealsAsyncCombinedServiceType
- [x] Rename MealsServiceStream into MealsAsyncStreamService
- [x] Dependency container
- [x] Iterate over TODOs
- [x] Realm
- [x] Categories grid view
- [x] Navigation bar improvements
