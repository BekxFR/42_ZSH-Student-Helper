# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ZSH shell environment toolkit for École 42 students. Provides automated Oh-My-Zsh setup, development tool installers, and storage optimization by using `/tmp/$USER` workspaces instead of home directories (5GB quota constraint). Supports **Ubuntu 20.04+ and Fedora** (school migration in progress, Fedora = final target). `$HOME` is NFS-shared across all workstations; `/tmp/$USER` is local per machine. All documentation and messages are in French.

## Key Commands

```bash
# Deployment
./Deploy.sh              # Full installation (Oh-My-Zsh, plugins, fonts, config)
./Deploy.sh Fonts        # Fonts only
./Deploy.sh --help       # Help

# Testing (no test framework - plain bash scripts)
bash scripts/test_environment_safety.sh      # Validates safe mode, conditional variables
bash scripts/test_multiuser_validation.sh    # Validates user isolation in /tmp
```

There is no Makefile, CI/CD, linter, or build system.

## Architecture

### Core files

- **`Deploy.sh`** - Main installer. Uses `set -euo pipefail`, trap-based rollback on ERR/SIGINT/SIGTERM, timestamped backups, logs to `/tmp/42_zsh_deploy.log`. Checks `ID=(ubuntu|fedora)` in `/etc/os-release` and Zsh 5.0.8+.
- **`data/.zshrc`** (~1,700 lines) - The ZSH configuration deployed to `~/.zshrc`. Contains all runtime logic: environment setup, logging system, aliases, prompt customization, setup orchestration, and tool installer functions (including `ClaudeInstall()`).
- **`scripts/BrewInstaller.sh`** - Lightweight Homebrew installer targeting `$STUDENT_WORKSPACE/homebrew`.

### Workspace model

Each user gets an isolated workspace at `/tmp/$USER` (set via `STUDENT_WORKSPACE`). All portable tools (Homebrew, Node.js, Java, Rust, Go, Cargo, Poetry, Claude Code) install there, avoiding home directory quota consumption. The `/tmp` sticky bit (1777) prevents cross-user access. Claude Code uses symlinks (`~/.local/share/claude`, `~/.cache/claude`) to redirect its data transparently. VS Code regenerable caches (`Crashpad/`, `GPUCache/`, `logs/`, `CachedProfilesData/`, `Dawn*Cache/`) can be symlinked to `$STUDENT_WORKSPACE/vscode-cache/` via the `STUDENT_USE_PORTABLE_CACHE` flag - deliberately excludes `User/`, `WebStorage/`, `globalStorage/` to preserve settings and extension auth.

### Conditional activation pattern

Portable features are opt-in via flags. Nothing modifies the user environment unless explicitly enabled:

```bash
[[ "$STUDENT_USE_PORTABLE_JAVA" == "1" ]] && export JAVA_HOME="$STUDENT_WORKSPACE/java"
```

Flags: `STUDENT_USE_PORTABLE_JAVA`, `_PYTHON`, `_DOCKER`, `_VAGRANT`, `_VSCODE`, `_IDEA`, `_CLAUDE`, `_CACHE`, `_XDG` (all default to 0). Toggle aliases follow the `*_on` / `*_off` / `*_status` pattern (`cache_on`, `claude_on`, `docker_on`, etc.). **Note on `_VSCODE`**: only defines `VSCODE_PORTABLE_EXTENSIONS` as the candidate path for the opt-in `code-portable` alias and `VSCodeExtensionsInstall` function. The previous `code` wrapper injecting `--extensions-dir`/`--user-data-dir` has been removed because it forced extension reinstallation on every workstation switch. Use `_CACHE` to redirect only regenerable VS Code caches.

### Setup modes

- **Synchronous** (first run, default): `ASYNC_SETUP=0` - sequential, reliable
- **Asynchronous** (subsequent runs): `ASYNC_SETUP=1` - background tasks via `{ cmd >/dev/null 2>&1; } &!`
- Controlled by: `DISABLE_SETUP`, `ASYNC_SETUP`, `AUTO_INSTALL_BREW`

### Logging system

Five levels via `LOGLEVEL` (0=silent to 4=debug). Functions: `logs_error()`, `logs_warning()`, `logs_info()`, `logs_success()`, `logs_debug()`. Runtime control: `log_debug`, `log_silent`, `log_status`.

## Code Conventions

- **Strict mode** in Deploy.sh: `set -euo pipefail`
- **Function naming**: `setup_*()` for initialization, `logs_*()` for logging, `*Install()` for tool installers (e.g. `NodeInstall`, `JavaInstall`), PascalCase for user-facing utilities (`STmp`, `GF`, `Wcc`)
- **Variables**: `UPPERCASE` for environment/exported vars, `lowercase_with_underscores` for locals, `readonly` for constants
- **Error pattern**: check with `if ! command; then logs_error "..."; return 1; fi`
- **Background jobs**: `{ task >/dev/null 2>&1; } &!` (suppresses job notifications)
- **Language**: All commit messages, docs, log messages, and comments are in French
