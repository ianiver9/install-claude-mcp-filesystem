# Contributing to Claude MCP Filesystem Setup

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## Code of Conduct

Please be respectful and constructive in all interactions. This is a community project, and we value diverse perspectives and experiences.

## How to Contribute

### Reporting Bugs

Found a bug? Please open an issue with:
- **Clear description** of the problem
- **Steps to reproduce** the issue
- **Expected behavior** vs. actual behavior
- **System information** (Windows version, PowerShell version, Node.js version)
- **Error messages** or logs (especially the MCP log file)

Example:
```
Title: Script fails on Windows 11 with PowerShell 7.3

Description: When running the setup script on Windows 11...
Steps to reproduce:
1. Open PowerShell as Administrator
2. Run .\setup-claude-mcp-filesystem.ps1
3. Script fails at step 4

Error message: [Include full error message]
System info: Windows 11 22H2, PowerShell 7.3.1, Node.js v20.10.0
```

### Suggesting Enhancements

Have an idea for improvement? Open an issue with:
- **Clear description** of the enhancement
- **Use case** or problem it solves
- **Possible implementation** (if you have ideas)
- **Examples** or mockups (if applicable)

### Submitting Pull Requests

1. **Fork** the repository
2. **Create a feature branch**: `git checkout -b feature/your-feature-name`
3. **Make your changes** and test thoroughly on Windows
4. **Test the script** end-to-end to ensure it works
5. **Commit** with clear, descriptive messages:
   ```
   git commit -m "Add feature: description of what was added"
   ```
6. **Push** to your fork: `git push origin feature/your-feature-name`
7. **Open a Pull Request** with:
   - Clear description of changes
   - Why the change is needed
   - Any breaking changes or notes for users

## Testing

Before submitting a PR, please test the script:

- [ ] Run on Windows 10/11 as Administrator
- [ ] Test with Node.js already installed
- [ ] Test with Node.js not installed (auto-install)
- [ ] Test with Claude Desktop running (should terminate)
- [ ] Test with Claude Desktop closed
- [ ] Verify the config file is created correctly
- [ ] Verify Claude Desktop can access files after restart
- [ ] Check for any error messages or warnings

### Test Checklist

```powershell
# 1. Clean test environment
# Uninstall the MCP server first:
npm uninstall -g @modelcontextprotocol/server-filesystem

# 2. Run the script
.\setup-claude-mcp-filesystem.ps1

# 3. Verify installation
npm list -g @modelcontextprotocol/server-filesystem

# 4. Check config file
cat "$env:APPDATA\Claude\claude_desktop_config.json"

# 5. Open Claude Desktop and verify hammer icon
```

## Code Style

### PowerShell Guidelines

- Use **PascalCase** for function names
- Use **camelCase** for variables
- Add **comments** for complex logic
- Keep lines **under 120 characters** where possible
- Use **full parameter names** (not aliases) for clarity

Example:
```powershell
function Install-NodeJS {
    Write-Info "Installing Node.js..."
    $nodeVersion = node --version
    if ($nodeVersion) {
        Write-Success "Node.js is already installed: $nodeVersion"
    }
}
```

### Documentation

- Keep README.md up-to-date with any changes
- Document new features with examples
- Include troubleshooting steps for new features
- Update version numbers and dates

## Project Structure

```
claude-mcp-filesystem-setup/
├── setup-claude-mcp-filesystem.ps1    # Main script
├── README.md                          # Main documentation
├── LICENSE                            # MIT License
├── .gitignore                         # Git ignore rules
├── CONTRIBUTING.md                    # This file
└── CHANGELOG.md                       # Version history
```

## Commit Message Convention

Use clear, descriptive commit messages:

- `fix:` - Bug fixes
- `feat:` - New features
- `docs:` - Documentation changes
- `refactor:` - Code refactoring without feature changes
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

Examples:
```
fix: correct Node.js detection logic for newer versions
feat: add support for custom directory configuration
docs: update troubleshooting section with new error messages
refactor: simplify error handling in MCP installation step
```

## Documentation Updates

If you update functionality, please also update:
- **README.md** - If it affects user-facing behavior
- **Inline comments** - If you change script logic
- **Error messages** - Keep them clear and actionable
- **CHANGELOG.md** - Document the change

## Getting Help

- **Questions?** Open an issue with the label `question`
- **Need guidance?** Comment on an existing issue or PR
- **Have ideas?** Start a discussion in Issues

## Recognition

Contributors will be recognized in:
- README.md contributors section
- CHANGELOG.md release notes
- GitHub contributors page

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

Don't hesitate to ask! This project is meant to be helpful and easy to use. Your feedback makes it better.

---

Thank you for contributing! 🚀
