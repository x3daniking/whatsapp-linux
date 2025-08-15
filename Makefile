.PHONY: build deb appimage rpm snap all clean install help

# Default target
build: deb

# Build DEB package (default for Pop!_OS/Ubuntu/Debian)
deb:
	@echo "Building DEB package for Pop!_OS/Ubuntu/Debian..."
	./build.sh deb

# Build AppImage (universal Linux package)
appimage:
	@echo "Building AppImage..."
	./build.sh appimage

# Build RPM package (Fedora/CentOS/RHEL)
rpm:
	@echo "Building RPM package..."
	./build.sh rpm

# Build Snap package
snap:
	@echo "Building Snap package..."
	./build.sh snap

# Build all packages
all:
	@echo "Building all packages..."
	./build.sh all

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf dist/
	rm -rf node_modules/.cache/
	npm run build

# Install the built DEB package locally
install: deb
	@echo "Installing WhatsApp Linux..."
	sudo dpkg -i dist/*.deb || sudo apt-get install -f

# Show help
help:
	@echo "WhatsApp Linux Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  build/deb    - Build DEB package (default, for Pop!_OS/Ubuntu/Debian)"
	@echo "  appimage     - Build AppImage (universal Linux package)"
	@echo "  rpm          - Build RPM package (Fedora/CentOS/RHEL)"
	@echo "  snap         - Build Snap package"
	@echo "  all          - Build all package types"
	@echo "  clean        - Clean build artifacts"
	@echo "  install      - Build and install DEB package locally"
	@echo "  help         - Show this help message"
	@echo ""
	@echo "Examples:"
	@echo "  make              # Build DEB package"
	@echo "  make deb          # Build DEB package"
	@echo "  make appimage     # Build AppImage"
	@echo "  make all          # Build all packages"
	@echo "  make install      # Build and install DEB package"
