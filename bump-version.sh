#!/bin/bash

# Version bump script for WhatsApp Linux
# Usage: ./bump-version.sh [major|minor|patch]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_usage() {
    echo "Usage: $0 [major|minor|patch]"
    echo ""
    echo "Examples:"
    echo "  $0 patch   # 1.0.0 -> 1.0.1"
    echo "  $0 minor   # 1.0.0 -> 1.1.0" 
    echo "  $0 major   # 1.0.0 -> 2.0.0"
    exit 1
}

if [ $# -eq 0 ]; then
    print_usage
fi

BUMP_TYPE="$1"

if [[ ! "$BUMP_TYPE" =~ ^(major|minor|patch)$ ]]; then
    echo -e "${RED}Error: Invalid bump type. Use major, minor, or patch.${NC}"
    print_usage
fi

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo -e "${RED}Error: package.json not found. Run this script from the project root.${NC}"
    exit 1
fi

# Get current version
CURRENT_VERSION=$(node -p "require('./package.json').version")
echo -e "${BLUE}Current version: ${CURRENT_VERSION}${NC}"

# Bump version using npm
echo -e "${BLUE}Bumping ${BUMP_TYPE} version...${NC}"
NEW_VERSION=$(npm version "$BUMP_TYPE" --no-git-tag-version | sed 's/^v//')

echo -e "${GREEN}New version: ${NEW_VERSION}${NC}"

# Update documentation files
echo -e "${BLUE}Updating documentation...${NC}"

# Update version in docs/index.html
if [ -f "docs/index.html" ]; then
    sed -i "s/WhatsApp-Linux-[0-9]\+\.[0-9]\+\.[0-9]\+-/WhatsApp-Linux-${NEW_VERSION}-/g" docs/index.html
    echo "Updated docs/index.html"
fi

# Update version in README.md
if [ -f "README.md" ]; then
    sed -i "s/WhatsApp-Linux-[0-9]\+\.[0-9]\+\.[0-9]\+-/WhatsApp-Linux-${NEW_VERSION}-/g" README.md
    echo "Updated README.md"
fi

# Update CHANGELOG.md
if [ -f "CHANGELOG.md" ]; then
    # Create a backup
    cp CHANGELOG.md CHANGELOG.md.bak
    
    # Add new version entry
    TODAY=$(date +%Y-%m-%d)
    TEMP_FILE=$(mktemp)
    
    # Insert new version after [Unreleased]
    awk -v version="$NEW_VERSION" -v date="$TODAY" '
    /^## \[Unreleased\]/ {
        print $0
        print ""
        print "### Added"
        print "- Version " version " release"
        print ""
        print "## [" version "] - " date
        next
    }
    { print }
    ' CHANGELOG.md > "$TEMP_FILE"
    
    # Update the links at the bottom
    sed -i "s|\[Unreleased\]: .*|\[Unreleased\]: https://github.com/x3daniking/whatsapp-linux/compare/v${NEW_VERSION}...HEAD\n[${NEW_VERSION}]: https://github.com/x3daniking/whatsapp-linux/releases/tag/v${NEW_VERSION}|" "$TEMP_FILE"
    
    mv "$TEMP_FILE" CHANGELOG.md
    rm -f CHANGELOG.md.bak
    echo "Updated CHANGELOG.md"
fi

echo -e "${GREEN}Version bump completed!${NC}"
echo ""
echo "Next steps:"
echo "1. Review the changes:"
echo "   git diff"
echo ""
echo "2. Commit the changes:"
echo "   git add ."
echo "   git commit -m \"chore: bump version to ${NEW_VERSION}\""
echo ""
echo "3. Create and push the release tag:"
echo "   git tag v${NEW_VERSION}"
echo "   git push origin main"
echo "   git push origin v${NEW_VERSION}"
echo ""
echo "4. Or use the release script:"
echo "   ./release.sh ${NEW_VERSION}"
