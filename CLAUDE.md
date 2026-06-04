# Claude Instructions for Template Maintenance

This is a minimal Python project template for personal projects.

## What This Is

- **Purpose**: Starter template for Python 3.12+ projects using Hatch
- **Scope**: Lean, no examples, just the essentials
- **Users**: Developers who clone/fork and build their own projects

## Repo Layout

The repo separates **machinery** (outer) from the **project payload** (nested `template/`):

```
<repo root>                 # template machinery — removed on setup
├── CLAUDE.md               # this file (template maintenance)
├── README.md               # describes the template
├── setup.sh                # bootstrap script (flattens + cleans + git init)
├── .gitignore              # template housekeeping
└── template/               # PAYLOAD — becomes the user's project
    ├── src/{{package_src}}/    # User's package
    │   ├── __init__.py
    │   └── main.py         # Minimal entry point
    ├── tests/              # Empty - user adds tests
    ├── docs/               # Getting started guide only
    ├── AGENT.md            # Instructions for AI assistants
    ├── pyproject.toml      # All tool configs
    ├── CONTRIBUTING.md     # Brief dev workflow
    ├── .gitignore          # Python .gitignore
    ├── .pre-commit-config.yaml
    ├── LICENSE
    └── README.md           # Project README
```

## What `setup.sh` Does

After collecting project name / author / Python version it:

1. Renames `src/{{package_src}}/` and replaces `{{...}}` placeholders
2. **Flattens** the `template/` payload up to the repo root
3. **Removes machinery**: `CLAUDE.md`, `setup.sh`, `.claude/`, and the outer README/.gitignore (the payload versions take their place)
4. **Resets git**: drops template history and creates one fresh `Initial commit`

The result is a clean, flat blank project — not a clone with placeholders swapped in.

## Customization Checklist for Users

1. Run `./setup.sh` (does all of the below automatically), or manually:
2. Edit `template/pyproject.toml`: change `name`, `version`, author
3. Rename `template/src/{{package_src}}/` to actual package name
4. Edit `template/README.md` with project details
5. Flatten `template/` to the root and delete the machinery files
6. Run `hatch env create && hatch run test`
7. Start building

## Key Files

**pyproject.toml** - Contains: project metadata, Ruff, Mypy, Hatch, Pytest configs

**main.py** - Minimal entry point (users replace with their code)

**AGENT.md** - Code patterns and instructions for AI assistants (Claude, Copilot)

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
