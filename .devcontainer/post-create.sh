#!/bin/bash
# Post-create command: Runs once after container is created

set -e

echo "🚀 Running post-create setup..."

# Ensure we're in the workspace
cd /workspace

# Check if .venv exists and is valid
if [ -d "/opt/venv" ] && [ -f "/opt/venv/bin/python" ]; then
    echo "✓ Virtual environment exists at /opt/venv"

    # Verify it's the right Python version
    VENV_PYTHON_VERSION=$(/opt/venv/bin/python --version)
    echo "  Python version: $VENV_PYTHON_VERSION"

    # Quick package check
    echo "  Checking for key packages..."
    /opt/venv/bin/python -c "import torch; print(f'  ✓ torch {torch.__version__}')" 2>/dev/null || echo "  ✗ torch not found"
    /opt/venv/bin/python -c "import openai; print(f'  ✓ openai installed')" 2>/dev/null || echo "  ✗ openai not found"
else
    echo "⚠ Virtual environment not found or invalid, creating new one..."

    # Create virtual environment
    python -m venv /opt/venv

    # Activate it
    # shellcheck disable=SC1091
    source /opt/venv/bin/activate

    # Upgrade pip
    pip install --upgrade pip setuptools wheel

    # Install dependencies via Poetry
    poetry install --no-interaction --with dev

    echo "✓ Virtual environment created and dependencies installed"
fi

# Activate the virtual environment for verification
# shellcheck disable=SC1091
source /opt/venv/bin/activate

# Verify Poetry can see the environment
echo ""
echo "📦 Poetry environment info:"
poetry env info

# Show installed packages count
PACKAGE_COUNT=$(pip list --format=freeze | wc -l)
echo ""
echo "✓ Installed packages: $PACKAGE_COUNT"

# Setup Jupyter kernel
echo ""
echo "🪐 Setting up Jupyter kernel..."
python -m ipykernel install --user --name=cas-dl-cv --display-name="Python (CAS DL CV)"
echo "✓ Jupyter kernel installed"

# Install pre-commit hooks if .pre-commit-config.yaml exists
if [ -f ".pre-commit-config.yaml" ]; then
    echo ""
    echo "🪝 Installing pre-commit hooks..."
    pre-commit install || echo "⚠ Failed to install pre-commit hooks (continuing anyway)"
fi

echo ""
echo "✅ Post-create setup complete!"
echo ""
echo "Virtual environment: /opt/venv"
echo "Poetry cache: /home/jovyan/.poetry-cache"
echo ""
echo "To activate manually: source /opt/venv/bin/activate"
echo "Or just open a new terminal (auto-activates)"
