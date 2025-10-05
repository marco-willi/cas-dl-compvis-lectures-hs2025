# DevContainer Setup

This project uses **VS Code DevContainers** for a consistent development environment with proper Poetry integration.

## 🎯 Features

- ✅ **Automatic Poetry virtual environment** at `/workspace/.venv`
- ✅ **Auto-activation** in all new terminals
- ✅ **Poetry fully integrated** - add packages with `poetry add <package>`
- ✅ **VS Code Python/Jupyter extensions** pre-configured
- ✅ **Quarto** for rendering documentation
- ✅ **Non-root user** (`jovyan`) for security

## 🚀 Quick Start

### First Time Setup

1. **Install Requirements:**

   - [VS Code](https://code.visualstudio.com/)
   - [Docker Desktop](https://www.docker.com/products/docker-desktop/)
   - [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Open in Container:**

   - Open this folder in VS Code
   - Click "Reopen in Container" when prompted
   - Or: `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"

3. **Wait for Setup:**

   - First build takes 5-10 minutes (downloads base image, installs dependencies)
   - Subsequent starts are \<30 seconds
   - Watch progress in the terminal

### After Container Starts

Open a new terminal - **the virtual environment is automatically activated**:

```bash
# Check environment
poetry env info

# Install new package
poetry add openai

# Update dependencies
poetry install

# Run Jupyter
make jupyter  # or jupyter lab

# Build documentation
make render
```

## 📁 Directory Structure

```
/workspace/
├── .venv/              # Poetry virtual environment (auto-activated)
├── .poetry-cache/      # Poetry cache (speeds up installs)
├── .devcontainer/      # DevContainer configuration
│   ├── devcontainer.json
│   ├── Dockerfile
│   ├── post-create.sh
│   └── post-start.sh
├── pyproject.toml      # Poetry dependencies
└── poetry.lock         # Locked versions
```

## 🔧 Configuration Details

### Virtual Environment

- **Location:** `/workspace/.venv`
- **Auto-activation:** Configured in `~/.bashrc`
- **Poetry config:**
  ```bash
  poetry config virtualenvs.in-project true
  poetry config virtualenvs.create true
  ```

### Python Interpreter

VS Code is pre-configured to use:

```json
"python.defaultInterpreterPath": "/workspace/.venv/bin/python"
```

### Lifecycle Scripts

1. **post-create.sh** (runs once after container creation):

   - Creates/validates `.venv`
   - Installs dependencies via `poetry install`
   - Sets up Jupyter kernel
   - Installs pre-commit hooks

2. **post-start.sh** (runs every container start):

   - Activates virtual environment
   - Shows current Python version
   - Displays helpful commands

## 📦 Managing Dependencies

### Add a package

```bash
poetry add <package>              # Add to main dependencies
poetry add --group dev <package>  # Add to dev dependencies
```

### Update packages

```bash
poetry update                     # Update all packages
poetry update <package>           # Update specific package
```

### Remove a package

```bash
poetry remove <package>
```

### Install from lock file

```bash
poetry install                    # Install all
poetry install --with dev         # Include dev dependencies
poetry install --without dev      # Exclude dev dependencies
```

## 🐛 Troubleshooting

### Virtual environment not activated

Open a new terminal or run:

```bash
source /workspace/.venv/bin/activate
```

### Poetry can't find the environment

Check configuration:

```bash
poetry env info
poetry config --list
```

Reset if needed:

```bash
poetry env use /workspace/.venv/bin/python
```

### Rebuild container from scratch

1. `Ctrl+Shift+P` → "Dev Containers: Rebuild Container"
2. Or delete `.venv/` and rebuild

### Package installation fails

Check Poetry lock file:

```bash
poetry lock --no-update
poetry install
```

## 🆚 vs Original Dockerfile

**Old setup:**

- Virtual environment at `/opt/venv` (non-standard)
- Manual activation required
- Poetry not in PATH for regular use

**New setup:**

- Virtual environment at `/workspace/.venv` (Poetry standard)
- Auto-activation in all terminals
- Poetry fully integrated and ready to use
- Persistent across container restarts

## 📚 Resources

- [VS Code DevContainers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Poetry Documentation](https://python-poetry.org/docs/)
- [DevContainer Specification](https://containers.dev/)

## ⚙️ Advanced

### Custom build arguments

Edit `.devcontainer/devcontainer.json`:

```json
"args": {
  "WITH_GROUPS": "dev,ray,nbgrader"
}
```

### Port forwarding

Default ports:

- `8888` - JupyterLab
- `6006` - TensorBoard

Add more in `devcontainer.json`:

```json
"forwardPorts": [8888, 6006, 8000]
```

### VS Code extensions

Add extensions in `devcontainer.json`:

```json
"extensions": [
  "ms-python.python",
  "your-extension-id"
]
```
