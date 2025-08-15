// WhatsApp Linux Documentation JavaScript

document.addEventListener("DOMContentLoaded", function () {
	// Tab functionality
	const tabButtons = document.querySelectorAll(".tab-button");
	const tabPanes = document.querySelectorAll(".tab-pane");

	tabButtons.forEach((button) => {
		button.addEventListener("click", () => {
			const targetTab = button.getAttribute("data-tab");

			// Remove active class from all buttons and panes
			tabButtons.forEach((btn) => btn.classList.remove("active"));
			tabPanes.forEach((pane) => pane.classList.remove("active"));

			// Add active class to clicked button and corresponding pane
			button.classList.add("active");
			document.getElementById(targetTab).classList.add("active");
		});
	});

	// Smooth scrolling for navigation links
	const navLinks = document.querySelectorAll('a[href^="#"]');

	navLinks.forEach((link) => {
		link.addEventListener("click", function (e) {
			e.preventDefault();

			const targetId = this.getAttribute("href").substring(1);
			const targetElement = document.getElementById(targetId);

			if (targetElement) {
				const headerHeight = document.querySelector("header").offsetHeight;
				const targetPosition = targetElement.offsetTop - headerHeight - 20;

				window.scrollTo({
					top: targetPosition,
					behavior: "smooth",
				});
			}
		});
	});

	// Download link updates (update version numbers dynamically)
	function updateDownloadLinks() {
		// This would typically fetch the latest version from GitHub API
		// For now, we'll use a placeholder version
		const version = "1.0.0";

		const downloadLinks = {
			deb: `https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-${version}-amd64.deb`,
			appimage: `https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-${version}-x86_64.AppImage`,
			rpm: `https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-${version}-x86_64.rpm`,
			tarGz: `https://github.com/x3daniking/whatsapp-linux/releases/latest/download/WhatsApp-Linux-${version}-linux-x64.tar.gz`,
		};

		// Update download button URLs
		document.querySelectorAll(".download-card .btn").forEach((btn) => {
			const href = btn.getAttribute("href");
			if (href && href.includes("WhatsApp-Linux-")) {
				// Extract package type from href
				if (href.includes(".deb")) {
					btn.setAttribute("href", downloadLinks.deb);
				} else if (href.includes(".AppImage")) {
					btn.setAttribute("href", downloadLinks.appimage);
				} else if (href.includes(".rpm")) {
					btn.setAttribute("href", downloadLinks.rpm);
				} else if (href.includes(".tar.gz")) {
					btn.setAttribute("href", downloadLinks.tarGz);
				}
			}
		});

		// Update installation code examples
		document.querySelectorAll("pre code").forEach((code) => {
			code.innerHTML = code.innerHTML.replace(/WhatsApp-Linux-[\d\.]+-/g, `WhatsApp-Linux-${version}-`);
		});
	}

	// Call update function
	updateDownloadLinks();

	// GitHub API integration (optional - for dynamic content)
	async function fetchLatestRelease() {
		try {
			const response = await fetch("https://api.github.com/repos/x3daniking/whatsapp-linux/releases/latest");
			const data = await response.json();

			if (data.tag_name) {
				const version = data.tag_name.replace("v", "");
				updateDownloadLinksWithVersion(version);
				updateInstallationInstructions(version);
			}
		} catch (error) {
			console.log("Could not fetch latest release info:", error);
			// Fallback to default version
		}
	}

	function updateDownloadLinksWithVersion(version) {
		const baseUrl = `https://github.com/x3daniking/whatsapp-linux/releases/download/v${version}`;

		const linkMapping = {
			deb: `${baseUrl}/WhatsApp-Linux-${version}-amd64.deb`,
			appimage: `${baseUrl}/WhatsApp-Linux-${version}-x86_64.AppImage`,
			rpm: `${baseUrl}/WhatsApp-Linux-${version}-x86_64.rpm`,
			tarGz: `${baseUrl}/WhatsApp-Linux-${version}-linux-x64.tar.gz`,
		};

		// Update all download links
		document.querySelectorAll(".download-card .btn-primary").forEach((btn, index) => {
			const types = ["deb", "appimage", "rpm", "tarGz"];
			if (types[index] && linkMapping[types[index]]) {
				btn.setAttribute("href", linkMapping[types[index]]);
			}
		});
	}

	function updateInstallationInstructions(version) {
		// Update code examples with the latest version
		const codeBlocks = document.querySelectorAll(".tab-pane pre code");

		codeBlocks.forEach((code) => {
			let content = code.textContent;
			// Replace version numbers in download URLs
			content = content.replace(/WhatsApp-Linux-[\d\.]+-/g, `WhatsApp-Linux-${version}-`);
			code.textContent = content;
		});
	}

	// Fetch latest release info (optional)
	// Uncomment the line below if you want to use GitHub API
	// fetchLatestRelease();

	// Copy to clipboard functionality for code blocks
	document.querySelectorAll("pre").forEach((pre) => {
		const button = document.createElement("button");
		button.className = "copy-button";
		button.textContent = "Copy";
		button.style.cssText = `
            position: absolute;
            top: 10px;
            right: 10px;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            opacity: 0;
            transition: opacity 0.3s ease;
        `;

		pre.style.position = "relative";
		pre.appendChild(button);

		pre.addEventListener("mouseenter", () => {
			button.style.opacity = "1";
		});

		pre.addEventListener("mouseleave", () => {
			button.style.opacity = "0";
		});

		button.addEventListener("click", async () => {
			const code = pre.querySelector("code");
			const text = code ? code.textContent : pre.textContent;

			try {
				await navigator.clipboard.writeText(text);
				button.textContent = "Copied!";
				setTimeout(() => {
					button.textContent = "Copy";
				}, 2000);
			} catch (err) {
				console.error("Failed to copy text: ", err);
				button.textContent = "Failed";
				setTimeout(() => {
					button.textContent = "Copy";
				}, 2000);
			}
		});
	});

	// Intersection Observer for scroll animations
	const observerOptions = {
		threshold: 0.1,
		rootMargin: "0px 0px -50px 0px",
	};

	const observer = new IntersectionObserver((entries) => {
		entries.forEach((entry) => {
			if (entry.isIntersecting) {
				entry.target.style.opacity = "1";
				entry.target.style.transform = "translateY(0)";
			}
		});
	}, observerOptions);

	// Observe elements for animation
	document.querySelectorAll(".feature, .download-card, .step, .req-card").forEach((el) => {
		el.style.opacity = "0";
		el.style.transform = "translateY(20px)";
		el.style.transition = "opacity 0.6s ease, transform 0.6s ease";
		observer.observe(el);
	});

	// Mobile menu toggle (if needed)
	const createMobileMenu = () => {
		const nav = document.querySelector("nav .container");
		const navLinks = document.querySelector(".nav-links");

		if (window.innerWidth <= 768) {
			if (!document.querySelector(".mobile-menu-toggle")) {
				const toggle = document.createElement("button");
				toggle.className = "mobile-menu-toggle";
				toggle.innerHTML = "☰";
				toggle.style.cssText = `
                    background: none;
                    border: none;
                    font-size: 1.5rem;
                    cursor: pointer;
                    color: var(--text-color);
                    display: none;
                `;

				if (window.innerWidth <= 768) {
					toggle.style.display = "block";
					navLinks.style.display = "none";
				}

				toggle.addEventListener("click", () => {
					const isVisible = navLinks.style.display === "flex";
					navLinks.style.display = isVisible ? "none" : "flex";
					navLinks.style.flexDirection = "column";
					navLinks.style.position = "absolute";
					navLinks.style.top = "100%";
					navLinks.style.left = "0";
					navLinks.style.right = "0";
					navLinks.style.background = "white";
					navLinks.style.boxShadow = "var(--shadow)";
					navLinks.style.padding = "1rem";
				});

				nav.appendChild(toggle);
			}
		}
	};

	// Handle responsive navigation
	window.addEventListener("resize", createMobileMenu);
	createMobileMenu();
});
