# WhatsApp Linux

An easy Electron client for WhatsApp Web on Linux systems with native desktop integration.

## 🚀 Features

-   **Native Linux Integration** - Desktop notifications, system tray, and menu integration
-   **Cross-Platform Packages** - DEB, AppImage, RPM, and Snap packages
-   **Privacy-Focused** - No data collection, just a clean WhatsApp Web wrapper
-   **Auto-Updates** - Built-in update mechanism for new releases
-   **Customizable** - Custom CSS injection for better user experience
-   **Keyboard Shortcuts** - Standard Electron shortcuts and custom bindings

## 📦 Installation

### Pop!\_OS / Ubuntu / Debian (DEB Package)

```bash
# Download the latest release
wget https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-amd64.deb

# Install
sudo dpkg -i WhatsApp-Linux-amd64.deb
sudo apt-get install -f  # Fix any dependency issues
```

### Universal Linux (AppImage)

```bash
# Download the AppImage
wget https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-x86_64.AppImage

# Make executable and run
chmod +x WhatsApp-Linux-x86_64.AppImage
./WhatsApp-Linux-x86_64.AppImage
```

### Fedora / CentOS / RHEL (RPM Package)

```bash
# Download and install
wget https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-x86_64.rpm
sudo rpm -i WhatsApp-Linux-x86_64.rpm
```

### Snap Package

```bash
# Install from Snap Store (coming soon)
sudo snap install whatsapp-linux
```

## 🛠️ Building from Source

### Prerequisites

```bash
# Ubuntu/Pop!_OS/Debian
sudo apt update
sudo apt install nodejs npm git build-essential

# Additional build dependencies
sudo apt install libnss3-dev libatk-bridge2.0-dev libdrm2-dev libxcomposite-dev libxdamage-dev libxrandr-dev libgbm-dev libxss-dev libasound2-dev
```

### Build Instructions

```bash
# Clone the repository
git clone https://github.com/x3daniking/whatsapp-linux.git
cd whatsapp-linux

# Install dependencies
npm install

# Build TypeScript
npm run build

# Create packages
./build.sh deb      # For DEB package
./build.sh appimage # For AppImage
./build.sh all      # For all packages

# Or use make
make deb            # Build DEB package
make appimage       # Build AppImage
make all            # Build all packages
make install        # Build and install DEB locally
```

## 🎯 Quick Development

```bash
# Development mode (auto-reload)
npm run dev

# Production build and run
npm start

# Build specific package types
npm run build:deb
npm run build:appimage
npm run build:rpm
npm run build:all
```

## 📋 Package Information

| Package Type | Size    | Target Systems           | Architecture |
| ------------ | ------- | ------------------------ | ------------ |
| DEB          | ~142 MB | Ubuntu, Pop!\_OS, Debian | x64, arm64   |
| AppImage     | ~204 MB | Universal Linux          | x64          |
| RPM          | ~142 MB | Fedora, CentOS, RHEL     | x64, arm64   |
| Snap         | ~142 MB | Ubuntu, Various          | x64          |

## 🔧 Configuration

### Custom Styles

The application automatically injects custom CSS for better integration:

-   Improved scrollbars
-   Hidden battery warnings
-   Better dark mode support

### User Agent

Uses a modern Chrome user agent for optimal WhatsApp Web compatibility.

### Security

-   Disabled node integration for security
-   Context isolation enabled
-   Secure external link handling

## 📖 Documentation

-   [Build Instructions](BUILD.md) - Detailed build documentation
-   [AppImage Guide](APPIMAGE_GUIDE.md) - AppImage usage and distribution
-   [Development Guide](README_BUILD.md) - Development and contribution guide

## 🐛 Troubleshooting

### Common Issues

**Application won't start:**

```bash
# Check dependencies
ldd /opt/WhatsApp\ Linux/whatsapp-linux

# Reinstall dependencies
sudo apt-get install --reinstall libgtk-3-0 libnotify4 libnss3
```

**No desktop integration:**

```bash
# Update desktop database
update-desktop-database ~/.local/share/applications/
sudo update-desktop-database /usr/share/applications/
```

**AppImage won't run:**

```bash
# Install FUSE if missing
sudo apt install fuse

# Make sure it's executable
chmod +x *.AppImage
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Setup

```bash
git clone https://github.com/x3daniking/whatsapp-linux.git
cd whatsapp-linux
npm install
npm run dev
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚖️ Disclaimer

This is an unofficial client and is not affiliated with WhatsApp or Meta. WhatsApp is a trademark of Meta Platforms, Inc.

## 🌟 Acknowledgments

-   [Electron](https://electronjs.org/) - Cross-platform desktop apps framework
-   [WhatsApp Web](https://web.whatsapp.com/) - Official web interface
-   [electron-builder](https://electron.build/) - Package and build tool

## 📊 System Requirements

### Minimum Requirements

-   **OS**: Ubuntu 18.04+, Pop!\_OS 20.04+, Debian 10+, Fedora 32+
-   **RAM**: 512 MB
-   **Storage**: 200 MB free space
-   **Architecture**: x86_64 (64-bit)

### Recommended

-   **RAM**: 1 GB or more
-   **Network**: Stable internet connection
-   **Display**: 1024x768 or higher resolution

## 🔄 Updates

The application includes automatic update checking. When a new version is available, you'll be notified and can update through the application menu.

### Manual Updates

**DEB Package:**

```bash
wget https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-amd64.deb
sudo dpkg -i WhatsApp-Linux-amd64.deb
```

**AppImage:**
Simply download the new AppImage and replace the old one.

## 🚀 Release Management

### For Users

Get the latest release from our [GitHub Releases page](https://github.com/x3daniking/whatsapp-linux/releases) or visit our [project website](https://x3daniking.github.io/whatsapp-linux/).

### For Developers

We use automated release workflows with GitHub Actions:

#### Creating a Release

```bash
# Method 1: Using the release script
./release.sh 1.2.0

# Method 2: Using version bump script
./bump-version.sh patch  # or minor, major
git add .
git commit -m "chore: bump version to $(node -p "require('./package.json').version")"
git push origin main
git tag v$(node -p "require('./package.json').version")
git push origin v$(node -p "require('./package.json').version")
```

#### Release Workflow

1. **Version Bump**: Update version in `package.json` and documentation
2. **Changelog**: Update `CHANGELOG.md` with new features and fixes
3. **Commit & Tag**: Commit changes and create a Git tag
4. **GitHub Actions**: Automated build and release creation
5. **Package Distribution**: Automatic upload of DEB, RPM, AppImage, and TAR.GZ packages

#### Available Scripts

-   `./release.sh <version>` - Complete release workflow
-   `./bump-version.sh <type>` - Version bumping (patch/minor/major)
-   `make release VERSION=x.x.x` - Alternative release method

### Continuous Integration

Our CI/CD pipeline includes:

-   **Build Testing**: Automated builds on every commit
-   **Multi-format Packaging**: DEB, RPM, AppImage, Snap, TAR.GZ
-   **Release Automation**: Automatic GitHub releases on tag push
-   **Documentation Deployment**: GitHub Pages for project website
-   **Security Scanning**: Dependency vulnerability checks

---

**Made with ❤️ for the Linux community**
