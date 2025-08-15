# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

-   Release automation with GitHub Actions
-   Comprehensive build pipeline for multiple Linux package formats
-   MIT License
-   Automated changelog generation

## [1.0.0] - 2025-08-15

### Added

-   Initial release of WhatsApp Linux
-   Electron-based WhatsApp Web wrapper
-   Native Linux desktop integration
-   Multi-format package support (DEB, RPM, AppImage, Snap, TAR.GZ)
-   Cross-architecture support (x64, arm64)
-   System tray integration
-   Desktop notifications
-   Auto-update mechanism
-   Custom CSS injection for better UX
-   Secure external link handling
-   Modern Chrome user agent for compatibility

### Features

-   **Native Integration**: Desktop notifications, system tray, menu integration
-   **Cross-Platform Packages**: DEB, AppImage, RPM, Snap, and TAR.GZ packages
-   **Privacy-Focused**: No data collection, clean WhatsApp Web wrapper
-   **Auto-Updates**: Built-in update mechanism for new releases
-   **Customizable**: Custom CSS injection for better user experience
-   **Keyboard Shortcuts**: Standard Electron shortcuts and custom bindings

### Package Information

-   DEB: ~142 MB (x64, arm64) - Ubuntu, Pop!\_OS, Debian
-   AppImage: ~204 MB (x64) - Universal Linux
-   RPM: ~142 MB (x64, arm64) - Fedora, CentOS, RHEL
-   Snap: ~142 MB (x64) - Ubuntu and various distributions
-   TAR.GZ: ~140 MB (x64, arm64) - Generic Linux

### Security

-   Disabled node integration for security
-   Context isolation enabled
-   Secure external link handling
-   Modern security practices

### Documentation

-   Comprehensive README with installation instructions
-   Build documentation
-   AppImage usage guide
-   Development and contribution guide
-   Troubleshooting section

[Unreleased]: https://github.com/x3daniking/whatsapp-linux/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/x3daniking/whatsapp-linux/releases/tag/v1.0.0
