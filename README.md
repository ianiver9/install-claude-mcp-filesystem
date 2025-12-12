# Claude Desktop MCP Filesystem Server Setup

Automated PowerShell script to set up the Model Context Protocol (MCP) Filesystem Server for Claude Desktop on Windows. This enables Claude to access your local filesystem securely.

## Overview

This script automates the entire setup process for connecting Claude Desktop to your local Windows filesystem via the MCP Filesystem Server. Instead of manual configuration, simply run the script and you're ready to go.

### What It Does

- ✅ Checks for Node.js and npm (installs if missing)
- ✅ Terminates any running Claude Desktop instances
- ✅ Installs `@modelcontextprotocol/server-filesystem` globally
- ✅ Creates the `claude_desktop_config.json` configuration file
- ✅ Grants Claude access to your entire C:\ drive
- ✅ Provides clear feedback at each step

## Prerequisites

- **Windows 10 or 11**
- **Administrator privileges** (required to run the script)
- **Claude Desktop** installed (download from [Anthropic](https://claude.ai/download))

## Installation

### Quick Start

1. **Download** the `setup-claude-mcp-filesystem.ps1` script
2. **Right-click PowerShell** and select "Run as Administrator"
3. **Navigate** to the script directory:
   ```powershell
   cd "C:\path\to\script\directory"
   ```
4. **Run** the script:
   ```powershell
   .\setup-claude-mcp-filesystem.ps1
   ```
5. **Reopen Claude Desktop** after the script completes

### Step-by-Step

#### Step 1: Download the Script
Clone this repository or download `setup-claude-mcp-filesystem.ps1`:
```powershell
git clone https://github.com/yourusername/claude-mcp-filesystem-setup.git
cd claude-mcp-filesystem-setup
```

#### Step 2: Run as Administrator
Open PowerShell as Administrator:
- Press `Win + X` → Select "Windows PowerShell (Admin)"
- Or right-click PowerShell → "Run as Administrator"

#### Step 3: Execute the Script
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\setup-claude-mcp-filesystem.ps1
```

#### Step 4: Verify Installation
- Open Claude Desktop
- Look for a **hammer/wrench icon** in the message input area
- Click it to verify the Filesystem MCP server is connected

## Features

### What Claude Can Access

Once configured, Claude can:
- **Read** any file on your system (text, Office documents, code, etc.)
- **Analyze** files and answer questions about them
- **Create** new files and directories
- **Edit** existing files
- **Search** through your filesystem
- **Organize** your files programmatically

All operations require your explicit approval through Claude's interface.

### Security

- **Local processing**: All operations happen on your machine
- **Granular permissions**: You approve each action Claude performs
- **Full drive access**: Configured to access C:\ (customizable)
- **User permissions**: Operates with your user account privileges

## Configuration

The script creates a configuration file at:
```
C:\Users\[YourUsername]\AppData\Roaming\Claude\claude_desktop_config.json
```

### Default Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:\"
      ]
    }
  }
}
```

### Customizing Access Paths

To restrict Claude to specific directories instead of the entire C:\ drive, edit the config file:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "C:\\Users\\[YourUsername]\\Documents",
        "C:\\Users\\[YourUsername]\\Projects"
      ]
    }
  }
}
```

Then restart Claude Desktop completely.

## Troubleshooting

### The hammer icon doesn't appear after setup

1. **Check the MCP logs**:
   - Claude Desktop → Menu → Help → Enable Developer Mode
   - Menu → Developer → MCP Log File

2. **Verify Node.js installation**:
   ```powershell
   node --version
   npm --version
   ```

3. **Verify the MCP server is installed**:
   ```powershell
   npm list -g @modelcontextprotocol/server-filesystem
   ```

4. **Completely close Claude Desktop** and reopen it (not just minimize)

### "Access Denied" when running the script

- Right-click PowerShell and select "Run as Administrator"
- Ensure you have administrator privileges on your account

### Node.js installation fails

The script attempts to use `winget` to install Node.js. If this fails:
- Download Node.js manually from [nodejs.org](https://nodejs.org/)
- Install the LTS version
- Run the script again

### Claude can't access certain directories

- Verify the paths in `claude_desktop_config.json` are correct
- Check that the directories exist and you have read/write permissions
- Use full paths (e.g., `C:\Users\YourName\Documents`, not `~/Documents`)

## Usage Examples

Once set up, you can ask Claude to:

- **Analyze a file**: "Read and summarize this Excel spreadsheet"
- **Find files**: "Search for all .docx files in my Documents folder"
- **Create files**: "Create a new file with this content at C:\Users\YourName\Desktop\test.txt"
- **Edit files**: "Update the configuration in my settings.json file"
- **Organize files**: "Move all PNG files from Downloads to Pictures"

## Advanced Configuration

### Multiple MCP Servers

You can add other MCP servers to the same config file:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "C:\\"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "your_token_here"
      }
    }
  }
}
```

### Updating the MCP Server

To update to the latest version of the Filesystem MCP server:

```powershell
npm install -g @modelcontextprotocol/server-filesystem@latest
```

Then restart Claude Desktop.

## Uninstalling

To remove the MCP Filesystem Server:

```powershell
npm uninstall -g @modelcontextprotocol/server-filesystem
```

Then remove or edit the config file at:
```
C:\Users\[YourUsername]\AppData\Roaming\Claude\claude_desktop_config.json
```

## Contributing

Found a bug or have a suggestion? Feel free to open an issue or submit a pull request!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Resources

- [Claude Desktop Documentation](https://support.claude.com/)
- [Model Context Protocol (MCP)](https://modelcontextprotocol.io/)
- [MCP Filesystem Server](https://modelcontextprotocol.io/docs/develop/connect-local-servers)
- [Node.js](https://nodejs.org/)

## Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review the [Claude support documentation](https://support.claude.com/)
3. Open an issue on this GitHub repository

---

**Last Updated**: December 2025  
**Tested on**: Windows 10/11 with Claude Desktop and Node.js v20+
