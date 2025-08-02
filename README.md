# Python Project Startup Template

This folder contains reusable configuration files and scripts to quickly set up new Python projects with best practices.

## Quick Setup

1. **Copy template files to your new project:**
   ```bash
   cp startup/* /path/to/new-project/
   ```

2. **Customize project-specific values:**
   - Update `pyproject.toml`: name, description, dependencies
   - Update `.env.example`: application-specific variables
   - Update README template with your project details

3. **Initialize environment:**
   ```bash
   # Install Python 3.12 if needed
   uv python install 3.12
   
   # Create virtual environment
   uv venv .venv --python 3.12
   
   # Install dependencies
   uv sync --dev
   
   # Setup development tools
   make setup
   ```

4. **Initialize git repository:**
   ```bash
   git init
   gh repo create PROJECT-NAME --private --source=.
   git add -A
   git commit -m "Initial project setup"
   git push -u origin main
   ```

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

## Common Makefile Commands

```bash
make help          # Show all available commands
make dev           # Install all dependencies
make setup         # Complete development environment setup
make qa            # Run all quality checks (lint, type-check, test)
make dev-cycle     # Format, lint, type-check, test
make fix           # Auto-fix formatting and linting issues
make test          # Run tests
make coverage      # Run tests with coverage report
make clean         # Clean up cache files
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