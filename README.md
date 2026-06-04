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

`setup.sh` flattens the project payload up to the repo root, removes the
template machinery (this README, `CLAUDE.md`, `setup.sh`), and starts a
fresh git history — leaving a clean blank project to build on.

**After setup:**

```bash
hatch env create
# Edit README.md with your project description
# Start coding in src/my_package/
```

> All `hatch` commands run from the repo root, where `pyproject.toml` lives.
> `hatch env create` builds the environment in `./.hatch` (in-project and gitignored).

## Manual Setup (if you prefer)

The project lives in the nested `template/` directory. To set it up by hand:

1. Edit `template/pyproject.toml` — change `name`, `version`, `authors`
2. Rename `template/src/{{package_src}}/` to your package name
3. Replace imports in test files
4. Move the contents of `template/` up to the repo root
5. Delete `CLAUDE.md`, `setup.sh`, and this README
6. Run `hatch env create`

## Development Commands

| Command | Purpose |
|---------|---------|
| `hatch env create` | Create the dev environment (in `./.hatch`) |
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

## Project Structure (after setup)

```
my-project/
├── src/my_package/          # Your package code
├── tests/                   # Add your tests here
├── docs/                    # Documentation (RST)
├── AGENT.md                 # Instructions for AI assistants
├── pyproject.toml           # All configs
├── CONTRIBUTING.md          # Dev guidelines
└── README.md                # Project README
```

## Documentation

- **docs/** — Sphinx-compatible documentation (optional to build)
- **README.md** — Your project README
- **AGENT.md** — Code patterns for AI assistants

To build docs locally:

```bash
pip install sphinx
cd docs
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
