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

### OS detection & Fedora/Toolbox integration

The config detects the running distro via `/etc/os-release` and exports `STUDENT_OS_ID` (values: `ubuntu`, `fedora`, `unknown`). Fedora-specific behaviour:

- **VS Code auto-mkdir**: each shell source creates `/goinfre/$USER/.config/Code/{Cache,CachedExtensionVSIXs,Service Worker,CachedData}` if missing — without these subfolders VS Code refuses to launch on 42 Fedora workstations. Not a flag, it's a hard system prerequisite.
- **Podman/Toolbox storage redirection**: on Fedora, `CONTAINERS_STORAGE_CONF` points at `$STUDENT_WORKSPACE/containers/storage.conf`, generated on-demand by `_ensure_toolbox_storage()`. All Podman/Toolbox data (images, layers, container rootfs) lives under `/tmp/$USER/containers/` — preserves the NFS quota.
- **Toolbox-backed tool provisioning**: the container name is `STUDENT_TOOLBOX_NAME` (default `student-dev`). `OCamlInstall()` provisions OCaml + `rlwrap` inside this container on Fedora (`toolbox create -y -c ... && toolbox run -c ... sudo dnf install -y ocaml ocaml-compiler-libs ocaml-findlib rlwrap`). On Ubuntu the same function uses `brew install ocaml rlwrap`.
- **Transparent wrappers**: `ocaml`, `ocamlopt`, `ocamlc`, `ocamlfind`, `rlwrap` are shell functions that call the native binary if available (Ubuntu brew path) and otherwise route via `toolbox run -c "$STUDENT_TOOLBOX_NAME"` on Fedora. Usage (`ocamlopt -c atom.ml`, `rlwrap ocaml`) is identical on both OSes.
- **Portable script `scripts/tb-ocaml.sh`**: standalone wrapper (no `.zshrc` dependency) that compiles OCaml via Toolbox on any Fedora workstation. Subcommands: `setup`, `clean`, `status`, `help`; any other argument is forwarded to `toolbox run -c "$STUDENT_TOOLBOX_NAME"` (e.g. `tb-ocaml.sh make`, `tb-ocaml.sh ocamlopt -c atom.ml`, `tb-ocaml.sh rlwrap ocaml`). Re-implements the storage-redirection logic internally so the NFS quota stays preserved even on machines where the project isn't deployed. Copy-and-run workflow: `scp tb-ocaml.sh` to the target machine, `./tb-ocaml.sh setup`, then `./tb-ocaml.sh make` in the project directory, `./tb-ocaml.sh clean` at the end to free disk.

### Conditional activation pattern

Portable features are opt-in via flags. Nothing modifies the user environment unless explicitly enabled:

```bash
[[ "$STUDENT_USE_PORTABLE_JAVA" == "1" ]] && export JAVA_HOME="$STUDENT_WORKSPACE/java"
```

Flags: `STUDENT_USE_PORTABLE_JAVA`, `_PYTHON`, `_DOCKER`, `_VAGRANT`, `_VSCODE`, `_IDEA`, `_CLAUDE`, `_CACHE`, `_XDG`. Tous par défaut à `0` **sauf `_CACHE` qui est à `1` par défaut** (opt-out) : les 6 dossiers ciblés sont 100% régénérables et le gain quota NFS est immédiat sans friction utilisateur. Toggle aliases follow the `*_on` / `*_off` / `*_status` pattern (`cache_on`, `claude_on`, `docker_on`, etc.). **Note on `_VSCODE`**: only defines `VSCODE_PORTABLE_EXTENSIONS` as the candidate path for the opt-in `code-portable` alias and `VSCodeExtensionsInstall` function. The previous `code` wrapper injecting `--extensions-dir`/`--user-data-dir` has been removed because it forced extension reinstallation on every workstation switch. Use `_CACHE` to redirect only regenerable VS Code caches. `WebStorage/`, `User/`, `globalStorage/` restent exclus pour préserver les sessions d'auth webview (Copilot Chat, Claude, Remote SSH, etc.).

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
