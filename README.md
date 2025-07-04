# README.md - 42_ZSH Student Helper

## 🎯 Vue d'ensemble

**42_ZSH Student Helper** est un environnement de développement optimisé pour les étudiants de l'école 42, conçu pour maximiser la productivité tout en respectant les contraintes de stockage strict (5GB). Ce projet fournit une configuration ZSH complète avec Oh-My-Zsh, le thème Agnoster, et un système d'optimisation intelligent utilisant `/tmp/tmp` pour économiser l'espace disque.

### Caractéristiques principales

- **Optimisation stockage** : Utilisation stratégique de `/tmp/tmp` pour Homebrew et cache Python
- **Installation automatique** : Déploiement de Homebrew en arrière-plan sans intervention utilisateur
- **Système de logs modulaire** : 5 niveaux configurables (0=silencieux, 4=debug complet)
- **Support multi-gestionnaires** : Compatible HomeBrew, pip, npm avec installation conditionnelle
- **Architecture modulaire** : Fonctions séparées pour maintenance et évolution facilitées

## 📋 Table des matières

- [Prérequis](#pr%C3%A9requis)
- [Installation rapide](#installation-rapide)
- [Guide d'utilisation](#guide-dutilisation)
- [Configuration avancée](#configuration-avanc%C3%A9e)
- [Stratégie d'optimisation](#strat%C3%A9gie-doptimisation)
- [Fonctionnalités](#fonctionnalit%C3%A9s)
- [Personnalisation](#personnalisation)
- [Dépannage](#d%C3%A9pannage)
- [Architecture technique](#architecture-technique)
- [Contribution](#contribution)

## ⚡ Prérequis

### Configuration minimale requise

- **OS** : Ubuntu 20.04+ ou distribution basée Debian
- **Zsh** : Version 5.0.8 minimum (5.8 recommandée)
- **Stockage** : 200MB minimum libres dans `/tmp`

### Vérification automatique

```bash
# Vérification version Zsh
zsh --version  # Attendu: zsh 5.8+

# Vérification espace disponible
df -h /tmp     # Vérifier espace libre > 200MB
```

### Dépendances automatiquement installées

- `git` (v2.4.11+)
- `curl` ou `wget`
- `fonts-powerline`
- Oh-My-Zsh framework

## 🚀 Installation rapide

### Options du script Deploy.sh

Le script `Deploy.sh` supporte plusieurs options :

```bash
# Installation complète (par défaut)
./Deploy.sh

# Installation uniquement des fonts Powerline
./Deploy.sh Fonts

# Afficher l'aide
./Deploy.sh --help
```

### Option 1 : Installation automatique (Recommandée)

```bash
# Clonage et installation en une commande
git clone https://github.com/BekxFR/42_ZSH-Student-Helper.git
cd 42_ZSH-Student-Helper
./Deploy.sh
```

### Option 1.5 : Installation uniquement des fonts Powerline

```bash
# Installation uniquement des fonts Powerline
git clone https://github.com/BekxFR/42_ZSH-Student-Helper.git
cd 42_ZSH-Student-Helper
./Deploy.sh Fonts
```

### Option 2 : Installation manuelle

```bash
# 1. Installation Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 2. Copie de la configuration
cp .zshrc ~/.zshrc
cp BrewInstaller.sh ~/42/

# 3. Activation
source ~/.zshrc
```

## 📖 Guide d'utilisation

### Aliases essentiels

```bash
# Configuration et rechargement
bp           # Éditer ~/.zshrc avec vim
sa           # Recharger configuration ZSH
x            # Clear terminal

# Contrôle des logs
log_silent   # Mode silencieux (LOGLEVEL=0)
log_debug    # Mode debug complet (LOGLEVEL=4)
log_status   # Afficher niveau actuel

# Optimisation navigateurs
GoC          # Nettoyer lock Google Chrome
BrC          # Nettoyer lock Brave Browser

# Compilation C
Wcc          # gcc avec flags -Wall -Wextra -Werror
```

### Fonctions avancées

#### Gestion environnement temporaire

```bash
STmp [chemin]    # Ouvrir dossier temporaire dans VS Code
                 # Défaut: /tmp/tmp
                 # Exemple: STmp ~/projet_test
```

#### Git workflow optimisé

```bash
GF "message"     # Git add + commit + push en une commande
                 # Exemple: GF "fix: correction bug affichage"
                 # Attention commande non recommandée en production
```

#### Environnement Python

```bash
PyNormInstall    # Installer norminette (flake8) pour python via pip
rlwrap           # Installation automatique si Homebrew disponible
```

## ⚙️ Configuration avancée

### Système de logs configurables

Le système utilise la variable `LOGLEVEL` pour contrôler la verbosité :

```bash
# Dans ~/.zshrc ou au runtime
export LOGLEVEL=3  # 0=silencieux, 1=erreurs, 2=warnings, 3=info, 4=debug

# Fonctions de logging disponibles
logs_error "Message d'erreur"      # ❌ Niveau 1+
logs_warning "Avertissement"       # ⚠️ Niveau 2+
logs_info "Information"            # ℹ️ Niveau 3+
logs_success "Succès"              # ✅ Niveau 3+
logs_debug "Debug détaillé"        # 🐛 Niveau 4 uniquement
```

### Personnalisation du prompt

Le thème Agnoster supporte plusieurs configurations :

```bash
# Contrôle affichage prompt
export DEFAULT_USER="votre_nom"  # Masquer nom utilisateur

# Segments personnalisables via AGNOSTER_PROMPT_SEGMENTS
AGNOSTER_PROMPT_SEGMENTS=(
    "prompt_status"
    "prompt_context"
    "prompt_dir"
    "prompt_git"
    "prompt_end"
)
```

### Variables d'environnement

```bash
# Contrôle setup automatique
export DISABLE_SETUP=1       # Désactiver le setup automatique
export ASYNC_SETUP=0         # Désactiver le setup asynchrone (défaut: asynchrone)
export AUTO_INSTALL_BREW=0   # Désactiver installation Homebrew auto

# Contrôle prompt
export PROMPTLEVEL=1         # Prompt version courte - 0=complet (date+heure), 1=minimal

# Contrôle logs
export LOGLEVEL=2            # Warnings + erreurs seulement
```

## 💾 Stratégie d'optimisation

### Architecture `/tmp/tmp`

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

### Configuration Homebrew optimisée

```bash
# Installation dans /tmp/tmp/homebrew au lieu de /usr/local
mkdir -p /tmp/tmp/homebrew
curl -L https://github.com/Homebrew/brew/tarball/master | \
    tar xz --strip-components 1 -C /tmp/tmp/homebrew

# Configuration automatique PATH
eval "$(/tmp/tmp/homebrew/bin/brew shellenv)"
```

### Cache Python optimisé

```bash
export XDG_CACHE_HOME="/tmp/tmp/.cache"
export PYTHONPATH="/tmp/tmp/.cache:$PYTHONPATH"
export PYTHONUSERBASE="/tmp/tmp"
export PATH="/tmp/tmp/bin:$PATH"
```

## 🛠️ Fonctionnalités

### Installation automatique Homebrew

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

### Setup environnement modulaire

Le système utilise des fonctions modulaires pour la configuration :

```bash
setup_temp_directories()      # Création structure /tmp/tmp
setup_environment()           # Configuration variables PATH/XDG
install_homebrew_if_needed()  # Installation conditionnelle Homebrew
setup_norminette_alias()      # Configuration outils Python
```

### Plugins Oh-My-Zsh optimisés

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

## 🎨 Personnalisation

### Thèmes et couleurs

Le thème Agnoster supporte la personnalisation complète :

```bash
# Installation fonts Powerline pour Ubuntu
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts

# Configuration dans ~/.zshrc
ZSH_THEME="agnoster"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

# Emojis aléatoires dans prompt
emojis=("⚡️" "🔥" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🌙")
```

### Ajout de fonctions personnalisées

```bash
# Dans ~/.zshrc, après la section setup
mon_alias_custom() {
    logs_info "Exécution fonction personnalisée"
    # Votre code ici
}

# Alias personnalisés
alias ma_cmd="mon_alias_custom"
```

## 🔧 Dépannage

### Problèmes fréquents

#### [Fonts Powerline](https://github.com/powerline/fonts) manquantes

```bash
# Option 1: Via le script Deploy.sh (Recommandée)
./Deploy.sh Fonts

# Option 2: Installation manuelle
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
```

#### Homebrew non accessible

```bash
# Vérification installation
ls -la /tmp/tmp/homebrew/bin/brew

# Réinstallation si nécessaire
~/42/BrewInstaller.sh
source ~/.zshrc
```

### Logs de débogage

```bash
# Activation debug complet
log_debug && source ~/.zshrc

# Vérification setup
setup_status
brew_status
log_status
```

### Reset complet

```bash
# Sauvegarde configuration actuelle
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d)

# Reset vers configuration par défaut
rm -rf /tmp/tmp
cp ~/42/42_ZSH-Student-Helper/.zshrc ~/.zshrc
source ~/.zshrc
```

## 🏗️ Architecture technique

### Structure modulaire

Le projet suit une architecture modulaire pour maintenir la lisibilité et faciliter les extensions :

```
42_ZSH-Student-Helper/
├── README.md              # Documentation complète
├── deploy.sh              # Script déploiement principal
└── scripts/               # Modules additionnels
    └── BrewInstaller.sh   # Module installation Homebrew
└── data/                  # Modules additionnels
    └── .zshrc             # Configuration ZSH optimisée
```

### Gestion d'erreurs robuste

Le système implémente plusieurs niveaux de gestion d'erreurs :

```bash
# Activation mode strict
set -euo pipefail

# Fonction trap pour cleanup automatique
cleanup() {
    logs_error "Erreur détectée, nettoyage en cours..."
    rm -rf /tmp/tmp/.setup_lock
    exit 1
}
trap cleanup ERR EXIT SIGINT SIGTERM
```

### Système de rollback

En cas d'échec d'installation :

```bash
rollback_installation() {
    logs_warning "Rollback de l'installation en cours..."

    # Restauration .zshrc précédent
    if [[ -f ~/.zshrc.backup ]]; then
        mv ~/.zshrc.backup ~/.zshrc
        logs_success "Configuration ZSH restaurée"
    fi

    # Nettoyage /tmp/tmp
    rm -rf /tmp/tmp
    logs_success "Environnement temporaire nettoyé"
}
```

## 📦 Script de déploiement

### Structure deploy.sh

```bash
#!/bin/bash
#
# 42_ZSH Student Helper - Script de déploiement
# Optimisé pour environnement éducatif avec contraintes stockage
#

set -euo pipefail

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="/tmp/42_zsh_deploy.log"
readonly BACKUP_DIR="$HOME/.42_zsh_backup_$(date +%Y%m%d_%H%M%S)"

# Fonctions utilitaires de logging
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

error() {
    log "❌ ERREUR: $*" >&2
}

success() {
    log "✅ SUCCÈS: $*"
}

info() {
    log "ℹ️ INFO: $*"
}

# Vérification prérequis
check_prerequisites() {
    info "Vérification des prérequis système..."

    # Ubuntu/Debian requis
    if ! grep -E "ubuntu" /etc/os-release >/dev/null 2>&1; then
        error "Système non supporté. Ubuntu 20.04+ requis."
        exit 1
    fi

    # Version Zsh
    if ! command -v zsh >/dev/null 2>&1; then
        error "Zsh n'est pas installé ou pas détecté correctement"
        exit 1
    fi

    local zsh_version
    zsh_version=$(zsh --version | cut -d' ' -f2)
    if ! printf '%s\n5.0.8\n' "$zsh_version" | sort -V | head -n1 | grep -q "5.0.8"; then
        error "Zsh version $zsh_version trop ancienne. 5.0.8+ requis."
        exit 1
    fi

    # Espace disque
    local available_space
    available_space=$(df /tmp | awk 'NR==2 {print $4}')
    if [[ $available_space -lt 204800 ]]; then
        error "Espace insuffisant dans /tmp. 200MB minimum requis."
        exit 1
    fi

    success "Prérequis vérifiés avec succès"
}

# Installation Oh-My-Zsh
install_ohmyzsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "Installation de Oh-My-Zsh..."
        RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        success "Oh-My-Zsh installé"
    else
        info "Oh-My-Zsh déjà installé"
    fi
}

# Sauvegarde configuration existante
backup_existing_config() {
    info "Sauvegarde de la configuration existante..."

	if [[ ! -d "$BACKUP_DIR" ]]; then
		mkdir -p "$BACKUP_DIR"
		if [[ ! -d "$BACKUP_DIR" ]]; then
			error "Échec de la création du dossier $BACKUP_DIR"
		fi
	fi

    if [[ -f "$HOME/.zshrc" ]]; then
        cp "$HOME/.zshrc" "$BACKUP_DIR/zshrc.backup"
		if [[ $? -ne 0 ]]; then
			error "Échec de la copie du fichier $HOME/.zshrc"
		else
        	info "Sauvegarde de ~/.zshrc vers $BACKUP_DIR"
		fi
    fi

    if [[ -f "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh" ]]; then
        cp "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh" "$BACKUP_DIR/BrewInstaller.sh.backup"
		if [[ $? -ne 0 ]]; then
			error "Échec de la copie du fichier $HOME/42/42_ZSH_Scripts/BrewInstaller.sh"
		else
			info "Sauvegarde de BrewInstaller.sh vers $BACKUP_DIR"
		fi
    fi

    success "Sauvegarde créée dans $BACKUP_DIR"
}

# Déploiement configuration
deploy_config() {
    info "Déploiement de la configuration optimisée..."

	# Creer des dossiers 42 et 42/42_ZSH_Scripts
	if [[ ! -d "$HOME/42" ]]; then
		mkdir -p "$HOME/42"
		if [[ ! -d "$HOME/42" ]]; then
			error "Échec de la création du dossier $HOME/42"
			exit 1
		fi
	fi
	if [[ ! -d "$HOME/42/42_ZSH_Scripts" ]]; then
		mkdir -p "$HOME/42/42_ZSH_Scripts"
		if [[ ! -d "$HOME/42/42_ZSH_Scripts" ]]; then
			error "Échec de la création du dossier $HOME/42/42_ZSH_Scripts"
			exit 1
		fi
	fi

    # Vérifier que le fichier .zshrc existe
    if [[ ! -f "$SCRIPT_DIR/data/.zshrc" ]]; then
        error "Fichier .zshrc introuvable dans $SCRIPT_DIR"
        exit 1
    fi

    cp "$SCRIPT_DIR/data/.zshrc" "$HOME/.zshrc"
	if [[ $? -ne 0 ]]; then
		error "Échec de la copie de .zshrc"
		exit 1
	fi


    if [[ "$SCRIPT_DIR/scripts/BrewInstaller.sh" != "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh" ]]; then
        if [[ -f "$SCRIPT_DIR/scripts/BrewInstaller.sh" ]]; then
            cp "$SCRIPT_DIR/scripts/BrewInstaller.sh" "$HOME/42/42_ZSH_Scripts/"
			if [[ $? -ne 0 ]]; then
				error "Échec de la copie de BrewInstaller.sh"
				exit 1
			fi
        else
            error "Fichier BrewInstaller.sh introuvable dans $SCRIPT_DIR"
            exit 1
        fi
    else
        info "BrewInstaller.sh déjà en place"
    fi

	if ! chmod +x "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh"; then
        error "Échec de chmod sur BrewInstaller.sh"
        exit 1
    fi

    success "Configuration déployée"
}

# Initialisation environnement
init_environment() {
    info "Initialisation de l'environnement optimisé..."

    # Vérification que les fichiers nécessaires sont en place
    cd "$HOME"
    export ZSH="$HOME/.oh-my-zsh"

    # Vérifier que .zshrc a été correctement déployé
    if [[ -f "$HOME/.zshrc" ]]; then
        info "Configuration .zshrc déployée avec succès"
    else
        error "Fichier .zshrc manquant après déploiement"
        exit 1
    fi

    # Note: On ne fait pas 'source ~/.zshrc' ici car nous sommes dans un script bash
    # La configuration ZSH sera activée lors du prochain lancement de ZSH
    info "Configuration prête. Lancez 'zsh' ou redémarrez votre terminal pour activer"

    success "Environnement initialisé"
}

# Vérification installation
verify_installation() {
    info "Vérification de l'installation..."

    # Test commandes principales
    local test_commands=(
        "zsh --version"
        "brew --version 2>/dev/null || echo 'Homebrew sera installé au premier usage'"
        "git --version"
    )

    for cmd in "${test_commands[@]}"; do
        if eval "$cmd" >/dev/null 2>&1; then
            success "✓ $(echo "$cmd" | cut -d' ' -f1) fonctionnel"
        else
            error "✗ Problème avec: $cmd"
        fi
    done

    success "Installation vérifiée avec succès"
}

# Installation des fonts Powerline
install_powerline_fonts() {
    info "Installation des Fonts Powerline..."

    # Vérifier si les Fonts sont déjà installées
    if fc-list | grep -i powerline >/dev/null 2>&1; then
        info "Les Fonts Powerline sont déjà installées"
        return 0
    fi

    # Créer dossier temporaire
    local temp_dir="/tmp/powerline-fonts"
    rm -rf "$temp_dir" 2>/dev/null || true

    # Cloner le dépôt des Fonts
    if ! git clone https://github.com/powerline/fonts.git --depth=1 "$temp_dir"; then
        error "Échec du clonage du dépôt des fonts Powerline"
        return 1
    fi

    # Installer les Fonts
    cd "$temp_dir"
    if ! ./install.sh; then
        error "Échec de l'installation des Fonts Powerline"
        cd - >/dev/null
        rm -rf "$temp_dir"
        return 1
    fi

    # Nettoyage
    cd - >/dev/null
    rm -rf "$temp_dir"

    success "Fonts Powerline installées avec succès"
    info "Relancer votre session pour etre certain de la prise en compte"
}

# Fonction d'aide
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

OPTIONS:
    Fonts       Installer uniquement les fonts Powerline
    --help      Afficher cette aide

Exemples:
    $0              # Installation complète du 42_ZSH Student Helper
    $0 Fonts        # Installation uniquement des fonts Powerline
    $0 --help       # Afficher cette aide

EOF
}

# Fonction principale
main() {
    # Vérifier les arguments
    if [[ $# -gt 0 ]]; then
        case "$1" in
            "Fonts")
                info "🔤 Installation des fonts Powerline uniquement"
                install_powerline_fonts
                success "🎉 Installation des fonts terminée!"
                info "🔄 Redémarrez votre terminal pour que les fonts soient prises en compte"
                return 0
                ;;
            "--help"|"-h")
                show_help
                return 0
                ;;
            *)
                error "Option inconnue: $1"
                show_help
                exit 1
                ;;
        esac
    fi

    info "🚀 Début déploiement 42_ZSH Student Helper"

    check_prerequisites
    install_ohmyzsh
    backup_existing_config
    deploy_config
    init_environment
    verify_installation

    success "🎉 Déploiement terminé avec succès!"
    info "📝 Log complet disponible: $LOG_FILE"
    info "💾 Sauvegarde dans: $BACKUP_DIR"
    info "🔄 Redémarrez votre terminal ou exécutez: source ~/.zshrc"
}

# Gestion erreurs avec rollback
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

trap rollback ERR

# Lancement si exécuté directement
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
```

## 🤝 Contribution

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

### Tests et validation

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

### Guidelines contribution

1. **Fork** le projet
2. **Créer** une branche feature (`git checkout -b feature/AmazingFeature`)
3. **Commiter** vos changements (`git commit -m 'Add AmazingFeature'`)
4. **Pousser** vers la branche (`git push origin feature/AmazingFeature`)
5. **Ouvrir** une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🙏 Remerciements

- **École 42** pour l'inspiration et les contraintes créatives
- **Oh-My-Zsh** pour le framework de base
- **Agnoster** pour le thème élégant
- **Homebrew** pour la flexibilité du gestionnaire de paquets
- La **communauté open source** pour les contributions continues

**Créé avec ❤️ pour la communauté 42**

_Optimisé pour apprendre, conçu pour durer_
