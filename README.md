# Python Project Template

A minimal Python template with Hatch, type checking, linting, and testing—all configured and ready to use.

## ⚡ Quick Start

```bash
# Clone the template
git clone <template-repo> my-project
cd my-project

# Run setup script
./setup.sh
```

**After setup:**

```bash
cd template
hatch env create
# Edit README.md with your project description
# Start coding in src/my_package/
```

> All `hatch` commands below are run from inside the `template/` directory, where `pyproject.toml` lives.

## Manual Setup (if you prefer)

1. Edit `template/pyproject.toml` — change `name`, `version`, `authors`
2. Rename `template/src/{{package_src}}/` to your package name 
3. Replace imports in test files 
4. Update `template/README.md` with your project details 
5. Run `hatch env create` 

## Development Commands

| Command | Purpose |
|---------|---------|
| `hatch run type` | Type checking (Mypy) |
| `hatch run style` | Lint check (Ruff) |
| `hatch run fix` | Auto-fix + pre-commit |
| `hatch run test` | Run tests (Pytest) |

## Code Quality

Code follows **PEP 8** via Ruff. Before committing:

```bash
hatch run type
hatch run style
hatch run fix 
hatch run test
```

Pre-commit hooks run automatically on `git commit`.

## Project Structure

```
template/
├── src/my_package/          # Your package code
├── tests/                   # Add your tests here
├── docs/                    # Documentation (RST)
├── .github/                 # AI helper instructions
├── pyproject.toml           # All configs
├── CONTRIBUTING.md          # Dev guidelines
└── README.md                # Project README
```

## Documentation

- **template/docs/** — Sphinx-compatible documentation (optional to build)
- **template/README.md** — Your project README
- **.github/copilot-instructions.md** — Code patterns for AI helpers

To build docs locally:

```bash
pip install sphinx
cd template/docs
make html
```

## Troubleshooting

**"Module not found"**
```bash
hatch env create
```

**Type checking errors**
```bash
hatch run type --install-types
```

**Pre-commit hooks fail**
```bash
hatch run fix --all-files
```

**Tests don't find module**
```bash
hatch env create  # Installs in editable mode
```

## Configuration

All tool configs are in `pyproject.toml`:

- **Ruff** — Linting and formatting
- **Mypy** — Type checking
- **Pytest** — Testing
- **Hatch** — Environment and scripts

No separate config files needed.

---

**Next:** Clone, run `./setup.sh`, and start coding! 
