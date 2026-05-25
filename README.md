# Python Project Template

A minimal, production-ready Python template for personal projects. Includes modern tooling (Hatch, Ruff, Mypy, Pytest) configured and ready to use.

## What You Get

- ✅ Working Hatch environment with uv package manager
- ✅ Type checking (Mypy) and linting (Ruff)
- ✅ Pre-commit hooks for code quality
- ✅ Pytest setup for testing
- ✅ AI assistant instructions (Claude/Copilot)
- ✅ All configs in `pyproject.toml` (no scattered files)

## Step 1: Clone and Prepare

```bash
# Clone the template
git clone <template-repo> my-project
cd my-project

# Remove template git history (optional, clean slate)
rm -rf .git
git init
git add .
git commit -m "Initial commit from template"
```

## Step 2: Customize Project Metadata

Edit `pyproject.toml` and update these fields:

```toml
[project]
name = "my-awesome-project"      # Change from "template"
version = "0.1.0"                 # Your starting version
description = "What your project does"
authors = [
    { name = "Your Name", email = "you@example.com" },
]
```

Also update the `known-first-party` in Ruff config:

```toml
[tool.ruff.lint.isort]
known-first-party = ["my_awesome_project"]  # Use your package name
```

## Step 3: Rename Your Package

The template uses `{{package_src}}` as a placeholder. Rename it to your actual package name:

```bash
# Rename the directory
mv template/src/{{package_src}} template/src/my_awesome_project

# Update imports in any test files (if you add them)
# Change: from {{package_src}}.main import main
# To:     from my_awesome_project.main import main
```

## Step 4: Update Project README

Edit `template/README.md` with your project details:

```markdown
# My Awesome Project

Brief description of what it does.

## Installation

```bash
pip install -e .
```

## Usage

Examples of how to use your project.

## Development

See [CONTRIBUTING.md](./CONTRIBUTING.md) for dev workflow.
```

## Step 5: Set Up Development Environment

```bash
# Create the development environment
hatch env create

# Install pre-commit hooks
hatch run fix install

# Verify everything works
hatch run type
hatch run style
hatch run test
```

## Step 6: Start Developing

Replace `template/src/my_awesome_project/main.py` with your code:

```python
from __future__ import annotations


def main() -> None:
    """Main entry point for the application."""
    print("Hello from my-awesome-project!")


if __name__ == "__main__":
    main()
```

Add modules in `template/src/my_awesome_project/`:

```python
# template/src/my_awesome_project/utils.py
from __future__ import annotations


def helper_function(data: list[str]) -> int:
    """Count total characters in list of strings."""
    return sum(len(item) for item in data)
```

## Step 7: Write Tests

Create test files in `template/tests/`:

```python
# template/tests/test_utils.py
from __future__ import annotations

from my_awesome_project.utils import helper_function


def test_helper_function() -> None:
    """Test the helper function."""
    result = helper_function(["hello", "world"])
    assert result == 10
```

Run tests:

```bash
hatch run test
hatch run test --cov=src  # With coverage
```

## Development Workflow

### Code Quality Commands

| Command | Purpose |
|---------|---------|
| `hatch run type` | Check types with Mypy |
| `hatch run style` | Check code style with Ruff |
| `hatch run fix` | Auto-fix style + run pre-commit hooks |
| `hatch run test` | Run all tests with Pytest |
| `hatch run test -k test_name` | Run specific test |

### Before Committing

```bash
# Always run these before committing
hatch run type
hatch run style
hatch run fix --all-files
hatch run test
```

Pre-commit hooks will also run automatically (configured in `.pre-commit-config.yaml`).

### Code Style (PEP 8)

Your code will be checked against PEP 8 via Ruff. Common patterns:

**Imports** (always start with):
```python
from __future__ import annotations
```

**Type hints** (everywhere):
```python
def process(items: list[str]) -> dict[str, int]:
    """Process items and return mapping."""
    return {item: len(item) for item in items}
```

**Classes**:
```python
class DataProcessor:
    """Process data efficiently."""

    def __init__(self, name: str) -> None:
        """Initialize processor."""
        self.name = name

    def process(self, data: list[str]) -> dict[str, int]:
        """Process data."""
        return {item: len(item) for item in data}
```

**Error handling**:
```python
def load_config(path: str) -> dict:
    """Load configuration file."""
    if not os.path.exists(path):
        raise FileNotFoundError(f"Config not found: {path}")
    
    try:
        with open(path) as f:
            return json.load(f)
    except json.JSONDecodeError as e:
        raise ValueError(f"Invalid JSON: {e}") from e
```

## Documentation

The template includes two documentation files:

**`template/docs/index.rst`** — Main documentation page (edit with your content)

**`template/docs/getting-started.rst`** — Getting started guide

To build documentation locally (requires Sphinx):

```bash
pip install sphinx
cd template/docs
make html
# Open _build/html/index.html in browser
```

## Troubleshooting

**"Module not found" when running code**
```bash
# Make sure environment is created
hatch env create
```

**Type checking errors**
```bash
# Install missing type stubs
hatch run type --install-types
```

**Pre-commit hooks fail**
```bash
# Auto-fix all issues
hatch run fix --all-files
```

**Tests don't find my module**
```bash
# Make sure package is installed in editable mode
hatch env create  # This installs in editable mode
```

## Project Structure Reference

```
my-project/
├── template/
│   ├── src/my_awesome_project/    # Your package code
│   │   ├── __init__.py
│   │   ├── main.py
│   │   └── utils.py               # Add your modules
│   ├── tests/                     # Your tests
│   │   └── test_utils.py
│   ├── docs/                      # Documentation
│   ├── .github/                   # AI helper instructions
│   ├── CONTRIBUTING.md            # Development guide
│   └── README.md                  # Project README
├── pyproject.toml                 # All tool configs
├── .pre-commit-config.yaml        # Pre-commit hooks
├── .gitignore
└── README.md                      # This file
```

## Next Steps

1. ✅ Clone template
2. ✅ Edit `pyproject.toml`
3. ✅ Rename package directory
4. ✅ Run `hatch env create`
5. ✅ Start coding in `src/my_awesome_project/`
6. ✅ Add tests in `tests/`
7. ✅ Run `hatch run test` before committing

## Configuration Reference

All tool configurations are in `pyproject.toml`:

- **Ruff** (linting/formatting) — `[tool.ruff]`
- **Mypy** (type checking) — `[tool.mypy]`
- **Pytest** (testing) — `[tool.pytest.ini_options]`
- **Coverage** (test coverage) — `[tool.coverage.run]`
- **Hatch** (environment/scripts) — `[tool.hatch.*]`

No need to create separate config files or directories.

## Tips

💡 Keep functions small and focused  
💡 Use descriptive variable names  
💡 Write tests as you code  
💡 Run `hatch run fix` regularly  
💡 Use type hints everywhere  
💡 Read existing code for patterns  

---

**Questions?** Check `template/CONTRIBUTING.md` for development details.
