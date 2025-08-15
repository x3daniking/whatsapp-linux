#!/bin/bash

# WhatsApp Linux Build Script
# Creates DEB, AppImage, and other packages for Linux distributions

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the project root directory."
    exit 1
fi

# Get project information
PROJECT_NAME=$(node -p "require('./package.json').name")
PROJECT_VERSION=$(node -p "require('./package.json').version")

print_status "Building $PROJECT_NAME v$PROJECT_VERSION"

# Clean previous builds
print_status "Cleaning previous builds..."
rm -rf dist/
rm -rf node_modules/.cache/

# Install dependencies if node_modules doesn't exist
if [ ! -d "node_modules" ]; then
    print_status "Installing dependencies..."
    npm install
fi

# Create assets if they don't exist
print_status "Setting up assets..."
if [ ! -f "assets/icon.png" ]; then
    print_warning "Icon file not found. Creating placeholder icon..."
    # Create a simple placeholder icon using ImageMagick (if available)
    if command -v convert &> /dev/null; then
        convert -size 512x512 xc:green -fill white -gravity center -pointsize 72 -annotate +0+0 "WA" assets/icon.png
        print_success "Created placeholder icon"
    else
        print_warning "ImageMagick not found. You may need to provide assets/icon.png manually"
    fi
fi

# Build TypeScript
print_status "Compiling TypeScript..."
npm run build

# Create post-install scripts for DEB
print_status "Creating post-install scripts..."

cat > build/deb-postinstall.sh << 'EOF'
#!/bin/bash
# Post-install script for WhatsApp Linux DEB package

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database /usr/share/applications
fi

# Update icon cache
if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor
fi

# Update MIME database
if command -v update-mime-database &> /dev/null; then
    update-mime-database /usr/share/mime
fi

echo "WhatsApp Linux has been installed successfully!"
echo "You can find it in your applications menu or run 'whatsapp-linux' from terminal."
EOF

cat > build/deb-postremove.sh << 'EOF'
#!/bin/bash
# Post-remove script for WhatsApp Linux DEB package

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database /usr/share/applications
fi

# Update icon cache
if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor
fi

echo "WhatsApp Linux has been removed."
EOF

chmod +x build/deb-postinstall.sh build/deb-postremove.sh

# Build packages
print_status "Building packages..."

# Build for different targets based on arguments
if [ "$1" = "deb" ] || [ "$1" = "" ]; then
    print_status "Building DEB package..."
    npx electron-builder --linux deb
    print_success "DEB package created successfully!"
fi

if [ "$1" = "appimage" ] || [ "$1" = "" ]; then
    print_status "Building AppImage..."
    npx electron-builder --linux AppImage
    print_success "AppImage created successfully!"
fi

if [ "$1" = "rpm" ]; then
    print_status "Building RPM package..."
    npx electron-builder --linux rpm
    print_success "RPM package created successfully!"
fi

if [ "$1" = "snap" ]; then
    print_status "Building Snap package..."
    npx electron-builder --linux snap
    print_success "Snap package created successfully!"
fi

if [ "$1" = "all" ]; then
    print_status "Building all Linux packages..."
    npx electron-builder --linux
    print_success "All packages created successfully!"
fi

# Show build results
print_success "Build completed!"
print_status "Output files:"
if [ -d "dist" ]; then
    ls -la dist/ | grep -E '\.(deb|AppImage|rpm|snap)$'
fi

# Installation instructions
print_status "Installation instructions:"
echo ""
echo "For Pop!_OS/Ubuntu/Debian (DEB package):"
echo "  sudo dpkg -i dist/*.deb"
echo "  sudo apt-get install -f  # Fix any dependency issues"
echo ""
echo "For AppImage (universal):"
echo "  chmod +x dist/*.AppImage"
echo "  ./dist/*.AppImage"
echo ""
echo "For Fedora/CentOS/RHEL (RPM package):"
echo "  sudo rpm -i dist/*.rpm"
echo ""

print_success "Build script completed successfully!"
