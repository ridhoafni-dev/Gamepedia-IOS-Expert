# Gamepedia-IOS-Expert

[![Codemagic build status](https://api.codemagic.io/apps/69cf9432c67af7fcb8ff114c/69cfd0db38bc9009f1cb6921/ios-project-debug/status_badge.svg)](https://codemagic.io/apps/69cf9432c67af7fcb8ff114c/ios-project-debug/latest_build)

Gamepedia is a modern iOS application built with SwiftUI that provides comprehensive game information, ratings, and discovery features. The project demonstrates clean architecture principles, modular design, and strict code quality standards enforced through SwiftLint.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [SwiftLint Configuration](#swiftlint-configuration)
- [Setup & Installation](#setup--installation)
- [Building & Running](#building--running)
- [Code Quality](#code-quality)
- [Project Structure](#project-structure)

## Features

- 🎮 Browse and discover games by rating, genre, and developer
- ⭐ Rate games and manage favorites
- 🔍 Advanced search functionality
- 📱 Native SwiftUI interface
- 🏗️ Modular architecture with Swift Package Manager
- ✅ 100% SwiftLint compliant codebase

## Architecture

The project follows a clean, modular architecture with:

- **MVVM Pattern**: Model-View-ViewModel for UI logic separation
- **Repository Pattern**: Abstraction layer for data access
- **Dependency Injection**: Centralized injection container
- **Modular SPM Packages**: Separate modules for Games, Genres, Developers, Favorite, and Search

### Modules

- **Core**: Shared utilities, networking, and base classes
- **Games**: Game browsing and detail functionality
- **Genres**: Genre browsing and filtering
- **Developers**: Developer information and details
- **Favorite**: Favorite games management
- **SearchGame**: Game search functionality

## SwiftLint Configuration

Gamepedia uses SwiftLint to maintain consistent code quality and style across the entire project. The configuration is strictly enforced with a `warning_threshold` of 1, meaning any warning will fail the build.

### Installation

SwiftLint is required for development. Install it using Homebrew:

```bash
brew install swiftlint
```

### Configuration File

The project includes a comprehensive `.swiftlint.yml` configuration file with:

- **23 disabled rules**: Rules that are not applicable to this project
- **49 opt-in rules**: Stricter rules that are explicitly enabled
- **Analyzer rules**: Static analysis rules for deeper code inspection

### Running SwiftLint

To lint all Swift files in the project:

```bash
swiftlint lint
```

To lint with a specific configuration:

```bash
swiftlint lint --config .swiftlint.yml
```

To automatically fix violations:

```bash
swiftlint --fix
```

### Build Phase Integration

SwiftLint is integrated into the Xcode build phase via `build-phase-swiftlint.sh` script:

```bash
#!/bin/bash
if which swiftlint > /dev/null; then
    swiftlint lint --config "${PROJECT_DIR}/.swiftlint.yml" --reporter xcode
fi
```

This ensures SwiftLint runs automatically on every build, preventing violations from being committed.

### Key Rules Enforced

#### Access Control
- `lower_acl_than_parent`: Ensures declarations have lower access control than their parent
- `strict_fileprivate`: Encourages use of `private` over `fileprivate`

#### Type Safety
- `force_cast`: Discourages unsafe force casts (`as!`)
- `force_try`: Discourages unsafe force tries (`try!`)
- `force_unwrapping`: Discourages force unwrapping (`!`)
- `implicitly_unwrapped_optional`: Avoids implicit optionals

#### Code Quality
- `implicit_return`: Functions should use implicit returns for single expressions
- `redundant_nil_coalescing`: Removes unnecessary nil coalescing
- `redundant_type_annotation`: Removes redundant type annotations
- `multiline_function_chains`: Ensures proper formatting of chained functions

#### Naming
- `type_name`: Type names must be 4-50 characters long
- `identifier_name`: Identifiers must be at least 3 characters (except common vars: x, y, id, url)

#### Formatting
- `opening_brace`: Opening braces must be on the same line as declarations
- `colon`: Proper spacing around colons
- `line_length`: Lines should not exceed 180 characters
- `indentation_width`: Uses 4-space indentation

#### Performance
- `empty_count`: Uses `.isEmpty` instead of `.count == 0`
- `empty_string`: Uses `isEmpty` for string checks
- `reduce_boolean`: Uses simpler boolean operations

### Fixing Violations

When SwiftLint reports violations, use the automatic fixer:

```bash
swiftlint --fix --format
```

For violations that can't be automatically fixed, address them manually following the SwiftLint documentation.

## Setup & Installation

### Requirements

- Xcode 14.0 or later
- iOS 16.0 or later
- Swift 5.7 or later
- SwiftLint 0.63.2 or later

### Clone & Setup

```bash
# Clone the repository
git clone [repository-url]
cd Gamepedia-IOS-Expert

# Install SwiftLint
brew install swiftlint

# Open in Xcode
open Gamepedia.xcodeproj
```

## Building & Running

### Build

```bash
# Via Xcode
Command + B

# Via command line
xcodebuild -project Gamepedia.xcodeproj -scheme Gamepedia -configuration Debug build
```

### Run

```bash
# Via Xcode
Command + R

# Via command line
xcodebuild -project Gamepedia.xcodeproj -scheme Gamepedia -configuration Debug run
```

## Code Quality

### Standards

- **100% SwiftLint Compliance**: All files must pass SwiftLint checks
- **No Force Casts**: Use optional binding instead of force casting
- **Implicit Returns**: Use implicit returns in single-expression functions
- **Proper Access Control**: Use the lowest access control level appropriate
- **Clear Naming**: Use descriptive names following Swift conventions

### Pre-commit Checks

Before committing code:

1. Run SwiftLint: `swiftlint lint`
2. Fix violations: `swiftlint --fix`
3. Review changes manually
4. Run unit tests
5. Commit changes

### Continuous Integration

The project uses Codemagic for CI/CD. Every build automatically:

1. Installs dependencies
2. Runs SwiftLint
3. Builds the project
4. Runs tests
5. Archives the application

## Project Structure

```
Gamepedia-IOS-Expert/
├── Gamepedia/                          # Main app
│   ├── App/                            # App entry point
│   ├── Core/                           # Shared utilities
│   └── Features/                       # Feature modules
├── Modules/                            # SPM modules
│   ├── Core/                           # Core framework
│   ├── Games/                          # Games module
│   ├── Genres/                         # Genres module
│   ├── Developers/                     # Developers module
│   ├── Favorite/                       # Favorite module
│   └── SearchGame/                     # Search module
├── swiftlint.yml                       # SwiftLint configuration
├── build-phase-swiftlint.sh            # Build phase script
├── codemagic.yaml                      # CI/CD configuration
└── README.md                           # This file
```

## Contributing

When contributing to this project:

1. Ensure all code passes SwiftLint checks
2. Follow the established architecture patterns
3. Write unit tests for new features
4. Keep functions focused and single-responsibility
5. Use descriptive names and add documentation comments

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues, questions, or suggestions, please open an issue in the repository.

---

**Last Updated**: April 2026
**SwiftLint Version**: 0.63.2
**Swift Version**: 5.7+

