# Claude-Desktop-Backup

Claude Desktop Backup Script - User Guide
What This Script Does
This Windows batch script creates a complete backup of your Claude Desktop settings, including:

MCP server configurations (claude_desktop_config.json)
Application preferences and settings
Extension configurations and data
Custom dictionary entries
Recent logs
Window positioning preferences

Prerequisites

Windows operating system (batch file format)
Claude Desktop installed (script looks for files in %APPDATA%\Claude)
Administrator rights may be needed if your backup location requires it

Installation

Copy the script into a text file
Save it with a .bat extension (e.g., claude_backup.bat)
Choose a location - somewhere easy to find like:

Your Desktop
C:\Scripts\
Your Documents folder



How to Use
Running the Backup

Close Claude Desktop (recommended but not required)
Double-click the claude_backup.bat file
Follow the prompts:

Script will show source and destination paths
You'll be asked if you want to create a ZIP file (type y or n)
If you create a ZIP, you can optionally delete the folder and keep only the ZIP



What Happens
The script will:

Create a timestamped backup folder in C:\Backups\Claude\
Copy all your Claude Desktop configuration files
Create a backup_info.txt file with backup details
Optionally compress everything into a ZIP file

Backup Location
Default location: C:\Backups\Claude\Claude_Backup_YYYY-MM-DD_HH-MM-SS\
Example: C:\Backups\Claude\Claude_Backup_2025-10-27_14-30-45\
Customising the Backup Location
To change where backups are saved, edit this line in the script:
batchset "BACKUP_BASE=C:\Backups\Claude"
Change C:\Backups\Claude to your preferred location, for example:

D:\MyBackups\Claude
C:\Users\YourName\Documents\Claude_Backups

Restoring from Backup
If You Have a ZIP File:

Close Claude Desktop completely
Extract the ZIP to a temporary location
Open File Explorer and paste this into the address bar: %APPDATA%\Claude
Copy the files from your extracted backup into the Claude folder
Confirm overwrite when prompted
Restart Claude Desktop

If You Have a Folder:

Close Claude Desktop completely
Open File Explorer and paste this into the address bar: %APPDATA%\Claude
Copy the files from your backup folder into the Claude folder
Confirm overwrite when prompted
Restart Claude Desktop

Troubleshooting
"Claude folder not found" Error
Problem: Script can't find your Claude installation.
Solutions:

Make sure Claude Desktop is installed
Check if Claude folder exists at %APPDATA%\Claude
Verify installation location (script assumes standard install path)

Permission Denied Errors
Problem: Can't write to backup location.
Solutions:

Run the script as Administrator (right-click → "Run as administrator")
Change backup location to somewhere you have write access
Check disk space on target drive

ZIP Creation Fails
Problem: PowerShell command fails.
Solutions:

Make sure PowerShell is enabled on your system
Just use the folder backup without creating a ZIP
Manually ZIP the backup folder afterwards using Windows Explorer

Best Practices

Backup regularly - especially before:

Making changes to MCP configurations
Updating Claude Desktop
Adding new extensions


Test your backups - occasionally restore to verify they work
Keep multiple backups - don't delete old backups immediately; keep at least 2-3 recent ones
Document your MCP servers - the backup_info.txt helps you remember what's in each backup

Automation (Optional)
To run backups automatically:

Open Task Scheduler (search in Windows Start menu)
Create Basic Task
Set trigger (e.g., weekly on Sundays at 2am)
Action: Start a program
Program: Point to your claude_backup.bat file
Finish and test

Note: For automated backups, you may want to modify the script to skip the ZIP prompts.
What's NOT Backed Up
This script does not backup:

Your actual conversations with Claude (stored server-side)
Projects content (stored in Claude's cloud)
Large cache files (intentionally excluded to save space)

Support
If you encounter issues:

Check the backup_info.txt file in your backup folder for details
Verify the paths in the script match your system
Ensure you have sufficient disk space for the backup


Script Version: 1.0
Last Updated: October 2025
Tested On: Windows 10/11
