# SwiftLint Setup Guide

This document explains the SwiftLint configuration for the Gamepedia iOS Expert project.

## What is SwiftLint?

SwiftLint is a tool that enforces Swift style and conventions. It helps maintain code quality, consistency, and readability across the project.

## Installation

### Install SwiftLint via Homebrew

```bash
brew install swiftlint
```

### Verify Installation

```bash
swiftlint version
```

## Configuration

The project includes a `.swiftlint.yml` file that defines all linting rules and their severity levels.

### Key Configuration Rules

#### Enabled Rules (opt_in_rules)
- **closure_spacing** - Enforce spacing inside closures
- **contains_over_filter_count** - Prefer `contains` over `filter(where:).count > 0`
- **explicit_init** - Enforce explicit `init` calls
- **implicit_return** - Enforce implicit returns in single-expression closures
- **modifier_order** - Enforce consistent modifier ordering
- **multiline_arguments** - Enforce multiline function arguments
- **reduce_into** - Prefer `reduce(into:)` over `reduce`
- **shorthand_optional_binding** - Enforce shorthand optional binding
- **sorted_imports** - Enforce sorted imports
- **trailing_closure** - Enforce trailing closure syntax

#### Disabled Rules
- `file_header` - No header comments required
- `missing_docs` - Documentation not required for all types
- `no_magic_numbers` - Magic numbers are allowed

### Rule Severity Levels

| Rule | Warning | Error |
|------|---------|-------|
| line_length | 120 chars | 150 chars |
| file_length | 400 lines | 600 lines |
| function_body_length | 40 lines | 80 lines |
| cyclomatic_complexity | 10 | 20 |
| function_parameter_count | 5 | 8 |
| nesting (type) | 2 levels | 3 levels |
| nesting (function) | 2 levels | 3 levels |

## Running SwiftLint

### Manual Lint Check

```bash
# Lint all files
swiftlint lint --config .swiftlint.yml

# Lint specific file
swiftlint lint Gamepedia/App/GamepediaApp.swift --config .swiftlint.yml

# Lint and show Xcode-compatible output
swiftlint lint --config .swiftlint.yml --reporter xcode
```

### Auto-fix Violations

```bash
# Auto-correct violations where possible
swiftlint lint --config .swiftlint.yml --fix

# With formatting
swiftlint lint --config .swiftlint.yml --fix --format
```

### Using the Shell Script

```bash
./swiftlint.sh
```

## Continuous Integration

SwiftLint automatically runs on:
- **Pull Requests** - Code must pass SwiftLint checks before merge
- **Push Events** - Every push triggers linting on GitHub Actions

### GitHub Actions Workflow

The project includes `.github/workflows/swiftlint.yml` that:
1. Triggers on pull requests and pushes to `main` and `develop` branches
2. Runs SwiftLint checks using `realm/SwiftLint-action@main`
3. Reports violations in the GitHub UI

## Xcode Integration

### Option 1: Add Build Phase (Recommended)

1. Open `Gamepedia.xcodeproj` in Xcode
2. Select `Gamepedia` target → `Build Phases`
3. Click `+` → `New Run Script Phase`
4. Add the script:

```bash
if which swiftlint > /dev/null; then
    swiftlint lint --config .swiftlint.yml --reporter xcode
else
    echo "warning: SwiftLint not installed"
fi
```

### Option 2: Xcode Extension

Install the SwiftLint Xcode extension from the Mac App Store for real-time linting feedback.

## Common Violations & Fixes

### Line Length

**Issue**: Line exceeds 120 characters (warning) or 150 characters (error)

**Fix**: Break long lines using:
```swift
// Before
let veryLongVariableName = someFunction(withParameter1: value1, withParameter2: value2, withParameter3: value3)

// After
let veryLongVariableName = someFunction(
    withParameter1: value1,
    withParameter2: value2,
    withParameter3: value3
)
```

### Function Parameter Count

**Issue**: Function has more than 5 parameters (warning) or 8 parameters (error)

**Fix**: Use a struct or value object:
```swift
// Before
func createUser(name: String, email: String, age: Int, city: String, country: String) {}

// After
struct UserData {
    let name: String
    let email: String
    let age: Int
    let city: String
    let country: String
}
func createUser(_ userData: UserData) {}
```

### Implicit Return

**Issue**: Closure doesn't use implicit return

**Fix**:
```swift
// Before
let doubled = numbers.map { n in
    return n * 2
}

// After
let doubled = numbers.map { n in
    n * 2
}
```

### Sorted Imports

**Issue**: Imports are not sorted alphabetically

**Fix**: Organize imports:
```swift
// Before
import UIKit
import Foundation
import Combine

// After
import Combine
import Foundation
import UIKit
```

## Best Practices

1. **Run SwiftLint before committing**
   ```bash
   swiftlint lint --config .swiftlint.yml --fix
   ```

2. **Review warnings carefully** - Not all can be auto-fixed

3. **Add exceptions only when necessary**
   - Use `// swiftlint:disable rule_name` for specific violations
   - Document why the exception is needed

4. **Keep rules consistent** - Don't disable rules arbitrarily

5. **Regular updates** - Check for new SwiftLint versions:
   ```bash
   brew upgrade swiftlint
   ```

## Customization

To modify rules, edit `.swiftlint.yml`:

```yaml
opt_in_rules:
  - new_rule_name

disabled_rules:
  - rule_to_disable

custom_rules: {}
```

Then run linting to verify changes:
```bash
swiftlint lint --config .swiftlint.yml
```

## Resources

- [SwiftLint GitHub Repository](https://github.com/realm/SwiftLint)
- [SwiftLint Rules Documentation](https://realm.io/docs/swift/latest/#swiftlint)
- [SwiftLint Configuration Guide](https://github.com/realm/SwiftLint/blob/main/README.md)

## Support

For questions about specific rules or configuration:
1. Check the `.swiftlint.yml` file in the project root
2. Review the [official documentation](https://realm.io/docs/swift/latest/#swiftlint)
3. Open an issue on the GitHub repository
