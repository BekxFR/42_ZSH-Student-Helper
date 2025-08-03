# 🛠️ Fonctionnalités détaillées

## Installation automatique Oh-My-Zsh et plugins

Le script `Deploy.sh` gère l'installation complète d'Oh-My-Zsh et des plugins externes nécessaires :

```bash
# Installation Oh-My-Zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Installation plugins externes requis
local plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

# Plugin zsh-autosuggestions (suggestions basées sur l'historique)
if [[ ! -d "$plugin_dir/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
fi

# Plugin zsh-syntax-highlighting (coloration syntaxique temps réel)
if [[ ! -d "$plugin_dir/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugin_dir/zsh-syntax-highlighting"
fi
```

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

## 💬 Discord Portable

### Installation et lancement automatique

La fonction `discord` permet d'installer et lancer Discord automatiquement dans l'environnement temporaire `/tmp/tmp/discord`. Cette fonctionnalité est particulièrement utile dans un environnement contraint comme celui de l'école 42.

**💡 Astuce :** Utilisation conseillée hors de `VSCode`

📖 **[Guide complet Discord](DISCORD.md)** - Documentation détaillée avec troubleshooting

#### Utilisation de base

```bash
discord          # Installation et lancement automatique
discord_eval     # Version avec eval (alternative si problèmes)
discord_pushd    # Version avec pushd/popd (gestion robuste)
discord_debug    # Lance sans détection VS Code
discord_test     # Test avec feedback complet
```

#### Fonctionnalités principales

- ✅ **Installation automatique** : Télécharge Discord si absent
- ✅ **Détection VS Code** : Flags de compatibilité automatiques
- ✅ **Gestion répertoires** : Retour automatique au dossier d'origine
- ✅ **Installation dans /tmp/tmp** : Économie d'espace utilisateur
- ✅ **Multiple versions** : 3 implémentations pour compatibilité maximale

## 🚀 Node.js et npm - Installation sans sudo

### Installation automatique Node.js et npm

La fonction `NodeInstall` permet d'installer automatiquement Node.js et npm dans l'environnement temporaire `/tmp/tmp` sans nécessiter de privilèges sudo. Cette fonctionnalité utilise le gestionnaire de versions `n` pour une installation flexible et optimisée.

**💡 Avantage :** Installation complète sans droits administrateur, idéale pour l'environnement 42

#### Utilisation de base

```bash
NodeInstall              # Installe la dernière version de Node.js
NodeInstall 20           # Installe Node.js version 20
NodeInstall lts          # Installe la dernière version LTS
NodeInstall 18.17.0      # Installe une version spécifique

# Aliases disponibles
node_install             # Alias court
install_node             # Alias alternatif  
setup_node               # Alias descriptif
```

#### Fonctionnalités principales

- ✅ **Installation sans sudo** : Tout installé dans `/tmp/tmp/node` et `/tmp/tmp/npm-global`
- ✅ **Gestionnaire 'n' automatique** : Installation et configuration de 'n' si nécessaire
- ✅ **Variables d'environnement** : Configuration automatique de `N_PREFIX` et `PATH`
- ✅ **Vérification complète** : Diagnostic détaillé post-installation
- ✅ **Versions flexibles** : Support de `latest`, `lts`, ou versions spécifiques
- ✅ **Configuration permanente** : Intégration avec .zshrc existant
- ✅ **Gestion d'erreurs** : Messages explicites et rollback si nécessaire

#### Ce qui est configuré automatiquement

```bash
export N_PREFIX="/tmp/tmp/node"
export PATH="/tmp/tmp/node/bin:/tmp/tmp/npm-global/bin:$PATH"
npm config set prefix '/tmp/tmp/npm-global'
```

#### Exemple de sortie

```bash
$ NodeInstall
🚀 Installation de Node.js et npm dans /tmp/tmp...
📌 Version demandée: latest
📁 Création des répertoires...
🔧 Configuration des variables d'environnement...
🔍 Vérification de npm...
📦 Installation du gestionnaire de versions Node.js 'n'...
✅ 'n' installé avec succès
🔄 Installation de Node.js latest...
🔄 Mise à jour du cache des commandes...
🧪 Vérification de l'installation...
✅ Installation réussie!
📋 Résumé:
   • Node.js: v24.5.0 (installé dans /tmp/tmp/node)
   • npm: 11.5.1
   • Préfixe npm global: /tmp/tmp/npm-global
✅ Configuration déjà présente dans le .zshrc

🎉 Node.js et npm sont maintenant disponibles sans privilèges sudo!
💡 Commandes utiles:
   • node --version    # Vérifier la version de Node.js
   • npm --version     # Vérifier la version de npm
   • n latest          # Mettre à jour vers la dernière version
   • n <version>       # Installer une version spécifique
   • n ls              # Lister les versions installées
```

#### Avantages dans l'environnement 42

- 🔒 **Pas de sudo requis** : Fonctionne avec les restrictions de droits
- 💾 **Optimisation espace** : Installation dans `/tmp/tmp` (pas dans le quota utilisateur)
- ⚡ **Rapide et efficace** : Une seule commande pour tout configurer
- 🔄 **Réutilisable** : Peut installer différentes versions selon les projets
- 🛡️ **Sécurisé** : Gestion d'erreurs complète et diagnostics détaillés
