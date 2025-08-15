import { app, BrowserWindow, Menu, shell, session } from "electron";
import * as path from "path";

class WhatsAppApp {
	private mainWindow: BrowserWindow | null = null;

	constructor() {
		app.whenReady().then(() => this.createWindow());
		app.on("window-all-closed", this.onWindowAllClosed);
		app.on("activate", this.onActivate);
	}

	private createWindow(): void {
		// Configure session for better WhatsApp Web compatibility
		session.defaultSession.setUserAgent(
			"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
		);

		this.mainWindow = new BrowserWindow({
			width: 1200,
			height: 800,
			minWidth: 800,
			minHeight: 600,
			icon: path.join(__dirname, "../assets/icon.png"), // Add your icon
			webPreferences: {
				nodeIntegration: false,
				contextIsolation: true,
				webSecurity: false,
				allowRunningInsecureContent: true,
			},
			titleBarStyle: "default",
			show: false, // Don't show until ready
		});

		// Load WhatsApp Web
		this.mainWindow.loadURL("https://web.whatsapp.com");

		// Show window when ready
		this.mainWindow.once("ready-to-show", () => {
			this.mainWindow?.show();
		});

		// Handle external links
		this.mainWindow.webContents.setWindowOpenHandler(({ url }) => {
			shell.openExternal(url);
			return { action: "deny" };
		});

		// Handle navigation
		this.mainWindow.webContents.on("will-navigate", (event, url) => {
			if (!url.startsWith("https://web.whatsapp.com")) {
				event.preventDefault();
				shell.openExternal(url);
			}
		});

		// Inject custom CSS for better integration
		this.mainWindow.webContents.once("dom-ready", () => {
			this.injectCustomStyles();
		});

		this.createMenu();
	}

	private injectCustomStyles(): void {
		const css = `
      /* Hide unnecessary elements */
      [data-testid="alert-phone-battery-low"] { display: none !important; }
      
      /* Better scrollbars */
      ::-webkit-scrollbar {
        width: 8px;
      }
      ::-webkit-scrollbar-track {
        background: #2a2f32;
      }
      ::-webkit-scrollbar-thumb {
        background: #54656f;
        border-radius: 4px;
      }
      ::-webkit-scrollbar-thumb:hover {
        background: #6b7c85;
      }
    `;

		this.mainWindow?.webContents.insertCSS(css);
	}

	private createMenu(): void {
		const template: Electron.MenuItemConstructorOptions[] = [
			{
				label: "File",
				submenu: [
					{
						label: "Quit",
						accelerator: "CmdOrCtrl+Q",
						click: () => app.quit(),
					},
				],
			},
			{
				label: "Edit",
				submenu: [
					{ role: "undo" },
					{ role: "redo" },
					{ type: "separator" },
					{ role: "cut" },
					{ role: "copy" },
					{ role: "paste" },
					{ role: "selectAll" },
				],
			},
			{
				label: "View",
				submenu: [
					{ role: "reload" },
					{ role: "forceReload" },
					{ role: "toggleDevTools" },
					{ type: "separator" },
					{ role: "resetZoom" },
					{ role: "zoomIn" },
					{ role: "zoomOut" },
					{ type: "separator" },
					{ role: "togglefullscreen" },
				],
			},
			{
				label: "Window",
				submenu: [{ role: "minimize" }, { role: "close" }],
			},
		];

		const menu = Menu.buildFromTemplate(template);
		Menu.setApplicationMenu(menu);
	}

	private onWindowAllClosed = (): void => {
		if (process.platform !== "darwin") {
			app.quit();
		}
	};

	private onActivate = (): void => {
		if (BrowserWindow.getAllWindows().length === 0) {
			this.createWindow();
		}
	};
}

// Initialize the app
new WhatsAppApp();
