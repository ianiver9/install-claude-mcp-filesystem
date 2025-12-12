# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-12-10

### Added
- Initial release of Claude Desktop MCP Filesystem Setup script
- Automated Node.js installation detection and setup
- npm verification
- Automatic Claude Desktop process termination
- Global installation of `@modelcontextprotocol/server-filesystem`
- Automatic configuration file generation in `%APPDATA%\Claude`
- Full C:\ drive access configuration
- Color-coded output for better readability
- Administrator privilege checking
- Comprehensive error handling
- Detailed feedback at each step
- README with installation and usage instructions
- MIT License
- .gitignore file
- CONTRIBUTING.md guidelines
- CHANGELOG.md file

### Features
- ✅ Checks for Node.js and npm installation
- ✅ Auto-installs Node.js if missing (via winget)
- ✅ Terminates running Claude Desktop instances
- ✅ Installs MCP Filesystem Server globally
- ✅ Creates and configures claude_desktop_config.json
- ✅ Provides clear user feedback and next steps
- ✅ Administrator privilege validation

### Requirements
- Windows 10 or 11
- Administrator privileges
- Claude Desktop installed

---

## Version History

### Planned Features (Future Releases)

- [ ] Interactive mode for selecting specific directory access instead of full C:\ drive
- [ ] Support for multiple MCP servers configuration
- [ ] Uninstall/reset functionality
- [ ] Rollback mechanism for failed installations
- [ ] Support for environment-specific configurations
- [ ] Integration with Claude CLI
- [ ] Automated updates for the MCP server
- [ ] Configuration backup before changes
- [ ] Detailed setup wizard with options
- [ ] Support for other MCP servers

---

## How to Report Bugs or Request Features

- **Bugs**: Open an issue with the label `bug`
- **Features**: Open an issue with the label `enhancement`
- **Questions**: Open an issue with the label `question`

Please include:
- Clear description of the issue
- Steps to reproduce (for bugs)
- System information (Windows version, PowerShell version, Node.js version)
- Error messages or logs

---

## Upgrade Instructions

### From Previous Versions

Currently on v1.0.0 (initial release). If you're upgrading from a previous manual setup:

1. Back up your current `claude_desktop_config.json`:
   ```powershell
   Copy-Item "$env:APPDATA\Claude\claude_desktop_config.json" "$env:APPDATA\Claude\claude_desktop_config.json.backup"
   ```

2. Run the latest setup script as Administrator

3. Verify the new configuration is correct

4. Restart Claude Desktop

---

## Support

For issues, questions, or feature requests, please visit the [GitHub Issues](https://github.com/yourusername/claude-mcp-filesystem-setup/issues) page.

---

**Last Updated**: December 10, 2025
