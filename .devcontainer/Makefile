# DevContainer Makefile
# Common commands for working with the DevContainer setup

.PHONY: help verify poetry-info jupyter clean rebuild

# Default target
help:
	@echo "🐳 DevContainer Commands"
	@echo "========================"
	@echo ""
	@echo "  make verify      - Verify environment setup"
	@echo "  make poetry-info - Show Poetry environment info"
	@echo "  make jupyter     - Start Jupyter Lab"
	@echo "  make add PKG=... - Add package via Poetry"
	@echo "  make clean       - Clean Python cache files"
	@echo "  make rebuild     - Instructions to rebuild container"
	@echo ""

# Verify the environment is properly set up
verify:
	@echo "🔍 Verifying DevContainer Setup..."
	@echo ""
	@echo "1. Python Location:"
	@which python
	@echo ""
	@echo "2. Python Version:"
	@python --version
	@echo ""
	@echo "3. Virtual Environment:"
	@poetry env info
	@echo ""
	@echo "4. Installed Packages:"
	@poetry show | wc -l | xargs echo "   Total packages:"
	@echo ""
	@echo "5. Jupyter Kernels:"
	@jupyter kernelspec list
	@echo ""
	@echo "✅ Verification complete!"

# Show Poetry environment information
poetry-info:
	@echo "📦 Poetry Environment"
	@echo "===================="
	@echo ""
	@poetry env info
	@echo ""
	@echo "Configuration:"
	@poetry config --list
	@echo ""
	@echo "Active packages:"
	@poetry show --tree

# Start Jupyter Lab
jupyter:
	@echo "🪐 Starting Jupyter Lab..."
	@echo "Access at: http://localhost:8888"
	@echo ""
	jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --ServerApp.token='' --ServerApp.password=''

# Add a package with Poetry
add:
	@if [ -z "$(PKG)" ]; then \
		echo "❌ Error: Package name required"; \
		echo "Usage: make add PKG=package-name"; \
		exit 1; \
	fi
	@echo "📦 Adding package: $(PKG)"
	poetry add $(PKG)
	@echo "✅ Package added. Restart kernels to use it."

# Clean Python cache files
clean:
	@echo "🧹 Cleaning Python cache files..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type f -name "*.pyo" -delete 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	@echo "✅ Cache files cleaned"

# Show rebuild instructions (can't rebuild from inside container)
rebuild:
	@echo "🔄 To rebuild the DevContainer:"
	@echo ""
	@echo "Option 1: VS Code Command Palette"
	@echo "  1. Press Ctrl+Shift+P (Cmd+Shift+P on Mac)"
	@echo "  2. Type 'Dev Containers: Rebuild Container'"
	@echo "  3. Press Enter"
	@echo ""
	@echo "Option 2: From outside container"
	@echo "  1. Close VS Code or reopen locally"
	@echo "  2. Delete .venv/ and .poetry-cache/ if needed"
	@echo "  3. Reopen in container"
	@echo ""
	@echo "⚠️  This command cannot rebuild from inside the container"
