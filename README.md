Claude Desktop Backup Script
A Windows batch script for backing up Claude Desktop settings, configurations, and MCP server setups.
📋 Overview
This script creates timestamped backups of your Claude Desktop configuration, including:

MCP server configurations (claude_desktop_config.json)
Application preferences and settings
Extension configurations and data
Custom dictionary entries
Recent application logs
Window positioning preferences

🚀 Quick Start

Download the claude_backup.bat file
Place it somewhere convenient (Desktop, Documents, etc.)
Double-click to run
Follow prompts to create backup

📦 What Gets Backed Up
Claude Desktop Backup/
├── claude_desktop_config.json    # MCP server configs
├── config.json                    # App preferences
├── window-state.json              # Window positioning
├── Preferences                    # User preferences
├── Local State                    # Application state
├── Custom Dictionary.txt          # (if exists)
├── Claude Extensions Settings/    # Extension configs
├── Claude Extensions/             # Extension data
├── logs/                          # Recent logs
└── backup_info.txt                # Backup metadata
💻 Requirements

OS: Windows 10 or later
Claude Desktop: Installed in standard location
PowerShell: Required for ZIP creation (optional feature)
Disk Space: ~50-200MB per backup (varies by config)

🔧 Installation
Method 1: Download
bash# Clone this repository
git clone https://github.com/yourusername/claude-backup-script.git
cd claude-backup-script
Method 2: Manual

Copy the script code into a text file
Save as claude_backup.bat
Place in your preferred location

📖 Usage
Basic Backup
batch# Double-click the .bat file or run from command prompt:
claude_backup.bat
```

### What Happens
1. Script creates timestamped folder in `C:\Backups\Claude\`
2. Copies all configuration files
3. Prompts for ZIP creation (optional)
4. Displays backup location and completion message

### Example Output
```
========================================
   Claude Desktop Backup Script
========================================

Creating backup directory...

Source: C:\Users\YourName\AppData\Roaming\Claude
Backup: C:\Backups\Claude\Claude_Backup_2025-10-27_14-30-45

Copying Claude Desktop settings...
Copying configuration files...
Copying extension settings...
Copying extensions data...
Copying recent logs...
Creating backup information file...

Create ZIP file? (y/n): y

Creating ZIP file...
ZIP file created: C:\Backups\Claude\Claude_Backup_2025-10-27_14-30-45.zip

Delete backup folder and keep only ZIP? (y/n): y
Backup folder deleted, ZIP file retained.

========================================
        Backup Complete!
========================================

Your Claude Desktop settings have been backed up to:
C:\Backups\Claude\Claude_Backup_2025-10-27_14-30-45.zip
🔄 Restoring from Backup
Prerequisites

Close Claude Desktop completely before restoring

Steps

Navigate to Claude folder:

Press Win + R
Type: %APPDATA%\Claude
Press Enter


Extract your backup (if ZIP) or open backup folder
Copy files from backup to Claude folder
Confirm overwrite when prompted
Restart Claude Desktop

Quick Restore Command
batch# If you have an extracted backup folder:
xcopy "C:\Backups\Claude\Claude_Backup_2025-10-27_14-30-45\*" "%APPDATA%\Claude\" /E /H /Y
⚙️ Configuration
Change Backup Location
Edit line 17 in the script:
batchset "BACKUP_BASE=C:\Backups\Claude"
Change to your preferred location:
batchset "BACKUP_BASE=D:\MyBackups\Claude"
set "BACKUP_BASE=%USERPROFILE%\Documents\Claude_Backups"
Automated Backups
Use Windows Task Scheduler:

Open Task Scheduler
Create Basic Task
Set Trigger (e.g., weekly)
Action: Start a program
Program: C:\path\to\claude_backup.bat
Finish

🐛 Troubleshooting
"Claude folder not found" Error
Problem: Script can't locate Claude Desktop installation
Solution:
batch# Verify Claude folder exists:
dir %APPDATA%\Claude

# If not found, Claude Desktop may not be installed
# or installed in non-standard location
Permission Denied
Problem: Can't write to backup location
Solutions:

Run as Administrator (right-click → "Run as administrator")
Change backup path to user-writable location
Check disk space

ZIP Creation Fails
Problem: PowerShell ZIP command fails
Solutions:

Skip ZIP creation (just use folder backup)
Manually ZIP folder using Windows Explorer
Check PowerShell execution policy:

powershell  Get-ExecutionPolicy
  # If restricted, run as admin:
  Set-ExecutionPolicy RemoteSigned
✅ Best Practices

Backup before:

Updating Claude Desktop
Changing MCP configurations
Adding/removing extensions


Keep multiple backups: Maintain 3-5 recent backups
Test restores: Periodically verify backups work
Document changes: Use backup_info.txt to track what changed

📝 Notes
What's NOT Backed Up

Conversation history (stored server-side)
Project content (stored in Claude cloud)
Large cache files (excluded intentionally)
Session tokens (security)

Backup Size

Typical: 10-50MB
With extensions: 50-200MB
Depends on: MCP servers, extensions, logs

🤝 Contributing
Contributions welcome! Please:

Fork the repository
Create feature branch (git checkout -b feature/improvement)
Commit changes (git commit -am 'Add improvement')
Push to branch (git push origin feature/improvement)
Open Pull Request

📄 License
This project is licensed under the MIT License - see LICENSE file for details.
🙏 Acknowledgments

Built for the Claude Desktop community
Inspired by user requests for configuration backup solutions
Thanks to all testers and contributors

📞 Support

Issues: GitHub Issues
Discussions: GitHub Discussions

🔖 Version History

v1.0.0 (2025-10-27)

Initial release
Basic backup functionality
ZIP compression option
Backup metadata generation




Made with ☕ for the Claude Desktop community
