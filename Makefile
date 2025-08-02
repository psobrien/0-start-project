.PHONY: help install dev lint format type-check test coverage clean pre-commit setup

# Default target
help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Environment setup
install: ## Install production dependencies
	uv sync --no-dev

dev: ## Install all dependencies including dev tools
	uv sync --dev

setup: dev ## Complete development environment setup
	uv run pre-commit install
	@echo "✅ Development environment ready!"

# Code quality
lint: ## Run ruff linter
	uv run ruff check .

format: ## Format code with ruff
	uv run ruff format .

format-check: ## Check code formatting without making changes
	uv run ruff format --check .

type-check: ## Run mypy type checking
	uv run python -m mypy src/

# Testing
test: ## Run tests with pytest
	uv run python -m pytest

test-verbose: ## Run tests with verbose output
	uv run python -m pytest -v

coverage: ## Run tests with coverage report
	uv run python -m pytest --cov=src --cov-report=term-missing --cov-report=html

# Pre-commit
pre-commit: ## Run pre-commit hooks on all files
	uv run pre-commit run --all-files

# Quality assurance (run all checks)
qa: lint type-check test ## Run all quality assurance checks

# Cleanup
clean: ## Clean up cache files and build artifacts
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".mypy_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	rm -rf htmlcov/
	rm -f .coverage

# Project management
check: ## Check project configuration
	uv check

lock: ## Update lock file
	uv lock

# Development workflow shortcuts
fix: format lint ## Auto-fix code formatting and linting issues

ci: qa ## Run CI-like checks locally

# Python environment info
info: ## Show environment information
	@echo "Python version:"
	@uv run python --version
	@echo "\nInstalled packages:"
	@uv tree

# Quick development cycle
dev-cycle: format lint type-check test ## Complete development cycle: format, lint, type-check, test