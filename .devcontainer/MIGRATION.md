# Migration to DevContainer Setup

## ✅ What Changed

### Before (Old Dockerfile)

- Virtual environment at `/opt/venv` (non-standard location)
- Poetry installed but not integrated
- Manual activation required: `source /opt/venv/bin/activate`
- JupyterLab auto-starts on container launch
- Poetry `virtualenvs.create false` (confusing for users)

### After (DevContainer)

- Virtual environment at `/workspace/.venv` (Poetry standard location)
- **Auto-activation** in all terminals
- Poetry fully integrated - just use `poetry add <package>`
- No auto-start (use `jupyter lab` when needed)
- Proper Poetry configuration with `virtualenvs.in-project true`

## 🚀 Migration Steps

### 1. Rebuild Container

If you're already using this project:

**Option A: In VS Code**

1. `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
2. Type "Dev Containers: Rebuild Container"
3. Select it and wait for rebuild

**Option B: Clean Start**

```bash
# Stop any running containers
docker stop $(docker ps -q --filter ancestor=<image-name>)

# Remove old volumes (optional, if you want fresh start)
docker volume prune

# Reopen in VS Code - it will rebuild automatically
```

### 2. Verify Setup

Open a new terminal in VS Code and run:

```bash
# Should show: /workspace/.venv/bin/python
which python

# Should show the virtual environment details
poetry env info

# Should show your installed packages
poetry show

# Test adding a package
poetry add --dry-run httpx
```

### 3. Update Your Workflow

**Old workflow:**

```bash
source /opt/venv/bin/activate  # Manual activation needed
pip install package             # Direct pip usage
```

**New workflow:**

```bash
# No activation needed! Just open terminal and:
poetry add package              # Use Poetry for package management
poetry install                  # Sync dependencies
```

## 📋 Checklist

- [ ] Container rebuilds successfully
- [ ] New terminal auto-activates `.venv`
- [ ] `which python` shows `/workspace/.venv/bin/python`
- [ ] `poetry env info` shows correct environment
- [ ] `poetry add openai` works without errors
- [ ] Jupyter kernel shows "Python (CAS DL CV)"
- [ ] Can run notebooks with new packages

## 🐛 Common Issues

### Issue: Poetry command not found

**Solution:**

```bash
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/root/.local/bin:$PATH"
```

### Issue: Virtual environment not activated

**Solution:**

```bash
# Manual activation
source /workspace/.venv/bin/activate

# Or check .bashrc
cat ~/.bashrc | grep -A 5 "Poetry virtual"
```

### Issue: "Could not parse version constraint: <empty>"

**Solution:**
This was from the old setup. Should not happen with DevContainer.

```bash
# Check poetry.lock is valid
poetry lock --check

# If needed, regenerate
poetry lock --no-update
```

### Issue: Packages from old venv missing

**Solution:**

```bash
# Reinstall all dependencies
poetry install --with dev

# Or specific group
poetry install --with ray
```

### Issue: VS Code using wrong Python interpreter

**Solution:**

1. `Ctrl+Shift+P` → "Python: Select Interpreter"
2. Choose `/workspace/.venv/bin/python`
3. Or restart VS Code

## 🎯 Benefits

✅ **Faster development**: No manual activation, Poetry just works
✅ **Consistency**: Everyone uses the same environment
✅ **Easier package management**: `poetry add` instead of `pip install`
✅ **Better IDE integration**: VS Code knows about the venv automatically
✅ **Persistent state**: `.venv` survives container rebuilds
✅ **Standard practices**: Follows Poetry's recommended setup

## 📚 Further Reading

- [DevContainer README](.devcontainer/README.md) - Full documentation
- [Poetry Docs](https://python-poetry.org/docs/) - Package management
- [VS Code DevContainers](https://code.visualstudio.com/docs/devcontainers/containers) - Container development

## 🆘 Getting Help

If you encounter issues:

1. Check [DevContainer README](.devcontainer/README.md) troubleshooting section
2. Try rebuilding container: `Ctrl+Shift+P` → "Rebuild Container"
3. Check container logs: View → Output → Select "Dev Containers"
4. Open an issue with error logs
