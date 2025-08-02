# Python Project Startup Template

This folder contains reusable configuration files and scripts to quickly set up new Python projects with best practices.

## Quick Setup

**Automated Setup (Recommended):**
```bash
./setup.sh --name my-project --description "My awesome project"
./setup.sh --name my-project --description "My awesome project" --public  # For public repo
```

**Manual Setup (Alternative):**
See `QUICK_START.md` for detailed manual setup instructions.

The automated script will:
- Create project directory with all template files
- Set up Python 3.12 virtual environment with UV
- Install all dependencies
- Initialize git repository
- Create GitHub repository
- Set up pre-commit hooks
- Run quality checks

## What's Included

### Configuration Files
- **`pyproject.toml`** - Python project configuration with ruff, mypy, pytest
- **`.gitignore`** - Comprehensive Python gitignore with data file exclusions
- **`.env.example`** - Environment variable template
- **`.pre-commit-config.yaml`** - Pre-commit hooks for code quality
- **`Makefile`** - Development commands and workflows
- **`CLAUDE.md`** - AI assistant guidance and project conventions
- **`.windsurfrules`** - Windsurf IDE optimization and workflow rules

### Project Structure
- **`src/`** - Source code directory
- **`tests/`** - Test directory with basic test template

## Tools & Features

### Development Tools
- **UV** - Fast Python package manager
- **Ruff** - Lightning-fast linter and formatter (replaces black, flake8, isort)
- **mypy** - Static type checking
- **pytest** - Testing framework with coverage
- **pre-commit** - Git hooks for code quality

### Key Features
- Python 3.12 support
- Comprehensive linting rules
- Type checking enforcement
- Test coverage reporting
- Automated code formatting
- Git hooks for quality gates

## Complete Makefile Commands

### Essential Commands
```bash
make help          # Show all available commands
make qa            # Run all quality checks (lint, type-check, test)
make dev-cycle     # Complete development cycle (format, lint, type-check, test)
make fix           # Auto-fix formatting and linting issues
make ci            # Run CI-like checks locally
```

### Environment Setup
```bash
make install       # Install production dependencies only
make dev           # Install all dependencies including dev tools
make setup         # Complete development environment setup (includes pre-commit)
```

### Code Quality
```bash
make lint          # Run ruff linter
make format        # Format code with ruff
make format-check  # Check code formatting without making changes
make type-check    # Run mypy type checking
```

### Testing
```bash
make test          # Run tests with pytest
make test-verbose  # Run tests with verbose output
make coverage      # Run tests with coverage report
```

### Git & Quality Gates
```bash
make pre-commit    # Run pre-commit hooks on all files
```

### Project Management
```bash
make check         # Check project configuration
make lock          # Update UV lock file
make info          # Show environment information
make clean         # Clean up cache files and build artifacts
```

## Customization

### Adding Dependencies
```bash
# Add production dependency
uv add package-name

# Add development dependency
uv add --dev package-name
```

### Project-Specific Updates

1. **pyproject.toml:**
   - Change `name` and `description`
   - Update `known-first-party` in ruff config
   - Add project-specific dependencies

2. **.env.example:**
   - Add application-specific environment variables
   - Update API keys, database URLs, etc.

3. **Ruff configuration:**
   - Adjust rules in `extend-select` and `ignore` as needed
   - Modify line length if different from 88

4. **Test configuration:**
   - Update coverage requirements in pytest config
   - Add project-specific test patterns

## Best Practices Included

- **Code Quality:** Comprehensive linting with ruff
- **Type Safety:** mypy configuration for strict type checking
- **Testing:** pytest with coverage reporting
- **Security:** Pre-commit hooks prevent common issues
- **Documentation:** Environment variable templates
- **Git:** Proper gitignore for Python projects
- **Development:** Make commands for common workflows

## Prerequisites

- **UV** - Install with: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- **Git** - For version control
- **GitHub CLI** (optional) - For repository creation: `gh`
- **Python 3.12** - Will be installed automatically by UV

## Tips

1. **Always run `make qa` before committing**
2. **Use `make dev-cycle` during development**
3. **Update `.env.example` when adding new environment variables**
4. **Keep dependencies minimal and well-organized**
5. **Use type hints consistently**
6. **Write tests for new functionality**

## Troubleshooting

### Common Issues

1. **Pre-commit hooks failing:**
   ```bash
   make fix  # Auto-fix most issues
   ```

2. **Import errors in tests:**
   - Ensure you're using `uv run` prefix
   - Check that packages are installed with `uv sync --dev`

3. **Coverage too low:**
   - Add more tests or adjust `--cov-fail-under` in pyproject.toml

4. **Mypy errors:**
   - Add type hints to functions
   - Use `# type: ignore` for third-party libraries without types