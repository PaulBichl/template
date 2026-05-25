# Claude Instructions for Your Project

This guides Claude/Copilot on your code style.

## Code Patterns

### Imports
Always start with `from __future__ import annotations`:

```python
from __future__ import annotations

import os
from typing import Any

import requests

from {{package_src}}.module import MyClass
```

### Type Hints
Use type hints everywhere:

```python
def process(items: list[str], count: int) -> dict[str, int]:
    """Process items and return results."""
    return {item: len(item) for item in items}
```

### Classes
```python
class DataProcessor:
    def __init__(self, name: str) -> None:
        self.name = name

    def process(self, data: list[str]) -> dict[str, int]:
        """Process data and return mapping."""
        return {item: len(item) for item in data}
```

### Error Handling
Catch specific exceptions:

```python
try:
    result = process(data)
except ValueError as e:
    print(f"Error: {e}")
```

## Testing

### Unit Tests
```python
def test_process_basic() -> None:
    """Test basic processing."""
    result = process(["hello", "world"])
    assert result == {"hello": 5, "world": 5}
```

### With Fixtures (in tests/conftest.py)
```python
import pytest

@pytest.fixture
def sample_data() -> list[int]:
    return [1, 2, 3, 4, 5]

def test_with_data(sample_data: list[int]) -> None:
    """Test using fixture."""
    assert len(sample_data) == 5
```

## Commands

- `hatch run type` - Type checking
- `hatch run style` - Lint check
- `hatch run fix` - Auto-fix style
- `hatch run test` - Run tests

## Naming

- **Modules**: `snake_case` (`data_processor.py`)
- **Classes**: `PascalCase` (`DataProcessor`)
- **Functions**: `snake_case` (`process_data()`)
- **Constants**: `UPPER_SNAKE_CASE` (`MAX_SIZE = 100`)
- **Private**: prefix with `_` (`_internal_helper()`)

## Structure

```
{{package_src}}/
├── __init__.py
├── main.py
└── module.py  # Add your modules here
```

## Tips

✅ Brief docstrings (1-2 lines for simple functions)
✅ Descriptive variable names
✅ Small, focused functions
✅ Write tests for new features

---

Look at `main.py` for basic structure.
