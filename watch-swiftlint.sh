#!/bin/bash
# SwiftLint File Watcher
# Monitors Swift files and runs SwiftLint on changes
# Requires: brew install fswatch
# Usage: ./watch-swiftlint.sh

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="${PROJECT_DIR}/.swiftlint.yml"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}📦 SwiftLint File Watcher${NC}"
echo ""

# Check if fswatch is installed
if ! which fswatch > /dev/null; then
    echo -e "${RED}✗ fswatch not installed${NC}"
    echo ""
    echo "Install it with:"
    echo "  brew install fswatch"
    exit 1
fi

# Check if SwiftLint is installed
if ! which swiftlint > /dev/null; then
    echo -e "${RED}✗ SwiftLint not installed${NC}"
    echo ""
    echo "Install it with:"
    echo "  brew install swiftlint"
    exit 1
fi

echo -e "${GREEN}✓ SwiftLint version:${NC} $(swiftlint version)"
echo -e "${GREEN}✓ fswatch version:${NC} $(fswatch --version | head -1)"
echo ""
echo -e "${YELLOW}⏱ Watching for Swift file changes...${NC}"
echo "Press Ctrl+C to stop"
echo ""

# Watch for changes to Swift files
fswatch -r \
    -x \
    --exclude='Pods' \
    --exclude='.swiftpm' \
    --exclude='Build' \
    --exclude='DerivedData' \
    --exclude='.git' \
    --event Created \
    --event Updated \
    "${PROJECT_DIR}/Gamepedia" \
    "${PROJECT_DIR}/Modules" | \
while read FILE_PATH
do
    # Only process Swift files
    if [[ "$FILE_PATH" == *.swift ]]; then
        clear
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}📝 File changed:${NC} $(basename "$FILE_PATH")"
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        
        # Run SwiftLint on the changed file
        if swiftlint lint --config "$CONFIG_FILE" "$FILE_PATH"; then
            echo ""
            echo -e "${GREEN}✓ No issues found!${NC}"
        else
            echo ""
            echo -e "${RED}✗ SwiftLint issues found${NC}"
            echo ""
            echo "To auto-fix: swiftlint lint --config $CONFIG_FILE \"$FILE_PATH\" --fix"
        fi
        echo ""
        echo -e "${YELLOW}⏱ Waiting for changes...${NC}"
    fi
done
