# DevContainer Quick Reference

## 🚀 Getting Started

```bash
# Open in VS Code and select "Reopen in Container"
# Wait for build (5-10 min first time, <30s after)
# Open new terminal - venv auto-activates!
```

## 📦 Package Management

```bash
# Add dependency
poetry add <package>                    # Main dependency
poetry add --group dev <package>        # Dev dependency
poetry add "package>=1.0,<2.0"         # With version constraint

# Remove dependency
poetry remove <package>

# Update dependencies
poetry update                           # All packages
poetry update <package>                 # Specific package

# Install from lock file
poetry install                          # All dependencies
poetry install --with dev               # Include dev group
poetry install --without dev            # Exclude dev group

# Show packages
poetry show                             # All packages
poetry show <package>                   # Specific package info
poetry show --tree                      # Dependency tree
```

## 🐍 Python Environment

```bash
# Check environment
poetry env info                         # Environment details
poetry env list                         # List environments
which python                           # Should be: /workspace/.venv/bin/python
python --version                       # Python version

# Activate manually (usually not needed)
source /workspace/.venv/bin/activate

# Run Python
python script.py
python -m module

# iPython/Jupyter
ipython
jupyter lab
```

## 🛠️ Development Commands

```bash
# Format code
black .
jupyter-black .

# Lint code
ruff check .
ruff check --fix .

# Pre-commit hooks
pre-commit run --all-files

# Build documentation
make render
quarto render

# Run tests (if configured)
pytest
python -m pytest
```

## 📂 Important Paths

| Path                        | Purpose                              |
| --------------------------- | ------------------------------------ |
| `/workspace/.venv`          | Virtual environment (auto-activated) |
| `/workspace/.poetry-cache`  | Poetry cache (speeds up installs)    |
| `/workspace/.devcontainer`  | DevContainer configuration           |
| `/workspace/pyproject.toml` | Project dependencies                 |
| `/workspace/poetry.lock`    | Locked dependency versions           |

## 🔧 VS Code Commands

| Command                                 | Action                |
| --------------------------------------- | --------------------- |
| `Ctrl+Shift+P`                          | Command Palette       |
| `Python: Select Interpreter`            | Choose Python version |
| `Dev Containers: Rebuild Container`     | Rebuild from scratch  |
| `Dev Containers: Reopen in Container`   | Enter container       |
| `Dev Containers: Reopen Folder Locally` | Exit container        |

## 🐛 Troubleshooting

```bash
# Venv not activated?
source /workspace/.venv/bin/activate

# Poetry issues?
poetry lock --no-update
poetry install

# Wrong interpreter in VS Code?
# Ctrl+Shift+P → "Python: Select Interpreter"
# Choose: /workspace/.venv/bin/python

# Container issues?
# Ctrl+Shift+P → "Dev Containers: Rebuild Container"

# Check logs
# View → Output → Select "Dev Containers"
```

## 🌐 Ports

| Port | Service     |
| ---- | ----------- |
| 8888 | JupyterLab  |
| 6006 | TensorBoard |

Access in browser: `http://localhost:<port>`

## 📝 Common Workflows

### Adding OpenAI package

```bash
poetry add openai
# Restart Python/Jupyter kernel
```

### Installing all dependencies

```bash
poetry install --with dev
```

### Updating project dependencies

```bash
poetry update
git add poetry.lock
git commit -m "Update dependencies"
```

### Running Jupyter

```bash
jupyter lab --port=8888
# Access: http://localhost:8888
```

### Building Quarto site

```bash
make render
# Output: _output/index.html
```

## 💡 Tips

- **New terminal = auto-activated venv** ✓
- **Use `poetry add`** not `pip install`
- **Commit `poetry.lock`** to version control
- **`.venv` is ignored** by git (in .gitignore)
- **Cache persists** across container rebuilds

## 📚 Documentation

- [Full DevContainer README](.devcontainer/README.md)
- [Migration Guide](MIGRATION.md)
- [Poetry Docs](https://python-poetry.org/docs/)
- [VS Code DevContainers](https://code.visualstudio.com/docs/devcontainers/containers)
