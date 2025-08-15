# Contributing to WhatsApp Linux

Thank you for your interest in contributing to WhatsApp Linux! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

Before creating an issue, please:

1. **Search existing issues** to avoid duplicates
2. **Use the issue templates** when available
3. **Provide detailed information** including:
    - Operating system and version
    - Package type used (DEB, AppImage, etc.)
    - Steps to reproduce
    - Expected vs actual behavior
    - Screenshots if applicable

### Feature Requests

We welcome feature requests! Please:

1. **Check existing feature requests** first
2. **Describe the feature** clearly and concisely
3. **Explain the use case** and why it would be beneficial
4. **Consider the scope** - keep requests focused and specific

### Pull Requests

#### Before Starting

1. **Fork the repository** and create your branch from `main`
2. **Discuss major changes** in an issue first
3. **Check the roadmap** to align with project direction

#### Development Setup

```bash
# Clone your fork
git clone https://github.com/your-username/whatsapp-linux.git
cd whatsapp-linux

# Install dependencies
npm install

# Install build dependencies (Ubuntu/Debian)
sudo apt-get install libnss3-dev libatk-bridge2.0-dev libdrm2-dev libxcomposite-dev libxdamage-dev libxrandr-dev libgbm-dev libxss-dev libasound2-dev

# Build and test
npm run build
npm run dev
```

#### Code Guidelines

1. **TypeScript**: All code should be written in TypeScript
2. **Formatting**: Use the project's formatting configuration
3. **Linting**: Ensure code passes all linting checks
4. **Comments**: Add comments for complex logic
5. **Security**: Follow security best practices

#### Testing

```bash
# Build and test packages
./build.sh deb
./build.sh appimage

# Test installation (DEB)
sudo dpkg -i dist/*.deb

# Test AppImage
chmod +x dist/*.AppImage
./dist/*.AppImage
```

#### Commit Guidelines

Follow conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:

-   `feat`: New feature
-   `fix`: Bug fix
-   `docs`: Documentation changes
-   `style`: Code style changes
-   `refactor`: Code refactoring
-   `perf`: Performance improvements
-   `test`: Testing changes
-   `build`: Build system changes
-   `ci`: CI configuration changes
-   `chore`: Other changes

Examples:

```
feat(ui): add dark mode toggle
fix(notifications): resolve notification permission issue
docs: update installation instructions
```

#### Pull Request Process

1. **Update documentation** if needed
2. **Add/update tests** for new features
3. **Test on multiple distributions** when possible
4. **Update CHANGELOG.md** with your changes
5. **Ensure CI passes** before requesting review
6. **Keep PRs focused** - one feature/fix per PR

## 🏗️ Project Structure

```
whatsapp-linux/
├── src/                    # TypeScript source code
│   └── main.ts            # Main application entry point
├── assets/                # Application assets (icons, etc.)
├── build/                 # Build scripts and configurations
├── dist/                  # Built packages (generated)
├── .github/               # GitHub workflows and templates
├── build.sh               # Main build script
├── release.sh             # Release helper script
├── package.json           # Node.js dependencies and scripts
├── tsconfig.json          # TypeScript configuration
└── README.md              # Main documentation
```

## 📦 Build System

### Package Types

-   **DEB**: Ubuntu, Pop!\_OS, Debian packages
-   **RPM**: Fedora, CentOS, RHEL packages
-   **AppImage**: Universal Linux packages
-   **Snap**: Ubuntu Snap packages
-   **TAR.GZ**: Generic Linux archives

### Build Scripts

```bash
# Build specific package types
./build.sh deb      # Build DEB package
./build.sh rpm      # Build RPM package
./build.sh appimage # Build AppImage
./build.sh snap     # Build Snap package
./build.sh all      # Build all packages

# Using npm scripts
npm run build:deb
npm run build:appimage
npm run build:all
```

## 🚀 Release Process

### For Maintainers

1. **Update version** in package.json
2. **Update CHANGELOG.md** with new changes
3. **Create release** using the release script:
    ```bash
    ./release.sh 1.2.0
    ```
4. **Monitor CI/CD** pipeline
5. **Test packages** on different distributions
6. **Announce release** to the community

### Versioning

We use [Semantic Versioning](https://semver.org/):

-   **MAJOR**: Breaking changes
-   **MINOR**: New features (backward compatible)
-   **PATCH**: Bug fixes (backward compatible)

## 🔧 Development Tips

### Debugging

```bash
# Run in development mode with debugging
npm run dev

# Enable Electron debugging
DEBUG=* npm run dev

# Check application logs
tail -f ~/.config/WhatsApp\ Linux/logs/main.log
```

### Testing Packages

```bash
# Test DEB package
sudo dpkg -i dist/*.deb
whatsapp-linux

# Test AppImage
chmod +x dist/*.AppImage
./dist/*.AppImage

# Clean up test installation
sudo apt remove whatsapp-linux
```

### Common Issues

**Build failures:**

-   Ensure all dependencies are installed
-   Check Node.js version compatibility
-   Verify file permissions

**Package issues:**

-   Test on clean virtual machines
-   Check dependency requirements
-   Verify desktop integration

## 📝 Documentation

### Writing Documentation

-   Use clear, concise language
-   Include code examples where helpful
-   Keep documentation up to date with changes
-   Use proper Markdown formatting

### Documentation Structure

-   **README.md**: Main project documentation
-   **BUILD.md**: Detailed build instructions
-   **APPIMAGE_GUIDE.md**: AppImage-specific documentation
-   **CONTRIBUTING.md**: This file
-   **CHANGELOG.md**: Version history

## 🌟 Recognition

Contributors will be recognized in:

-   **README.md**: Contributors section
-   **CHANGELOG.md**: Release notes
-   **GitHub**: Contributor graphs and statistics

## 📄 License

By contributing to WhatsApp Linux, you agree that your contributions will be licensed under the MIT License.

## 🤔 Questions?

If you have questions about contributing:

1. **Check existing documentation** first
2. **Search closed issues** for similar questions
3. **Create a new issue** with the "question" label
4. **Join discussions** in existing issues

## 🎯 Development Roadmap

### Short Term

-   [ ] Improved notification customization
-   [ ] Better dark mode support
-   [ ] Performance optimizations
-   [ ] Additional keyboard shortcuts

### Medium Term

-   [ ] Plugin system for extensions
-   [ ] Backup/restore functionality
-   [ ] Multi-account support
-   [ ] Enhanced security features

### Long Term

-   [ ] Wayland support improvements
-   [ ] ARM architecture optimization
-   [ ] Mobile-responsive design
-   [ ] Integration with desktop environments

Thank you for contributing to WhatsApp Linux! 🙏
