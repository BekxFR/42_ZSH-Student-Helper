# 42_ZSH Student Helper

## 🎯 Qu'est-ce que c'est ?

Un environnement ZSH optimisé pour les étudiants de l'école 42, conçu pour maximiser la productivité tout en respectant les contraintes de stockage strict (5GB).  
Ce projet fournit une configuration ZSH complète avec Oh-My-Zsh, le thème Agnoster, et un système d'optimisation intelligent utilisant un espace de travail utilisateur dynamique `/tmp/tmp/USERNAME` pour économiser l'espace sur la session utilisateur tout en évitant les collisions entre utilisateurs.

### ✨ Caractéristiques principales

- **Installation automatique** : Un seul script pour tout configurer
- **Optimisation espace** : Utilise un espace de travail utilisateur dynamique `/tmp/tmp/USERNAME` pour économiser l'espace et éviter les collisions
- **Isolation utilisateur** : Chaque utilisateur dispose de son propre environnement temporaire sécurisé
- **Setup intelligent** : Configuration automatique de Homebrew et des outils essentiels
- **Prêt à l'emploi** : Aliases et fonctions pratiques pour le développement

### ⚡ Améliorations récentes

- ✅ **Installation plugins externes** : `zsh-autosuggestions` et `zsh-syntax-highlighting` installés automatiquement
- ✅ **Support multi-langages** : Java, Android SDK, Rust, Go, Python/Poetry avec installation automatique
- ✅ **Protection des configurations** : Variables conditionnelles pour préserver vos configurations existantes
- ✅ **Diagnostic environnement** : Fonction `env_diagnostic` pour analyser l'impact sur votre système
- ✅ **Modes de sécurité** : Choix entre mode sécurisé (sans impact) et mode portable complet
- ✅ **Documentation complète** : Guides détaillés pour tous les outils et scénarios de récupération

### 🛡️ **IMPORTANT - Sécurité des Configurations**

⚠️ **Cette configuration peut affecter vos configurations existantes.** Consultez [ENVIRONMENT_SAFETY.md](docs/ENVIRONMENT_SAFETY.md) avant utilisation.

**Modes disponibles :**
- 🟢 **Mode Sécurisé** (recommandé) : `safe_setup` - Aucun impact sur vos configurations
- 🟡 **Mode Portable** (avancé) : `portable_setup` - Isolation complète avec confirmation
- 🔍 **Diagnostic** : `env_diagnostic` - Analyse l'impact sur votre système

## 📑 Fonctionnalités principales

### 📋 Script Deploy.sh

**Déploiement automatisé et intelligent :**

- 🔧 **Installation Oh-My-Zsh** : Configuration automatique du framework ZSH
- 🔌 **Plugins externes** : Installation automatique de `zsh-autosuggestions` et `zsh-syntax-highlighting`
- 🎨 **Fonts Powerline** : Installation des polices nécessaires au thème Agnoster
- 💾 **Sauvegarde automatique** : Backup de la configuration existante avant modification
- ✅ **Vérification prérequis** : Contrôle de l'environnement (Zsh version, espace disque)
- 🔄 **Options flexibles** : Installation complète, fonts uniquement, ou aide
- 🛡️ **Gestion d'erreurs** : Rollback automatique en cas d'échec

### ⚙️ Configuration .zshrc

**Environnement de développement optimisé :**

**🏗️ Infrastructure et optimisation :**

- 📁 **STmp** : Workspace temporaire avec VS Code (`STmp [chemin]`)
- 🍺 **Homebrew intelligent** : Installation et configuration automatique dans l'espace utilisateur dédié
- �️ **Protection configurations** : Variables conditionnelles préservant vos paramètres existants
- 🔧 **Outils modernes** : Support Java, Android, Rust, Go, Python avec installation automatique
- 🔒 **Isolation utilisateur** : Chaque utilisateur dispose de son propre espace temporaire sécurisé
- 📊 **Logs configurables** : 5 niveaux de verbosité (0=silencieux, 4=debug)
- 🎛️ **Contrôle granulaire** : Variables de contrôle pour activer/désactiver chaque fonctionnalité

**🎨 Interface et productivité :**

- 🌈 **Prompt personnalisé** : Thème Agnoster avec emojis aléatoires et informations contextuelles
- 🔌 **Plugins optimisés** : Syntax highlighting, autosuggestions, Git helpers
- ✨ **Aliases essentiels** : `bp`, `sa`, `x`, `Wcc` pour un workflow rapide
- 🎛️ **Contrôles intelligents** : Gestion des logs, prompt, et setup via commandes simples
- 🎧 **Discord portable** : Installation et lancement automatique de Discord (`discord`)

**🔧 Outils de développement :**

- 📏 **Norminette Python** : Configuration automatique de flake8 (`PyNormInstall`)
- 🎨 **C Formatter 42** : Installation automatique de c_formatter_42 pour VS Code (`c_formatter_42_pipInstall`)
- 📚 **Node.js portable** : Installation automatique de Node.js et npm sans sudo (`NodeInstall`)
- ☕ **Java complet** : Installation OpenJDK, Maven, Gradle dans l'espace utilisateur (`DevInstall java`)
- 🤖 **Android SDK** : Outils de développement Android sans Android Studio (`DevInstall android`)
- 🦀 **Rust moderne** : Compilateur Rust et Cargo pour développement système (`DevInstall rust`)
- 🐹 **Go rapide** : Langage Go avec modules et outils intégrés (`DevInstall go`)
- 🔄 **rlwrap intelligent** : Installation et utilisation automatique via Homebrew
- 📤 **Git workflow** : Fonction `GF` pour add/commit/push en une commande
- 🧹 **Nettoyage navigateurs** : Déblocage Chrome/Brave (`GoC`, `BrC`)
- 🧼 **Nettoyage dev** : Gestion intelligente des caches et espaces (`cleanup_dev`)

**⚙️ Variables d'environnement :**

- `DISABLE_SETUP` : Contrôle du setup automatique
- `ASYNC_SETUP` : Mode asynchrone (défaut: 0=synchrone pour première installation)
- `AUTO_INSTALL_BREW` : Installation automatique de Homebrew
- `LOGLEVEL` / `PROMPTLEVEL` : Personnalisation de l'affichage

## 💾 Installation

### Installation automatique (Recommandée)

```bash
git clone https://github.com/BekxFR/42_ZSH-Student-Helper.git
cd 42_ZSH-Student-Helper
./Deploy.sh
```

### Options disponibles

```bash
./Deploy.sh         # Installation complète
./Deploy.sh Fonts   # Installation uniquement des fonts Powerline
./Deploy.sh --help  # Afficher l'aide
```

## 🎮 Utilisation de base

### Aliases essentiels

```bash
bp    # Éditer ~/.zshrc
sa    # Recharger la configuration
x     # Clear terminal
```

### Fonctions pratiques

```bash
GF "message"                    # Git add + commit + push
NodeInstall                     # Installer Node.js et npm sans sudo
DevInstall java                 # Installer Java OpenJDK
DevInstall android              # Installer Android SDK
DevInstall rust                 # Installer Rust et Cargo
DevInstall go                   # Installer Go
DevInstall poetry               # Installer Poetry pour Python
DevInstall vscode-ext           # Installer extensions VS Code recommandées
DevInstall ide                  # Configurer environnement IDE complet
DevInstall all                  # Installer tous les outils de développement
PyNormInstall                   # Installer norminette (flake8) pour Python
c_formatter_42_pipInstall       # Installer c_formatter_42 pour VS Code 42 C-Format
discord                         # Télécharger et lancer Discord automatiquement
STmp                           # Ouvrir dossier temporaire dans VS Code
Wcc                            # Compiler avec gcc -Wall -Wextra -Werror
cleanup_dev                     # Nettoyer l'espace de développement
```

### Contrôle de l'environnement

```bash
setup_status   # Afficher l'état de la configuration
log_debug      # Mode debug complet
log_silent     # Mode silencieux
vscode-check   # Diagnostic environnement VS Code (important !)
```

### ⚠️ Note Importante : VS Code

**Avant d'utiliser les fonctions VS Code**, exécutez `vscode-check` pour vérifier que vos paramètres existants sont préservés. Le script utilise un mode non-invasif qui protège votre configuration actuelle. [Voir la documentation détaillée](docs/VSCODE_IMPACT.md).

## 📚 Documentation détaillée

Pour aller plus loin, consultez nos guides spécialisés :

- **[Configuration avancée](docs/CONFIGURATION.md)** - Variables d'environnement, personnalisation
- **[Espace Utilisateur](docs/USER_WORKSPACE.md)** - Système d'isolation utilisateur et espace de travail dynamique
- **[⚠️ Impact VS Code](docs/VSCODE_IMPACT.md)** - Important : Préservation de votre environnement VS Code existant
- **[Outils de Développement](docs/DEVELOPMENT_TOOLS.md)** - Java, Android SDK, Rust, Go et autres outils modernes
- **[Optimisation](docs/OPTIMIZATION.md)** - Stratégies d'économie d'espace, architecture temporaire
- **[Fonctionnalités](docs/FEATURES.md)** - Guide complet des fonctions et aliases
- **[Node.js et npm](docs/NODEJS.md)** - Installation et gestion Node.js sans sudo
- **[Discord Portable](docs/DISCORD.md)** - Installation et utilisation de Discord portable
- **[Personnalisation](docs/CUSTOMIZATION.md)** - Thèmes, couleurs, fonctions personnalisées
- **[Dépannage](docs/TROUBLESHOOTING.md)** - Solutions aux problèmes courants
- **[Architecture](docs/ARCHITECTURE.md)** - Structure du code, développement

## 🤝 Contribution

1. Fork le projet
2. Créer une branche feature (`git checkout -b feature/AmazingFeature`)
3. Commiter vos changements (`git commit -m 'Add AmazingFeature'`)
4. Ouvrir une Pull Request

## 📄 Licence

Projet sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

---

**Créé avec ❤️ pour la communauté 42**  
_Evoluer ensemble dans le partage_
