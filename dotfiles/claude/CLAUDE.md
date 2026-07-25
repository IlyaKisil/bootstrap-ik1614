# General Guidelines

- For every response, always mention the user's name (Ilya) in the beginning.
- Never use em-dashes (`—`). Use a comma, colon, parentheses, restructure the sentence instead or fall back to plain dash `-` 
- When generating a `CLAUDE.md` file do not add a `# CLAUDE.md` title or any preamble line (e.g. "This file provides guidance to Claude Code...") and start top-level sections at `#`, not `##`.

# Python

- **Package manager:** uv
- **Formatter/linter:** ruff
- **Docstrings:** NumPy style
- **Tests:** pytest

# Go

- **Logging:** `slog` (stdlib)
- **Error handling:**
  - Always wrap with `%w`: `fmt.Errorf("failed to load config: %w", err)`
  - Use sentinel errors (`var ErrNotFound = errors.New(...)`) when callers need to branch on a specific condition
  - Use custom error types only when structured data needs to be attached (e.g. field name, HTTP status)
  - Never return an external package's error unwrapped

# Bash

- **Indentation:** 2 spaces
- **Compatibility:** Bash 3+; no POSIX/sh compatibility required
- **`errexit` independent:** scripts must behave correctly regardless of whether `set -e` is active
  - Never rely on a failing command to set a variable — the assignment would abort under `errexit`
  - To branch on an exit code, assign inside the `if` condition (conditions are exempt from `errexit`):
    ```bash
    # correct
    if var="$(command thing)"; ret="$?"; [[ "$ret" == 0 ]]; then ...
    # or alternatively
    command thing && ret=$? || ret=$?
    ```
- **Flag names:** prefer long-form flags over single-letter (`--output` not `-o`) so intent is readable without consulting docs
- **Multi-line flags:** split command flags across lines with indentation rather than a single long line:
  ```bash
  some_command \
    --flag-one value \
    --flag-two 
  ```

# Terraform

## Naming

- Use `_` (underscore) everywhere — resources, data sources, variables, outputs; use `-` only in argument values and human-facing strings (DNS names, tags)
- Singular nouns for resource names
- Use `this` when the module creates only one resource of that type and no better name exists
- Do not repeat the resource type in the resource name:
  ```hcl
  # correct
  resource "aws_route_table" "public" {}
  # wrong
  resource "aws_route_table" "public_route_table" {}
  ```

## Variables

- Always include `description`; key order: `description`, `type`, `default`, `validation`
- Use positive names (`encryption_enabled` not `encryption_disabled`)

## Outputs

Follow the pattern `{name}_{type}_{attribute}`:
- `{name}` — resource or data source name (omit `this` when there are multiple resources)
- `{type}` — resource type without provider prefix
- `{attribute}` — the specific attribute returned

## Resource Block Argument Order

1. `count` / `for_each` (followed by blank line)
2. Main arguments
3. `tags` (last real argument)
4. `depends_on` / `lifecycle` if needed (each separated by blank line)

# Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/): `<type>(<scope>): <description>`

Common types: `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `ci`

If the current branch name matches a JIRA ticket pattern (e.g. `ABC-123`, `PROJECT-456`), prefix the commit message with the ticket ID:

```
ABC-123 feat(auth): add login endpoint
```
