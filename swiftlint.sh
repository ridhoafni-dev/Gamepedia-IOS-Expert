#!/bin/bash

# SwiftLint Run Script
# This script runs SwiftLint on the Gamepedia iOS Expert project
# Usage: ./swiftlint.sh [lint|fix|check]

set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="${PROJECT_DIR}/.swiftlint.yml"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if SwiftLint is installed
if ! which swiftlint > /dev/null; then
    print_error "SwiftLint not installed"
    echo ""
    echo "Install it with: brew install swiftlint"
    exit 1
fi

print_status "SwiftLint version: $(swiftlint version)"

# Determine action
ACTION="${1:-lint}"

case "$ACTION" in
    lint)
        echo ""
        print_status "Running SwiftLint (lint mode)..."
        echo ""
        swiftlint lint --config "$CONFIG_FILE" --reporter xcode
        print_status "Lint check completed"
        ;;
    
    fix)
        echo ""
        print_status "Running SwiftLint (fix mode)..."
        echo ""
        swiftlint lint --config "$CONFIG_FILE" --fix
        print_status "Auto-fixes applied"
        ;;
    
    check)
        echo ""
        print_status "Running SwiftLint (strict mode)..."
        echo ""
        if swiftlint lint --config "$CONFIG_FILE" --strict; then
            print_status "All checks passed!"
            exit 0
        else
            print_error "SwiftLint checks failed"
            exit 1
        fi
        ;;
    
    *)
        echo "Usage: $0 [lint|fix|check]"
        echo ""
        echo "Commands:"
        echo "  lint   - Run SwiftLint checks (default)"
        echo "  fix    - Auto-fix violations"
        echo "  check  - Run strict checks (CI/CD mode)"
        exit 1
        ;;
esac

exit 0
