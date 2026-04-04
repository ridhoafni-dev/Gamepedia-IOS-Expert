# Real-Time SwiftLint Setup Guide

This guide explains how to set up real-time SwiftLint checking in your development workflow.

## 🎯 Overview

There are three ways to get real-time SwiftLint feedback:

1. **Xcode Build Phase** - Runs on every build
2. **Git Pre-commit Hook** - Runs before commits
3. **File Watcher** - Monitors and lints files as you save them

---

## 1️⃣ Xcode Build Phase (Recommended for Development)

### Setup Instructions

1. **Open Xcode Project**
   ```bash
   open Gamepedia.xcodeproj
   ```

2. **Add Build Phase**
   - Select `Gamepedia` target
   - Go to `Build Phases` tab
   - Click `+` button → Select `New Run Script Phase`

3. **Configure the Script**
   - Name: "Run SwiftLint"
   - Add this script:
   ```bash
   "${PROJECT_DIR}/build-phase-swiftlint.sh"
   ```

4. **Drag to Desired Position**
   - Drag the new phase to position (typically after "Compile Sources")

### Result
- ✅ SwiftLint runs automatically on every build
- ✅ Violations appear in Xcode's Issue Navigator
- ✅ Warnings show in the editor
- ⚠️ Build completes even with warnings

### Example Output in Xcode
```
Gamepedia/Features/Main/View/HomeView.swift:42: warning: Line should be 120 characters or less; currently it has 156 characters
Gamepedia/Features/Main/View/HomeView.swift:75: warning: Function body should span 40 lines or less; currently it spans 82 lines
```

---

## 2️⃣ Git Pre-commit Hook (For Quality Gates)

### What It Does
- ✅ Checks staged files before committing
- ✅ Prevents committing code with style violations
- ✅ Provides helpful fix suggestions

### Automatic Setup
The hook is already installed at `.git/hooks/pre-commit`

### Manual Setup (if needed)
```bash
chmod +x .git/hooks/pre-commit
```

### Usage

**Attempt to commit with violations:**
```bash
git add Gamepedia/App/GamepediaApp.swift
git commit -m "Update HomeView"
```

**If violations exist, you'll see:**
```
🔍 Running SwiftLint pre-commit checks...

→ Checking: Gamepedia/App/GamepediaApp.swift
Gamepedia/App/GamepediaApp.swift:15: error: Line should be 120 characters or less

✗ SwiftLint checks failed!

To fix issues:
  1. Run: ./swiftlint.sh fix
  2. Review the changes
  3. Stage the fixes: git add <files>
  4. Try committing again
```

### Fix and Retry
```bash
# Auto-fix violations
./swiftlint.sh fix

# Stage the fixes
git add Gamepedia/App/GamepediaApp.swift

# Try committing again
git commit -m "Update HomeView"
```

### Skip Hook (Not Recommended)
```bash
git commit --no-verify  # Bypasses SwiftLint checks
```

---

## 3️⃣ File Watcher (Real-Time During Coding)

### Prerequisites
```bash
brew install fswatch  # File system watcher
brew install swiftlint
```

### Start Watching
```bash
./watch-swiftlint.sh
```

### What Happens
- 👀 Monitors all Swift files for changes
- 🔍 Runs SwiftLint automatically on save
- 📊 Shows results in real-time
- 🎨 Color-coded output (green/red)

### Example Output
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📝 File changed: HomeView.swift
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Gamepedia/Features/Main/View/HomeView.swift:42:warning: Line should be 120 characters or less

✗ SwiftLint issues found

To auto-fix: swiftlint lint --config .swiftlint.yml "..." --fix

⏱ Waiting for changes...
```

### Stop Watching
```
Press Ctrl+C
```

---

## 📊 Real-Time Checking Comparison

| Method | When It Runs | Pros | Cons |
|--------|-------------|------|------|
| **Xcode Build Phase** | Every build | Integrated with IDE | Only on build |
| **Pre-commit Hook** | Before commit | Prevents bad commits | Manual invocation |
| **File Watcher** | On file save | Instant feedback | Requires extra terminal |

---

## ⚙️ Configuration

### Customize Rules
Edit `.swiftlint.yml` to adjust rules and severity:

```yaml
line_length:
  warning: 120
  error: 150

disabled_rules:
  - missing_docs
  - file_header
```

Then run:
```bash
./swiftlint.sh  # See updated results
```

### Disable Hook Temporarily
```bash
# Move hook aside
mv .git/hooks/pre-commit .git/hooks/pre-commit.bak

# Re-enable later
mv .git/hooks/pre-commit.bak .git/hooks/pre-commit
```

### Ignore Specific Violations
In code:
```swift
// swiftlint:disable line_length
let veryLongLine = "This is intentionally a very long line that needs to be longer than 150 characters for some reason..."
// swiftlint:enable line_length
```

---

## 🔧 Common Issues & Solutions

### Issue: "SwiftLint not installed"
```bash
brew install swiftlint
brew upgrade swiftlint  # Update to latest
```

### Issue: Pre-commit hook not running
```bash
# Check if executable
ls -la .git/hooks/pre-commit

# Make executable if needed
chmod +x .git/hooks/pre-commit
```

### Issue: File watcher not starting
```bash
# Install fswatch
brew install fswatch

# Try again
./watch-swiftlint.sh
```

### Issue: Too many violations to fix
```bash
# See what would be fixed
swiftlint lint --config .swiftlint.yml --reporter xcode

# Auto-fix what's possible
./swiftlint.sh fix

# Manually review remaining issues
```

---

## 📈 Best Practices

### Daily Workflow

1. **Start file watcher (optional)**
   ```bash
   ./watch-swiftlint.sh
   ```

2. **Code normally**
   - Xcode will show warnings automatically
   - File watcher provides real-time feedback

3. **Before committing**
   ```bash
   ./swiftlint.sh fix  # Auto-fix issues
   git add .
   git commit -m "Your commit message"  # Pre-commit hook validates
   ```

4. **Review issues**
   - Check Xcode's Issue Navigator
   - Fix or disable violations with comments

### CI/CD Integration

The GitHub Actions workflow (`.github/workflows/swiftlint.yml`) runs:
- On every pull request
- On pushes to main/develop
- Uses realm/SwiftLint-action

---

## 🎯 Summary

| Scenario | Command |
|----------|---------|
| Want Xcode warnings? | Add build phase |
| Want pre-commit validation? | Hook is auto-installed |
| Want real-time watching? | `./watch-swiftlint.sh` |
| Want to fix issues? | `./swiftlint.sh fix` |
| Want strict CI checks? | GitHub Actions |

---

## 📚 Resources

- [SwiftLint Documentation](https://github.com/realm/SwiftLint)
- [Project Configuration](.swiftlint.yml)
- [Build Phase Script](build-phase-swiftlint.sh)
- [Git Hook](.git/hooks/pre-commit)
- [File Watcher](watch-swiftlint.sh)
