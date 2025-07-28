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

## Setup environnement modulaire

Le système utilise des fonctions modulaires pour la configuration :

```bash
setup_temp_directories()      # Création structure /tmp/tmp
setup_environment()           # Configuration variables PATH/XDG
install_homebrew_if_needed()  # Installation conditionnelle Homebrew
setup_norminette_alias()      # Configuration outils Python
```

### Fonctionnement asynchrone ou synchrone

Par défaut, le setup s'exécute en arrière-plan pour ne pas ralentir le démarrage du shell :

```bash
# Mode asynchrone (par défaut)
setup_async_mode() {
    setopt NO_NOTIFY # Gestion des notifications de jobs
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

## Plugins Oh-My-Zsh optimisés

Configuration plugins pour productivité maximale :

```bash
plugins=(
    git                      # Aliases Git avancés
    zsh-syntax-highlighting  # Coloration syntaxe en temps réel
    zsh-autosuggestions      # Suggestions basées historique
    web-search               # Recherche web depuis terminal
    copybuffer               # Copie buffer vers clipboard
    dirhistory               # Navigation historique dossiers
    copyfile                 # Copie contenu fichier
    history                  # Gestion historique avancée
)
```
