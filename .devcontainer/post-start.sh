#!/bin/bash
# Post-start command: Runs every time the container starts

set -e

echo "🔄 Running post-start tasks..."

# Ensure virtual environment is activated
if [ -f "/workspace/.venv/bin/activate" ]; then
    # shellcheck disable=SC1091
    source /workspace/.venv/bin/activate
    echo "✓ Virtual environment activated"
fi

# Check for updates to dependencies (optional)
# Uncomment if you want to auto-update on container start
# echo "Checking for dependency updates..."
# poetry update --dry-run

# Display current Python environment
echo ""
echo "🐍 Current Python: $(which python)"
echo "   Version: $(python --version)"
echo ""

# Check if openai package is installed (for the notebook)
if python -c "import openai" 2>/dev/null; then
    echo "✓ OpenAI package available"
else
    echo "⚠ OpenAI package not found - run: poetry add openai"
fi

echo ""
echo "✅ Container ready!"
echo ""
echo "Useful commands:"
echo "  • poetry add <package>    - Add a new dependency"
echo "  • poetry install          - Reinstall all dependencies"
echo "  • poetry show             - List installed packages"
echo "  • poetry env info         - Show environment details"
echo "  • make render             - Build Quarto site"
