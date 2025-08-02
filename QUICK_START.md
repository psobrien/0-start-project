# Quick Start Guide

## Automated Setup (Recommended)

Use the setup script for fastest project creation:

```bash
# Navigate to your development directory
cd /Users/psobrien/Dev

# Run the setup script
./coverage-ai/startup/setup.sh --name my-new-project --description "My awesome new project"

# For public repository
./coverage-ai/startup/setup.sh --name my-new-project --description "My awesome project" --public
```

That's it! The script will:
- Create project directory
- Copy and customize all template files
- Set up Python 3.12 virtual environment
- Install all dependencies
- Initialize git repository
- Create GitHub repository
- Run quality checks

## Manual Setup

If you prefer manual setup:

1. **Create project directory:**
   ```bash
   mkdir my-new-project
   cd my-new-project
   ```

2. **Copy template files:**
   ```bash
   cp ../coverage-ai/startup/.gitignore .
   cp ../coverage-ai/startup/.pre-commit-config.yaml .
   cp ../coverage-ai/startup/Makefile .
   cp ../coverage-ai/startup/pyproject.toml.template pyproject.toml
   cp "../coverage-ai/startup/.env.example.template" .env.example
   ```

3. **Create directory structure:**
   ```bash
   mkdir -p src tests
   cp ../coverage-ai/startup/src/__init__.py src/
   cp ../coverage-ai/startup/tests/__init__.py tests/
   cp ../coverage-ai/startup/tests/test_basic.py.template tests/test_basic.py
   ```

4. **Customize files:**
   - Edit `pyproject.toml`: Update name, description, known-first-party
   - Edit `.env.example`: Update APP_NAME and add project-specific variables
   - Edit `src/__init__.py` and `tests/__init__.py`: Update project name

5. **Setup environment:**
   ```bash
   uv python install 3.12
   uv venv .venv --python 3.12
   uv sync --dev
   make setup
   ```

6. **Initialize git:**
   ```bash
   git init
   gh repo create PROJECT-NAME --private --source=.
   git add -A
   git commit -m "Initial project setup"
   git push -u origin main
   ```

## What You Get

- ✅ Python 3.12 + UV package management
- ✅ Ruff for linting and formatting
- ✅ mypy for type checking
- ✅ pytest with coverage
- ✅ Pre-commit hooks
- ✅ Comprehensive Makefile
- ✅ Clean project structure
- ✅ GitHub integration
- ✅ CLAUDE.md for AI assistant guidance
- ✅ .windsurfrules for Windsurf IDE optimization

## Essential Commands

```bash
make help          # Show all commands
make dev-cycle     # Format, lint, type-check, test
make qa            # Run all quality checks
make fix           # Auto-fix issues
```

## Prerequisites

- UV: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- GitHub CLI (optional): `brew install gh`