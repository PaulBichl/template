#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}Python Project Template Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Helper function to get input with optional default
get_input() {
    local prompt="$1"
    local default="$2"
    local input

    if [ -n "$default" ]; then
        read -p "$(echo -e ${BLUE}$prompt${NC}) [${default}]: " input
        echo "${input:-$default}"
    else
        read -p "$(echo -e ${BLUE}$prompt${NC}): " input
        echo "$input"
    fi
}

# Get project name (mandatory)
echo -e "${YELLOW}Project Name (required)${NC}"
while true; do
    PROJECT_NAME=$(get_input "Project name (lowercase, no spaces)")
    if [ -z "$PROJECT_NAME" ]; then
        echo -e "${YELLOW}Project name is required. Try again.${NC}"
    else
        # Convert to valid Python package name
        PACKAGE_NAME=$(echo "$PROJECT_NAME" | tr '-' '_')
        echo -e "${GREEN}✓ Project: $PROJECT_NAME${NC}"
        echo -e "${GREEN}✓ Package: $PACKAGE_NAME${NC}"
        break
    fi
done

echo ""

# Get author info
echo -e "${YELLOW}Author Information${NC}"
AUTHOR_NAME=$(get_input "Your name" "User")
AUTHOR_EMAIL=$(get_input "Your email" "user@example.com")
echo -e "${GREEN}✓ Author: $AUTHOR_NAME <$AUTHOR_EMAIL>${NC}"

echo ""

# Get Python version
echo -e "${YELLOW}Python Version${NC}"
PYTHON_VERSION=$(get_input "Python version" "3.12")
if [ -z "$PYTHON_VERSION" ]; then
    echo -e "${YELLOW}⊘ Skipped (will need to update manually)${NC}"
else
    echo -e "${GREEN}✓ Python version: $PYTHON_VERSION${NC}"
fi

echo ""

# Confirm before making changes
echo -e "${YELLOW}Summary:${NC}"
echo "  Project name: $PROJECT_NAME"
echo "  Package name: $PACKAGE_NAME"
echo "  Author: $AUTHOR_NAME <$AUTHOR_EMAIL>"
echo "  Python version: ${PYTHON_VERSION:-3.12}"
echo ""
read -p "$(echo -e ${BLUE}Proceed with setup?${NC}) [y/N]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Setup cancelled."
    exit 1
fi

echo ""
echo -e "${BLUE}Setting up project...${NC}"
echo ""

# 1. Rename package directory
echo -n "Renaming package directory... "
if [ -d "template/src/{{package_src}}" ]; then
    mv "template/src/{{package_src}}" "template/src/$PACKAGE_NAME"
    # Fix the package self-import in __main__.py
    [ -f "template/src/$PACKAGE_NAME/__main__.py" ] && \
        sed -i "s/{{package_src}}/$PACKAGE_NAME/g" "template/src/$PACKAGE_NAME/__main__.py"
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (directory already renamed or missing)${NC}"
fi

# 2. Update template/pyproject.toml
echo -n "Updating template/pyproject.toml... "
if [ -f "template/pyproject.toml" ]; then
    # Create a temporary file for sed operations
    sed_file=$(mktemp)

    # Replace template name with project name
    sed "s/name = \"template\"/name = \"$PROJECT_NAME\"/g" template/pyproject.toml > "$sed_file"

    # Update author name and email (matches any name/email in the authors entry)
    sed -i -E "s/\{ name = \"[^\"]*\", email = \"[^\"]*\" \}/{ name = \"$AUTHOR_NAME\", email = \"$AUTHOR_EMAIL\" }/g" "$sed_file"

    # Update Python version if provided
    if [ -n "$PYTHON_VERSION" ]; then
        sed -i "s/requires-python = \">=3.12\"/requires-python = \">=$PYTHON_VERSION\"/g" "$sed_file"
        sed -i "s/python = \"3.12\"  # Specifies the Python version/python = \"$PYTHON_VERSION\"  # Specifies the Python version/g" "$sed_file"
    fi

    # Update Ruff known-first-party
    sed -i "s/known-first-party = \[\"template\"\]/known-first-party = [\"$PACKAGE_NAME\"]/g" "$sed_file"

    # Point the wheel build target at the renamed package directory
    sed -i "s/{{package_src}}/$PACKAGE_NAME/g" "$sed_file"

    # Apply changes
    mv "$sed_file" template/pyproject.toml
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (template/pyproject.toml not found)${NC}"
fi

# 3. Update template/AGENT.md
echo -n "Updating template/AGENT.md... "
if [ -f "template/AGENT.md" ]; then
    sed -i "s/{{package_src}}/$PACKAGE_NAME/g" "template/AGENT.md"
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (file not found)${NC}"
fi

# 4. Update test files
echo -n "Updating test files... "
if [ -f "template/tests/unit/test_hello_world.py" ]; then
    sed -i "s/{{package_src}}/$PACKAGE_NAME/g" "template/tests/unit/test_hello_world.py"
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (file not found)${NC}"
fi

# 5. Update template/docs/getting-started.rst
echo -n "Updating template/docs/getting-started.rst... "
if [ -f "template/docs/getting-started.rst" ]; then
    sed -i "s/{{package_src}}/$PACKAGE_NAME/g" "template/docs/getting-started.rst"
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (file not found)${NC}"
fi

# 6. Update template/docs/index.rst
echo -n "Updating template/docs/index.rst... "
if [ -f "template/docs/index.rst" ]; then
    sed -i "s/{{Project Name}}/$PROJECT_NAME/g" "template/docs/index.rst"
    sed -i "s/{{package_src}}/$PACKAGE_NAME/g" "template/docs/index.rst"
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (file not found)${NC}"
fi

# 7. Update template/README.md
echo -n "Updating template/README.md... "
if [ -f "template/README.md" ]; then
    sed -i "s/{{Project Name}}/$PROJECT_NAME/g" "template/README.md"
    sed -i "s/{{package_src}}/$PACKAGE_NAME/g" "template/README.md"
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (file not found)${NC}"
fi

# 8. Update template/LICENSE
echo -n "Updating template/LICENSE... "
if [ -f "template/LICENSE" ]; then
    sed -i "s/{{Paul Bichl}}/$AUTHOR_NAME/g" "template/LICENSE"
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (file not found)${NC}"
fi

# 9. Flatten: move the project payload from template/ up to the repo root
echo -n "Flattening project to repository root... "
if [ -d "template" ]; then
    # Move all contents of template/ (including dotfiles) up one level.
    # Files with the same name at the root (README.md, .gitignore) are
    # intentionally overwritten by the project versions from template/.
    shopt -s dotglob
    mv template/* . 2>/dev/null || true
    shopt -u dotglob
    rmdir template 2>/dev/null || true
    echo -e "${GREEN}✓${NC}"
else
    echo -e "${YELLOW}⊘ (already flattened or missing)${NC}"
fi

# 10. Remove template machinery that should not live in a real project
echo -n "Removing template machinery... "
rm -f CLAUDE.md          # template-maintenance instructions (not for projects)
rm -rf .claude           # template-specific local Claude settings
# setup.sh removes itself last (it is already loaded into memory, so this is safe)
echo -e "${GREEN}✓${NC}"

# 11. Reset git history so the project starts clean (no template history)
echo -n "Initializing fresh git repository... "
rm -rf .git
git init -q
echo -e "${GREEN}✓${NC}"

# 12. Create the initial commit
echo -n "Creating initial commit... "
rm -f setup.sh           # delete the bootstrap script itself
git add -A > /dev/null 2>&1
git commit -q -m "Initial commit

- Project: $PROJECT_NAME
- Author: $AUTHOR_NAME <$AUTHOR_EMAIL>
- Python: ${PYTHON_VERSION:-3.12}" > /dev/null 2>&1 \
    && echo -e "${GREEN}✓${NC}" \
    || echo -e "${YELLOW}⊘ (nothing to commit)${NC}"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Setup Complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "Your project is now a clean, flat blank state at the repo root."
echo ""
echo "Next steps:"
echo "  1. Edit README.md with your project description"
echo "  2. Run: hatch env create"
echo "  3. Start coding in: src/$PACKAGE_NAME/"
echo ""
echo "Commands:"
echo "  hatch run type     # Type checking"
echo "  hatch run style    # Code style check"
echo "  hatch run fix      # Auto-fix style"
echo "  hatch run test     # Run tests"
echo ""
