# Claude Instructions for Template Maintenance

This is a minimal Python project template for personal projects.

## What This Is

- **Purpose**: Starter template for Python 3.12+ projects using Hatch
- **Scope**: Lean, no examples, just the essentials
- **Users**: Developers who clone/fork and build their own projects

## Template Structure

```
template/               # What gets cloned/forked
├── src/{{package_src}}/    # User's package
│   ├── __init__.py
│   └── main.py         # Minimal entry point
├── tests/              # Empty - user adds tests
├── docs/               # Getting started guide only
├── .github/
│   ├── CLAUDE.md       # Instructions for this repo
│   └── copilot-instructions.md
├── pyproject.toml      # All tool configs
├── CONTRIBUTING.md     # Brief dev workflow
└── README.md           # Project template
```

## Customization Checklist for Users

1. Edit `pyproject.toml`: change `name`, `version`, author
2. Rename `src/{{package_src}}/` to actual package name
3. Edit `template/README.md` with project details
4. Run `hatch env create && hatch run test`
5. Start building

## Key Files

**pyproject.toml** - Contains: project metadata, Ruff, Mypy, Hatch, Pytest configs

**main.py** - Minimal entry point (users replace with their code)

**.github/copilot-instructions.md** - Code patterns for AI assistants

**copilot-instructions.md** - Patterns: imports, type hints, classes, testing

## Maintenance

When updating:

1. Keep structure minimal (no examples)
2. Ensure `hatch run type`, `hatch run style`, `hatch run test` work
3. Update docs when changing structure
4. Test: `hatch env create` and commands work

## Before Committing

```bash
hatch run type
hatch run style
hatch run fix --all-files
hatch run test
```

---

**Philosophy**: No bloat, no examples, just a working starting point.
