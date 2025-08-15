#!/bin/bash

# WhatsApp Linux AppImage Launcher Script

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Find the AppImage file
APPIMAGE=$(find "$SCRIPT_DIR/dist" -name "*.AppImage" | head -1)

if [ -z "$APPIMAGE" ]; then
    echo "Error: No AppImage found in dist/ directory"
    echo "Please build the AppImage first with: ./build.sh appimage"
    exit 1
fi

echo "Launching WhatsApp Linux AppImage..."
echo "File: $(basename "$APPIMAGE")"

# Make sure it's executable
chmod +x "$APPIMAGE"

# Launch the AppImage
exec "$APPIMAGE" "$@"
