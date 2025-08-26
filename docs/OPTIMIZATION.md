# 💾 Stratégie d'optimisation

## Architecture `/tmp/tmp`

Le système utilise une approche innovante pour économiser l'espace :

```bash
/tmp/tmp/
├── .cache/                 # Cache XDG et Python
├── bin/                    # Binaires temporaires
├── homebrew/              # Installation Homebrew locale
│   ├── bin/
│   └── ...
└── ...
```

**Avantages de cette approche :**

- **Économie espace** : ~2-3GB sauvés sur l'installation principale
- **Performance** : Accès rapide fichiers temporaires en RAM
- **Sécurité** : Nettoyage automatique au redémarrage
- **Non-intrusif** : Aucune modification système permanente

## Configuration Homebrew optimisée

```bash
# Installation dans /tmp/tmp/homebrew au lieu de /usr/local
mkdir -p /tmp/tmp/homebrew
curl -L https://github.com/Homebrew/brew/tarball/master | \
    tar xz --strip-components 1 -C /tmp/tmp/homebrew

# Configuration automatique PATH
eval "$(/tmp/tmp/homebrew/bin/brew shellenv)"
```

## Cache Python optimisé

```bash
export XDG_CACHE_HOME="/tmp/tmp/.cache"
export PYTHONPATH="/tmp/tmp/.cache:$PYTHONPATH"
export PYTHONUSERBASE="/tmp/tmp"
export PATH="/tmp/tmp/bin:$PATH"
```

## Setup environnement intelligent et adaptatif

Le système utilise des fonctions modulaires pour la configuration avec détection automatique du mode d'installation :

```bash
setup_temp_directories()      # Création structure /tmp/tmp
setup_environment()           # Configuration variables PATH/XDG
install_homebrew_if_needed()  # Installation conditionnelle Homebrew
setup_norminette_alias()      # Configuration outils Python
```

### Mode synchrone par défaut pour première installation

Le système détecte automatiquement s'il s'agit d'une première installation et force le mode synchrone pour garantir la prise en compte des variables d'environnement :

```bash
# Détection automatique première installation
local force_sync=0
if [[ ! -d "/tmp/tmp" ]] || \
   [[ "${AUTO_INSTALL_BREW:-1}" == "1" && ! -x "/tmp/tmp/homebrew/bin/brew" ]] || \
   [[ "$PATH" != *"/tmp/tmp/homebrew/bin"* ]]; then
    force_sync=1
    logs_debug "Première installation détectée - mode synchrone forcé"
fi
```

### Mode asynchrone adaptatif

Après la première installation, le mode asynchrone peut être activé pour optimiser les performances :

```bash
# Mode asynchrone (pour environnements déjà configurés)
setup_async_mode() {
    logs_debug "Mode asynchrone - environnement déjà configuré"
    
    # Ces fonctions doivent TOUJOURS être synchrones car elles modifient l'environnement
    setup_temp_directories
    setup_environment
    
    # Seules les installations peuvent être asynchrones
    setopt NO_NOTIFY
    if [[ "${AUTO_INSTALL_BREW:-1}" == "1" ]]; then
        { install_homebrew_if_needed >/dev/null 2>&1; } &!
    fi
    { setup_norminette_alias >/dev/null 2>&1; } &!
    { c_formatter_42_pipInstall >/dev/null 2>&1; } &!
    setopt NOTIFY
}
```

### Fonctionnement synchrone garanti

Le mode synchrone garantit que toutes les modifications d'environnement sont prises en compte immédiatement :

```bash
# Mode synchrone (première installation ou debug)
setup_sync_mode() {
    setup_temp_directories
    setup_environment
    if [[ "${AUTO_INSTALL_BREW:-1}" == "1" ]]; then
        install_homebrew_if_needed
    fi
    setup_norminette_alias
    c_formatter_42_pipInstall
    logs_debug "Fonctions de setup exécutées de manière synchrone"
}
```

## Plugins Oh-My-Zsh optimisés

Configuration plugins pour productivité maximale avec installation automatique des plugins externes :

```bash
plugins=(
    git                      # Aliases Git avancés (inclus par défaut)
    zsh-syntax-highlighting  # Coloration syntaxe en temps réel (externe - installé auto)
    zsh-autosuggestions      # Suggestions basées historique (externe - installé auto)
    web-search               # Recherche web depuis terminal (inclus par défaut)
    copybuffer               # Copie buffer vers clipboard (inclus par défaut)
    dirhistory               # Navigation historique dossiers (inclus par défaut)
    copyfile                 # Copie contenu fichier (inclus par défaut)
    history                  # Gestion historique avancée (inclus par défaut)
)
```

**Plugins externes installés automatiquement :**
- `zsh-autosuggestions` : Suggestions intelligentes basées sur l'historique des commandes
- `zsh-syntax-highlighting` : Coloration syntaxique en temps réel pour une meilleure lisibilité
