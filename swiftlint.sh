#!/bin/bash
set -e
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="${PROJECT_DIR}/.swiftlint.yml"
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if ! which swiftlint > /dev/null; then
    echo -e "${RED}✗ SwiftLint not installed${NC}"
    exit 1
fi

ACTION="${1:-lint}"
case "$ACTION" in
    lint)
        echo -e "${GREEN}✓ Running SwiftLint (lint mode)...${NC}"
        swiftlint lint --config "$CONFIG_FILE" --reporter xcode
        ;;
    fix)
        echo -e "${GREEN}✓ Running SwiftLint (fix mode)...${NC}"
        swiftlint lint --config "$CONFIG_FILE" --fix
        echo -e "${GREEN}✓ Auto-fixes applied${NC}"
        ;;
    check)
        echo -e "${GREEN}✓ Running SwiftLint (strict mode)...${NC}"
        if swiftlint lint --config "$CONFIG_FILE" --strict; then
            echo -e "${GREEN}✓ All checks passed!${NC}"
            exit 0
        else
            echo -e "${RED}✗ SwiftLint checks failed${NC}"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 [lint|fix|check]"
        exit 1
        ;;
esac
