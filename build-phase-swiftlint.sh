#!/bin/bash
# SwiftLint Xcode Build Phase Script
# Add this as a "Run Script" build phase in Xcode
# This runs SwiftLint automatically on every build

if which swiftlint > /dev/null; then
    echo "Running SwiftLint..."
    swiftlint lint --config "${PROJECT_DIR}/.swiftlint.yml" --reporter xcode
    
    # Return exit code for Xcode
    if [ $? -ne 0 ]; then
        echo "warning: SwiftLint found style issues"
    fi
else
    echo "warning: SwiftLint not installed. Install with: brew install swiftlint"
fi
