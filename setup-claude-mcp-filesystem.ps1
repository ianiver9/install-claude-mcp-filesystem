# Claude Desktop MCP Filesystem Server Setup Script
# This script automates the setup of the Filesystem MCP server for Claude Desktop on Windows
# Run as Administrator

param(
    [switch]$Force = $false
)

# Color codes for output
$colors = @{
    Info    = 'Cyan'
    Success = 'Green'
    Warning = 'Yellow'
    Error   = 'Red'
}

function Write-Info {
    param([string]$Message)
    Write-Host $Message -ForegroundColor $colors.Info
}

function Write-Success {
    param([string]$Message)
    Write-Host $Message -ForegroundColor $colors.Success
}

function Write-Warning {
    param([string]$Message)
    Write-Host $Message -ForegroundColor $colors.Warning
}

function Write-Error {
    param([string]$Message)
    Write-Host $Message -ForegroundColor $colors.Error
}

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')
if (-not $isAdmin) {
    Write-Error "ERROR: This script must be run as Administrator."
    Write-Info "Please right-click PowerShell and select 'Run as Administrator', then run this script again."
    exit 1
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Claude Desktop MCP Filesystem Setup" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Check and install Node.js if needed
Write-Info "[1/5] Checking Node.js installation..."
$nodeVersion = node --version 2>$null
if ($nodeVersion) {
    Write-Success "✓ Node.js is installed: $nodeVersion"
} else {
    Write-Warning "Node.js not found. Installing Node.js LTS..."
    try {
        # Use winget to install Node.js
        winget install OpenJS.NodeJS -e --accept-package-agreements --accept-source-agreements
        $nodeVersion = node --version
        Write-Success "✓ Node.js installed successfully: $nodeVersion"
    } catch {
        Write-Error "Failed to install Node.js. Please install manually from https://nodejs.org/"
        exit 1
    }
}

# Step 2: Check npm
Write-Info "[2/5] Checking npm installation..."
$npmVersion = npm --version 2>$null
if ($npmVersion) {
    Write-Success "✓ npm is installed: $npmVersion"
} else {
    Write-Error "npm not found. Node.js installation may have failed."
    exit 1
}

# Step 3: Kill running Claude processes
Write-Info "[3/5] Checking for running Claude Desktop instances..."
$claudeProcesses = Get-Process -Name "Claude" -ErrorAction SilentlyContinue
if ($claudeProcesses) {
    Write-Warning "Found running Claude Desktop process(es). Terminating..."
    $claudeProcesses | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Write-Success "✓ Claude Desktop processes terminated"
} else {
    Write-Success "✓ No running Claude Desktop instances found"
}

# Step 4: Install MCP Filesystem Server
Write-Info "[4/5] Installing @modelcontextprotocol/server-filesystem..."
try {
    npm install -g @modelcontextprotocol/server-filesystem
    $mcpCheck = npm list -g @modelcontextprotocol/server-filesystem 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Success "✓ MCP Filesystem Server installed successfully"
    } else {
        throw "npm list returned non-zero exit code"
    }
} catch {
    Write-Error "Failed to install MCP Filesystem Server. Error: $_"
    exit 1
}

# Step 5: Create Claude Desktop configuration
Write-Info "[5/5] Creating Claude Desktop configuration..."
$claudeConfigPath = "$env:APPDATA\Claude"
$claudeConfigFile = Join-Path $claudeConfigPath "claude_desktop_config.json"

try {
    # Create directory if it doesn't exist
    if (-not (Test-Path $claudeConfigPath)) {
        New-Item -ItemType Directory -Path $claudeConfigPath -Force | Out-Null
        Write-Info "Created Claude config directory"
    }

    # Create the JSON configuration
    # IMPORTANT: Using full path to npx.cmd for Windows reliability
    $config = @{
        mcpServers = @{
            filesystem = @{
                command = "C:\Program Files\nodejs\npx.cmd"
                args = @(
                    "-y",
                    "@modelcontextprotocol/server-filesystem",
                    "C:\"
                )
            }
        }
    }

    # Convert to JSON and save
    $jsonContent = $config | ConvertTo-Json -Depth 10
    Set-Content -Path $claudeConfigFile -Value $jsonContent -Encoding UTF8

    Write-Success "✓ Configuration file created at: $claudeConfigFile"
    Write-Info "Filesystem access path: C:\ (full drive access)"
    Write-Info "MCP Command: Using full path to npx.cmd for Windows reliability"

} catch {
    Write-Error "Failed to create configuration file. Error: $_"
    exit 1
}

# Final summary
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Success "Setup Complete!"
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Info "Next steps:"
Write-Info "1. Reopen Claude Desktop"
Write-Info "2. You should see a hammer/wrench icon in the message input area (tools icon)"
Write-Info "3. Click it to verify the Filesystem MCP server is connected"
Write-Info "`nConfiguration details:"
Write-Info "  Config file: $claudeConfigFile"
Write-Info "  Access path: C:\ (entire drive)"
Write-Info "  MCP Server: @modelcontextprotocol/server-filesystem"
Write-Info "  MCP Command: C:\Program Files\nodejs\npx.cmd"
Write-Info "`nYou can now access any file on your system through Claude!"
Write-Host ""
