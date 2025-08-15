#!/bin/bash

# WhatsApp Linux Installation Script for Pop!_OS and Debian-based systems

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
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

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root. Use your regular user account."
    exit 1
fi

# Check if we're on a supported system
if ! command -v dpkg &> /dev/null; then
    print_error "This installer is for Debian-based systems (Pop!_OS, Ubuntu, Debian)"
    print_error "For other distributions, try the AppImage version."
    exit 1
fi

print_status "WhatsApp Linux Installer for Pop!_OS"

# Find the DEB package
DEB_FILE=$(find dist -name "*.deb" | head -1)

if [ -z "$DEB_FILE" ]; then
    print_error "No DEB package found in dist/ directory"
    print_error "Please build the package first with: ./build.sh deb"
    exit 1
fi

print_status "Found package: $DEB_FILE"

# Install the package
print_status "Installing WhatsApp Linux..."
sudo dpkg -i "$DEB_FILE"

# Fix any dependency issues
if [ $? -ne 0 ]; then
    print_warning "Fixing dependency issues..."
    sudo apt-get update
    sudo apt-get install -f -y
fi

# Verify installation
if command -v whatsapp-linux &> /dev/null || [ -f "/opt/WhatsApp Linux/whatsapp-linux" ]; then
    print_success "WhatsApp Linux installed successfully!"
    print_status "You can now:"
    echo "  1. Find 'WhatsApp Linux' in your applications menu"
    echo "  2. Or run from terminal: whatsapp-linux"
    echo ""
    print_status "To uninstall: sudo apt remove whatsapp-linux"
else
    print_error "Installation may have failed. Please check the output above."
    exit 1
fi
