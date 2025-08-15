#!/bin/bash

# Release helper script for WhatsApp Linux
# Usage: ./release.sh [version]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if version is provided
if [ -z "$1" ]; then
    print_error "Version not provided"
    echo "Usage: $0 <version>"
    echo "Example: $0 1.2.0"
    exit 1
fi

VERSION="$1"
TAG="v$VERSION"

# Validate version format (semantic versioning)
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    print_error "Invalid version format. Use semantic versioning (e.g., 1.2.0)"
    exit 1
fi

print_info "Preparing release for version $VERSION"

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "Not in a git repository"
    exit 1
fi

# Check if working directory is clean
if ! git diff --quiet HEAD; then
    print_error "Working directory is not clean. Please commit your changes first."
    exit 1
fi

# Check if we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    print_warning "You're not on the main branch (current: $CURRENT_BRANCH)"
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Release cancelled"
        exit 0
    fi
fi

# Update package.json version
print_info "Updating package.json version to $VERSION"
npm version "$VERSION" --no-git-tag-version

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    print_info "Installing dependencies..."
    npm install
fi

# Build the application
print_info "Building application..."
npm run build

# Test build
print_info "Testing build..."
if ! npm run dist > /dev/null 2>&1; then
    print_error "Build test failed"
    exit 1
fi

print_success "Build test passed"

# Create changelog entry (if CHANGELOG.md exists)
if [ -f "CHANGELOG.md" ]; then
    print_info "Please update CHANGELOG.md with the new version changes"
    read -p "Press Enter when you've updated the changelog..."
fi

# Commit version bump
print_info "Committing version bump..."
git add package.json package-lock.json
if [ -f "CHANGELOG.md" ]; then
    git add CHANGELOG.md
fi
git commit -m "chore: bump version to $VERSION"

# Create and push tag
print_info "Creating tag $TAG..."
git tag -a "$TAG" -m "Release $VERSION"

print_info "Pushing changes and tag..."
git push origin "$CURRENT_BRANCH"
git push origin "$TAG"

print_success "Tag $TAG created and pushed successfully!"
print_info "GitHub Actions will automatically create the release and build packages."
print_info "Monitor the progress at: https://github.com/x3daniking/whatsapp-linux/actions"

# Open release page (if on a desktop environment)
if command -v xdg-open > /dev/null 2>&1; then
    print_info "Opening release page in browser..."
    xdg-open "https://github.com/x3daniking/whatsapp-linux/releases/tag/$TAG" 2>/dev/null || true
fi

print_success "Release process completed!"
echo
echo "Next steps:"
echo "1. Monitor the GitHub Actions workflow"
echo "2. Review and edit the auto-generated release notes"
echo "3. Test the published packages"
echo "4. Announce the release to the community"
