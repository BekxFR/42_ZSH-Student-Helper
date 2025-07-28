# 🏗️ Architecture technique

## Structure modulaire

Le projet suit une architecture modulaire pour maintenir la lisibilité et faciliter les extensions :

```
42_ZSH-Student-Helper/
├── README.md              # Documentation principale (simplifiée)
├── Deploy.sh              # Script déploiement principal
├── scripts/               # Modules additionnels
│   └── BrewInstaller.sh   # Module installation Homebrew
├── data/                  # Configurations
│   └── .zshrc             # Configuration ZSH optimisée
└── docs/                  # Documentation détaillée
    ├── CONFIGURATION.md   # Configuration avancée
    ├── OPTIMIZATION.md    # Stratégies d'optimisation
    ├── FEATURES.md        # Fonctionnalités détaillées
    ├── CUSTOMIZATION.md   # Guide personnalisation
    ├── TROUBLESHOOTING.md # Guide dépannage
    └── ARCHITECTURE.md    # Architecture technique
```

## Gestion d'erreurs robuste

Le système implémente un rollback de la configuration en cas d'erreurs :

```bash
# Activation mode strict dans les scripts
set -euo pipefail

# Fonction trap pour rollback automatique
rollback() {
    error "Échec du déploiement, rollback en cours..."

    if [[ -f "$BACKUP_DIR/zshrc.backup" ]]; then
        mv "$BACKUP_DIR/zshrc.backup" "$HOME/.zshrc"
        info "Configuration ZSH restaurée"
    fi

    if [[ -f "$BACKUP_DIR/BrewInstaller.sh.backup" ]]; then
        mv "$BACKUP_DIR/BrewInstaller.sh.backup" "$HOME/42/BrewInstaller.sh"
        info "Script BrewInstaller restauré"
    fi

    rm -rf "$BACKUP_DIR" 2>/dev/null || true
    info "Environnement de backup nettoyé"

    error "Rollback terminé. Consultez $LOG_FILE pour détails."
    exit 1
}
trap cleanup ERR EXIT SIGINT SIGTERM
```

## Architecture des fonctions

### Fonctions de setup modulaires

```bash
# Fonction principale de setup
setup_42zsh_environment() {
    logs_debug "Initialisation des fonctions de setup..."

    if [[ "${DISABLE_SETUP:-0}" == "1" ]]; then
        logs_debug "Setup automatique désactivé"
        return 0
    fi

    if [[ "${ASYNC_SETUP:-1}" == "1" ]]; then
        setup_async_mode
    else
        setup_sync_mode
    fi
}

# Mode asynchrone (par défaut)
setup_async_mode() {
    setopt NO_NOTIFY
    { setup_temp_directories >/dev/null 2>&1; } &!
    { setup_environment >/dev/null 2>&1; } &!
    if [[ "${AUTO_INSTALL_BREW:-1}" == "1" ]]; then
        { install_homebrew_if_needed >/dev/null 2>&1; } &!
    fi
    { setup_norminette_alias >/dev/null 2>&1; } &!
    setopt NOTIFY
    logs_debug "Fonctions de setup lancées en arrière-plan"
}

# Mode synchrone (pour debug)
setup_sync_mode() {
    setup_temp_directories
    setup_environment
    if [[ "${AUTO_INSTALL_BREW:-1}" == "1" ]]; then
        install_homebrew_if_needed
    fi
    setup_norminette_alias
    logs_debug "Fonctions de setup exécutées de manière synchrone"
}
```

### Système de logging centralisé

```bash
# Configuration globale des logs
export LOGLEVEL=${LOGLEVEL:-0}  # 0=silencieux par défaut

# Fonctions de logging avec gestion de niveau
logs_error() {
    [[ $LOGLEVEL -ge 1 ]] && echo "❌ $*" >&2
}

logs_warning() {
    [[ $LOGLEVEL -ge 2 ]] && echo "⚠️  $*" >&2
}

logs_info() {
    [[ $LOGLEVEL -ge 3 ]] && echo "ℹ️  $*" >&2
}

logs_success() {
    [[ $LOGLEVEL -ge 3 ]] && echo "✅ $*" >&2
}

logs_debug() {
    [[ $LOGLEVEL -ge 4 ]] && echo "🐛 [DEBUG] $*" >&2
}
```

## Gestion des dépendances

### Installation conditionnelle

```bash
# Installation Homebrew conditionnelle
install_homebrew_if_needed() {
    local brew_path="/tmp/tmp/homebrew/bin/brew"
    local installer_script="$HOME/42/42_ZSH_Scripts/BrewInstaller.sh"

    if [[ ! -f "$brew_path" ]]; then
        if [[ -f "$installer_script" && -x "$installer_script" ]]; then
            logs_info "Installation de Homebrew en cours..."
            {
                if zsh -c "$installer_script" >/dev/null 2>&1; then
                    export PATH="/tmp/tmp/homebrew/bin:$PATH"
                    logs_success "Homebrew installé avec succès!"
                else
                    logs_error "Échec de l'installation de Homebrew"
                fi
            } &!  # Exécution en arrière-plan sans notification
        fi
    else
        logs_debug "Homebrew déjà installé"
    fi
}
```

### Configuration environnement PATH

```bash
setup_environment() {
    local cache_dir="/tmp/tmp/.cache"
    local homebrew_dir="/tmp/tmp/homebrew"

    logs_debug "Configuration de l'environnement..."

    # Configuration cache XDG (standard système)
    if [[ -d "$cache_dir" ]]; then
        export XDG_CACHE_HOME="$cache_dir"
        export PYTHONPATH="$cache_dir:$PYTHONPATH"
        export PYTHONUSERBASE="/tmp/tmp"
        export PATH="/tmp/tmp/bin:$PATH"
        logs_debug "Configuration Python/XDG terminée"
    fi

    # Configuration Homebrew avec PATH correct
    if [[ -d "$homebrew_dir/bin" ]]; then
        if [[ -x "$homebrew_dir/bin/brew" ]]; then
            if eval "$($homebrew_dir/bin/brew shellenv)" 2>/dev/null; then
                logs_debug "Environnement Homebrew configuré via shellenv"
            else
                logs_warning "Erreur lors de la configuration de l'environnement Homebrew"
                export PATH="$homebrew_dir/bin:$PATH"
                logs_debug "Fallback: PATH Homebrew ajouté manuellement"
            fi
        else
            logs_info "Homebrew non installé, ajout du PATH uniquement"
            export PATH="$homebrew_dir/bin:$PATH"
        fi
    fi

    logs_debug "Configuration de l'environnement terminée"
}
```

## Tests et validation

### Standards de développement

Le projet suit les meilleures pratiques Shell :

```bash
# Utilisation mode strict
set -euo pipefail

# Fonctions avec gestion d'erreur
function_name() {
    local param1="$1"
    local result

    if ! result=$(some_command "$param1"); then
        logs_error "Échec de some_command avec $param1"
        return 1
    fi

    logs_success "Fonction terminée avec succès"
    echo "$result"
}
```

### Tests unitaires

```bash
# Tests unitaires pour fonctions principales
test_setup_temp_directories() {
    local test_dir="/tmp/test_42zsh"

    # Setup
    export LOGLEVEL=0  # Mode silencieux pour tests

    # Test
    if setup_temp_directories; then
        echo "✅ Test setup_temp_directories: PASS"
    else
        echo "❌ Test setup_temp_directories: FAIL"
        return 1
    fi

    # Cleanup
    rm -rf "$test_dir" 2>/dev/null || true
}
```
