# 🛠️ Fonctionnalités détaillées

## Installation automatique Homebrew

Le script `BrewInstaller.sh` gère l'installation complète :

```bash
#!/bin/bash
mkdir -p /tmp/tmp
cd /tmp/tmp
mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | \
    tar xz --strip-components 1 -C homebrew
eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
```

## Fonctions avancées disponibles

### Gestion environnement temporaire

```bash
STmp [chemin]    # Ouvrir dossier temporaire dans VS Code
                 # Défaut: /tmp/tmp
                 # Exemple: STmp ~/projet_test
```

**Fonctionnalités** :

- Création automatique du répertoire si inexistant
- Validation des permissions
- Vérification de la validité du chemin
- Lancement automatique de VS Code

### Git workflow optimisé

```bash
GF "message"     # Git add + commit + push en une commande
                 # Exemple: GF "fix: correction bug affichage"
                 # ⚠️ Attention : commande non recommandée en production
```

**Sécurités intégrées** :

- Vérification des changements avant commit
- Messages d'erreur informatifs
- Gestion des échecs de push

### Environnement Python

```bash
PyNormInstall    # Installer norminette (flake8) pour python via pip
```

**Fonctionnalités** :

- Détection automatique de pip3
- Installation via `--user` pour éviter les conflits
- Configuration automatique de l'alias `norminette`

```bash
rlwrap           # Installation et utilisation automatique si Homebrew disponible
```

**Gestion intelligente** :

- Détection de l'installation existante
- Proposition d'installation si manquant
- Support des chemins Homebrew multiples

## Fonctions utilitaires

### Compilation C optimisée

```bash
Wcc              # gcc avec flags -Wall -Wextra -Werror
```

### Optimisation navigateurs

```bash
GoC              # Nettoyer lock Google Chrome
BrC              # Nettoyer lock Brave Browser
```

### Configuration rapide

```bash
bp               # Éditer ~/.zshrc avec vim
sa               # Recharger configuration ZSH avec message de succès
x                # Clear terminal (printf "\033c")
```

## Gestion des logs et debugging

### Fonctions de logging

```bash
logs_error "Message"      # Affiché si LOGLEVEL >= 1
logs_warning "Message"    # Affiché si LOGLEVEL >= 2
logs_info "Message"       # Affiché si LOGLEVEL >= 3
logs_success "Message"    # Affiché si LOGLEVEL >= 3
logs_debug "Message"      # Affiché si LOGLEVEL >= 4
```

### Aliases de diagnostic

```bash
setup_status    # Affiche l'état des variables de configuration
log_status      # Affiche le niveau de log actuel
prompt_level    # Affiche la configuration du prompt
```
