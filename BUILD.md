# WhatsApp Linux - Build Instructions

This document explains how to build WhatsApp Linux for various Linux distributions, including Pop!\_OS.

## Prerequisites

Before building, ensure you have the following installed:

```bash
# For Ubuntu/Pop!_OS/Debian
sudo apt update
sudo apt install nodejs npm git build-essential

# Additional dependencies for building
sudo apt install libnss3-dev libatk-bridge2.0-dev libdrm2-dev libxcomposite-dev libxdamage-dev libxrandr-dev libgbm-dev libxss-dev libasound2-dev
```

## Quick Build (DEB for Pop!\_OS)

To quickly build a DEB package for Pop!\_OS:

```bash
# Using the build script
./build.sh deb

# Or using make
make deb

# Or using npm
npm run build:deb
```

## Build Options

### 1. DEB Package (Pop!\_OS, Ubuntu, Debian)

```bash
./build.sh deb
# or
make deb
```

### 2. AppImage (Universal Linux)

```bash
./build.sh appimage
# or
make appimage
```

### 3. RPM Package (Fedora, CentOS, RHEL)

```bash
./build.sh rpm
# or
make rpm
```

### 4. Snap Package

```bash
./build.sh snap
# or
make snap
```

### 5. All Packages

```bash
./build.sh all
# or
make all
```

## Installation

### Pop!\_OS/Ubuntu/Debian (DEB)

```bash
# Install the built package
sudo dpkg -i dist/*.deb

# Fix any dependency issues
sudo apt-get install -f

# Or build and install in one step
make install
```

### AppImage

```bash
# Make executable and run
chmod +x dist/*.AppImage
./dist/*.AppImage

# Or move to applications
sudo mv dist/*.AppImage /opt/whatsapp-linux.AppImage
sudo ln -s /opt/whatsapp-linux.AppImage /usr/local/bin/whatsapp-linux
```

## Package Dependencies

The DEB package automatically handles these dependencies:

-   `libgtk-3-0` - GTK3 runtime
-   `libnotify4` - Desktop notifications
-   `libnss3` - Network Security Services
-   `libxss1` - X11 Screen Saver extension
-   `libxtst6` - X11 Testing extension
-   `xdg-utils` - Desktop integration utilities
-   `libatspi2.0-0` - Assistive Technology SPI
-   `libuuid1` - UUID library
-   `libappindicator3-1` - Application indicators
-   `libsecret-1-0` - Secret storage

## Development

### Setup

```bash
# Clone and setup
git clone <repository-url>
cd whatsapp-linux
npm install

# Development build
npm run dev

# Production build
npm run build
```

### File Structure

```
whatsapp-linux/
├── src/
│   └── main.ts          # Main Electron process
├── assets/
│   └── icon.png         # Application icon
├── build/
│   ├── deb-postinstall.sh
│   └── deb-postremove.sh
├── dist/                # Built packages output
├── build.sh             # Build script
├── Makefile             # Make targets
├── package.json         # Project configuration
└── tsconfig.json        # TypeScript configuration
```

## Troubleshooting

### Build Issues

1. **Missing dependencies**: Run `npm install`
2. **Permission errors**: Ensure `build.sh` is executable: `chmod +x build.sh`
3. **Icon missing**: The build script creates a placeholder if needed

### Runtime Issues

1. **Won't start**: Check dependencies with `ldd dist/whatsapp-linux`
2. **No icon**: Install `hicolor-icon-theme`
3. **Not in menu**: Run `update-desktop-database`

## Customization

### Icon

Replace `assets/icon.png` with your custom icon (512x512 PNG recommended).

### Build Configuration

Edit `package.json` under the `build` section to customize:

-   Package metadata
-   Dependencies
-   Desktop integration
-   Target architectures

### Post-install Scripts

Modify `build/deb-postinstall.sh` and `build/deb-postremove.sh` for custom installation logic.

## CI/CD

For automated builds, use:

```yaml
# Example GitHub Actions
- name: Build DEB
  run: |
      npm install
      npm run build:deb

- name: Upload artifacts
  uses: actions/upload-artifact@v2
  with:
      name: whatsapp-linux-deb
      path: dist/*.deb
```

## Support

-   **Pop!\_OS**: DEB package (recommended)
-   **Ubuntu**: DEB package
-   **Debian**: DEB package
-   **Fedora**: RPM package
-   **Arch Linux**: Build from source or use AppImage
-   **Any Linux**: AppImage (universal)
