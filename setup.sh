#!/bin/bash

# Python Project Setup Script
# This script automates the setup of a new Python project using the startup template

set -e  # Exit on any error

PROJECT_NAME=""
PROJECT_DESCRIPTION=""
GITHUB_PRIVATE="true"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -n, --name NAME          Project name (required)"
    echo "  -d, --description DESC   Project description (required)"
    echo "  -p, --public            Create public GitHub repository (default: private)"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --name my-awesome-project --description 'An awesome Python project'"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            PROJECT_NAME="$2"
            shift 2
            ;;
        -d|--description)
            PROJECT_DESCRIPTION="$2"
            shift 2
            ;;
        -p|--public)
            GITHUB_PRIVATE="false"
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Validate required arguments
if [[ -z "$PROJECT_NAME" ]]; then
    print_error "Project name is required. Use -n or --name option."
    show_help
    exit 1
fi

if [[ -z "$PROJECT_DESCRIPTION" ]]; then
    print_error "Project description is required. Use -d or --description option."
    show_help
    exit 1
fi

# Validate project name format
if [[ ! "$PROJECT_NAME" =~ ^[a-z0-9_-]+$ ]]; then
    print_error "Project name must contain only lowercase letters, numbers, hyphens, and underscores."
    exit 1
fi

# Create project directory
PROJECT_DIR="../$PROJECT_NAME"
if [[ -d "$PROJECT_DIR" ]]; then
    print_error "Directory $PROJECT_DIR already exists."
    exit 1
fi

print_status "Creating project directory: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

# Copy template files
print_status "Copying template files..."
STARTUP_DIR="../coverage-ai/startup"
cp "$STARTUP_DIR/.gitignore" .
cp "$STARTUP_DIR/.pre-commit-config.yaml" .
cp "$STARTUP_DIR/Makefile" .

# Process templates with substitutions
print_status "Processing templates..."

# pyproject.toml
sed -e "s/PROJECT-NAME/$PROJECT_NAME/g" \
    -e "s/PROJECT DESCRIPTION/$PROJECT_DESCRIPTION/g" \
    -e "s/PROJECT_PACKAGE/${PROJECT_NAME//-/_}/g" \
    "$STARTUP_DIR/pyproject.toml.template" > pyproject.toml

# .env.example
sed "s/PROJECT-NAME/$PROJECT_NAME/g" \
    "$STARTUP_DIR/.env.example.template" > .env.example

# Create directory structure
print_status "Creating directory structure..."
mkdir -p src tests

# Process source files
sed "s/PROJECT-NAME - PROJECT DESCRIPTION/$PROJECT_NAME - $PROJECT_DESCRIPTION/g" \
    "$STARTUP_DIR/src/__init__.py.template" > src/__init__.py

sed "s/PROJECT-NAME/$PROJECT_NAME/g" \
    "$STARTUP_DIR/tests/__init__.py.template" > tests/__init__.py

sed "s/PROJECT-NAME/$PROJECT_NAME/g" \
    "$STARTUP_DIR/tests/test_basic.py.template" > tests/test_basic.py

# Process development configuration files
print_status "Processing development configuration templates..."

# CLAUDE.md
sed -e "s/PROJECT-NAME/$PROJECT_NAME/g" \
    -e "s/PROJECT DESCRIPTION/$PROJECT_DESCRIPTION/g" \
    "$STARTUP_DIR/CLAUDE.md.template" > CLAUDE.md

# .windsurfrules
sed -e "s/PROJECT-NAME/$PROJECT_NAME/g" \
    -e "s/PROJECT DESCRIPTION/$PROJECT_DESCRIPTION/g" \
    "$STARTUP_DIR/.windsurfrules.template" > .windsurfrules

# Check for UV installation
if ! command -v uv &> /dev/null; then
    print_error "UV is not installed. Please install it first:"
    echo "curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 1
fi

# Setup Python environment
print_status "Installing Python 3.12..."
uv python install 3.12

print_status "Creating virtual environment..."
uv venv .venv --python 3.12

print_status "Installing dependencies..."
uv sync --dev

print_status "Setting up pre-commit hooks..."
uv run pre-commit install

# Initialize git repository
print_status "Initializing git repository..."
git init
git add -A

# Create initial commit
print_status "Creating initial commit..."
git commit -m "Initial setup of $PROJECT_NAME

- Python 3.12 with UV package management
- Comprehensive ruff configuration (linting + formatting)  
- mypy for type checking
- pytest with coverage reporting
- pre-commit hooks for code quality
- Makefile with development commands
- Clean project structure with src/ and tests/"

# Create GitHub repository if gh CLI is available
if command -v gh &> /dev/null; then
    print_status "Creating GitHub repository..."
    if [[ "$GITHUB_PRIVATE" == "true" ]]; then
        gh repo create "$PROJECT_NAME" --private --description "$PROJECT_DESCRIPTION" --source=.
    else
        gh repo create "$PROJECT_NAME" --public --description "$PROJECT_DESCRIPTION" --source=.
    fi
    
    print_status "Pushing to GitHub..."
    git push -u origin main
    
    print_success "GitHub repository created: https://github.com/$(gh api user --jq .login)/$PROJECT_NAME"
else
    print_warning "GitHub CLI not found. Skipping repository creation."
    print_status "You can create the repository manually and then run:"
    echo "  git remote add origin https://github.com/YOUR_USERNAME/$PROJECT_NAME.git"
    echo "  git push -u origin main"
fi

# Run quality checks
print_status "Running quality checks..."
if make qa; then
    print_success "All quality checks passed!"
else
    print_warning "Some quality checks failed. You may need to fix issues before committing."
fi

# Final success message
print_success "Project $PROJECT_NAME has been successfully created!"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  make help                    # See available commands"
echo "  make dev-cycle               # Run development cycle"
echo ""
echo "Project location: $(pwd)"
if command -v gh &> /dev/null; then
    echo "GitHub repository: https://github.com/$(gh api user --jq .login)/$PROJECT_NAME"
fi