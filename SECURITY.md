# Security Policy

## Supported Versions

We provide security updates for the following versions of WhatsApp Linux:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

The WhatsApp Linux team takes security seriously. If you discover a security vulnerability, please report it to us as described below.

### How to Report

**Please do NOT report security vulnerabilities through public GitHub issues.**

Instead, please send an email to: **security@whatsapp-linux.org** (or use the repository owner's email if this doesn't exist)

Include the following information in your report:

1. **Description**: A clear description of the vulnerability
2. **Impact**: What can an attacker achieve with this vulnerability?
3. **Reproduction**: Step-by-step instructions to reproduce the issue
4. **Proof of Concept**: If possible, include a minimal proof of concept
5. **Suggested Fix**: If you have ideas for how to fix the issue

### What to Expect

You should receive a response within **48 hours**. If the issue is confirmed, we will:

1. **Acknowledge** the vulnerability and begin working on a fix
2. **Keep you updated** on our progress
3. **Credit you** (if desired) when we publish the security advisory
4. **Release a patch** as soon as possible

### Security Update Process

When a security vulnerability is confirmed:

1. **Private Fix**: We develop a fix in a private repository
2. **Testing**: The fix is thoroughly tested across all supported platforms
3. **Release**: A new version is released with the security fix
4. **Advisory**: A security advisory is published with details
5. **Notification**: Users are notified through multiple channels

### Security Best Practices

While using WhatsApp Linux, we recommend:

#### For Users

-   **Keep Updated**: Always use the latest version
-   **Download Safely**: Only download from official sources
-   **Verify Checksums**: Verify SHA256 checksums of downloaded packages
-   **System Security**: Keep your operating system updated
-   **Permissions**: Review application permissions regularly

#### For Developers

-   **Secure Coding**: Follow secure coding practices
-   **Dependencies**: Keep dependencies updated
-   **Code Review**: All code changes undergo security review
-   **Testing**: Include security testing in your development process

### Known Security Considerations

#### Electron Security

WhatsApp Linux is built on Electron and follows Electron security best practices:

-   **Node Integration**: Disabled in renderer processes
-   **Context Isolation**: Enabled for all renderer processes
-   **Secure Defaults**: Using secure Electron defaults
-   **Content Security Policy**: Implemented where applicable

#### WebView Security

-   **External Links**: All external links open in the default browser
-   **Content Filtering**: Basic content filtering is implemented
-   **HTTPS Only**: All communications use HTTPS

#### Package Security

-   **Signatures**: All packages are signed where supported
-   **Checksums**: SHA256 checksums provided for all releases
-   **Dependencies**: Regular dependency security audits

### Vulnerability Disclosure Timeline

We aim to follow this timeline for vulnerability disclosure:

-   **Day 0**: Vulnerability reported
-   **Day 1-2**: Initial response and acknowledgment
-   **Day 3-7**: Vulnerability assessment and reproduction
-   **Day 8-30**: Fix development and testing
-   **Day 31**: Public disclosure with patch release

This timeline may be adjusted based on the complexity and severity of the vulnerability.

### Security Tools

We use the following tools to maintain security:

-   **npm audit**: Regular dependency vulnerability scanning
-   **Electron Security**: Following Electron security guidelines
-   **Static Analysis**: Code analysis for security issues
-   **Dependency Updates**: Automated dependency updates

### Contact Information

For security-related questions or concerns:

-   **Email**: security@whatsapp-linux.org (or repository owner's email)
-   **Response Time**: Within 48 hours
-   **Languages**: English

### Hall of Fame

We maintain a hall of fame for security researchers who have responsibly disclosed vulnerabilities:

_No vulnerabilities have been reported yet._

---

Thank you for helping keep WhatsApp Linux and our users safe!
