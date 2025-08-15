# WhatsApp Linux Makefile
# Build automation for multi-platform packages

.PHONY: help install clean build deb appimage rpm snap all release dev test deps-check version setup info install-local uninstall-local

# Default target
help:
	@echo "WhatsApp Linux Build System"
	@echo ""
	@echo "Available targets:"
	@echo "  help      - Show this help message"
	@echo "  install   - Install dependencies"
	@echo "  clean     - Clean build artifacts"
	@echo "  build     - Build TypeScript source"
	@echo "  dev       - Run in development mode"
	@echo "  test      - Run tests"
	@echo ""
	@echo "Package targets:"
	@echo "  deb       - Build DEB package"
	@echo "  appimage  - Build AppImage package"
	@echo "  rpm       - Build RPM package"
	@echo "  snap      - Build Snap package"
	@echo "  all       - Build all packages"
	@echo ""
	@echo "Release targets:"
	@echo "  release   - Create a new release (interactive)"
	@echo ""
	@echo "Utility targets:"
	@echo "  deps-check    - Check development dependencies"
	@echo "  version       - Show version information"
	@echo "  setup         - Quick setup for development"
	@echo "  info          - Show package information"
	@echo "  install-local - Build and install DEB locally"
	@echo "  uninstall-local - Uninstall local installation"
	@echo ""
	@echo "Example usage:"
	@echo "  make install    # Install dependencies"
	@echo "  make build      # Build the application"
	@echo "  make deb        # Build DEB package"
	@echo "  make all        # Build all packages"

# Install dependencies
install:
	@echo "Installing Node.js dependencies..."
	npm install
	@echo "Installing build dependencies..."
	sudo apt-get update
	sudo apt-get install -y libnss3-dev libatk-bridge2.0-dev libdrm2-dev libxcomposite-dev libxdamage-dev libxrandr-dev libgbm-dev libxss-dev libasound2-dev

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -rf dist/
	rm -rf node_modules/.cache/
	npm run build 2>/dev/null || true

# Build TypeScript source
build:
	@echo "Building TypeScript source..."
	npm run build

# Development mode
dev: build
	@echo "Starting in development mode..."
	npm run dev

# Run tests
test:
	@echo "Running tests..."
	npm test

# Build DEB package
deb: build
	@echo "Building DEB package..."
	chmod +x build.sh
	./build.sh deb

# Build AppImage package
appimage: build
	@echo "Building AppImage package..."
	chmod +x build.sh
	./build.sh appimage

# Build RPM package
rpm: build
	@echo "Building RPM package..."
	chmod +x build.sh
	./build.sh rpm

# Build Snap package
snap: build
	@echo "Building Snap package..."
	chmod +x build.sh
	./build.sh snap

# Build all packages
all: build
	@echo "Building all packages..."
	chmod +x build.sh
	./build.sh all

# Create a new release
release:
	@echo "Creating new release..."
	@echo "Usage: make release VERSION=1.2.0"
	@if [ -z "$(VERSION)" ]; then \
		echo "Error: VERSION is required"; \
		echo "Example: make release VERSION=1.2.0"; \
		exit 1; \
	fi
	chmod +x release.sh
	./release.sh $(VERSION)

# Install locally (DEB only)
install-local: deb
	@echo "Installing DEB package locally..."
	sudo dpkg -i dist/*.deb || true
	sudo apt-get install -f

# Uninstall locally
uninstall-local:
	@echo "Uninstalling WhatsApp Linux..."
	sudo apt remove whatsapp-linux || true

# Development dependencies check
deps-check:
	@echo "Checking development dependencies..."
	@which node >/dev/null || (echo "Node.js not found" && exit 1)
	@which npm >/dev/null || (echo "npm not found" && exit 1)
	@which git >/dev/null || (echo "git not found" && exit 1)
	@dpkg -l | grep -q libnss3-dev || (echo "libnss3-dev not installed" && exit 1)
	@echo "All dependencies are satisfied"

# Show version information
version:
	@echo "WhatsApp Linux Build Information"
	@echo "Package version: $(shell node -p "require('./package.json').version")"
	@echo "Node.js version: $(shell node --version)"
	@echo "npm version: $(shell npm --version)"
	@echo "Electron version: $(shell npm list electron --depth=0 2>/dev/null | grep electron || echo 'Not installed')"

# Quick setup for new development environment
setup: deps-check install build
	@echo "Development environment setup complete!"
	@echo "Run 'make dev' to start development mode"

# Package information
info:
	@echo "WhatsApp Linux Package Information"
	@echo "=================================="
	@echo "Project: $(shell node -p "require('./package.json').name")"
	@echo "Version: $(shell node -p "require('./package.json').version")"
	@echo "Description: $(shell node -p "require('./package.json').description")"
	@echo "License: $(shell node -p "require('./package.json').license")"
	@echo "Homepage: $(shell node -p "require('./package.json').homepage")"
	@echo ""
	@echo "Supported Packages:"
	@echo "  - DEB (Ubuntu, Pop!_OS, Debian)"
	@echo "  - AppImage (Universal Linux)"
	@echo "  - RPM (Fedora, CentOS, RHEL)"
	@echo "  - Snap (Ubuntu, Various)"

# Default target for backward compatibility
default: deb
