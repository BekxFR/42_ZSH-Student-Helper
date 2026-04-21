# 🛡️ Sécurité de l'Environnement de Développement

## ⚠️ Variables à Risque Élevé

Ce document décrit les variables d'environnement qui peuvent **affecter vos configurations existantes** et comment les contrôler.

### 🚨 Impact Critique - Variables XDG

```bash
# CES VARIABLES AFFECTENT TOUTES LES APPLICATIONS!
XDG_CONFIG_HOME="/tmp/$USER/.config"    # Redirection de ~/.config
XDG_DATA_HOME="/tmp/$USER/.local/share" # Redirection de ~/.local/share
XDG_CACHE_HOME="/tmp/$USER/.cache"      # Redirection de ~/.cache
```

**Impact:** Toutes les applications utilisant les standards XDG (la plupart des applications Linux modernes) vont créer leurs configurations dans votre workspace temporaire au lieu de votre dossier personnel.

**Applications affectées:** Firefox, Chrome, Thunderbird, LibreOffice, GNOME, KDE, etc.

### 🔶 Impact Modéré - Outils de Développement

```bash
# Variables Java
JAVA_HOME="/tmp/$USER/java"

# Variables Python
PYTHONUSERBASE="/tmp/$USER"
PIP_USER="1"

# Variables Docker
DOCKER_CONFIG="/tmp/$USER/.docker"

# Variables IDE
IDEA_HOME="/tmp/$USER/.idea"
```

**Impact:** Affecte uniquement les outils de développement spécifiques.

### ✅ Impact Faible - Variables Isolées

```bash
# Ces variables sont généralement sûres
CARGO_HOME="/tmp/$USER/.cargo"     # Rust uniquement
RUSTUP_HOME="/tmp/$USER/.rustup"   # Rust uniquement
GOPATH="/tmp/$USER/go"             # Go uniquement
ANDROID_HOME="/tmp/$USER/android-sdk" # Android uniquement
```

## 🎛️ Système de Contrôle

### Variables de Contrôle

Utilisez ces variables pour activer/désactiver les fonctionnalités :

```bash
# Contrôles disponibles (0=désactivé, 1=activé)
export STUDENT_USE_PORTABLE_JAVA=0      # Java portable
export STUDENT_USE_PORTABLE_PYTHON=0    # Python portable
export STUDENT_USE_PORTABLE_DOCKER=0    # Docker portable
export STUDENT_USE_PORTABLE_VAGRANT=0   # Vagrant portable
export STUDENT_USE_PORTABLE_VSCODE=0    # VS Code : définit uniquement VSCODE_PORTABLE_EXTENSIONS
                                         # pour l'alias opt-in `code-portable`. Le wrapper `code()`
                                         # injectant --extensions-dir/--user-data-dir a été retiré
                                         # (forçait la réinstallation d'extensions à chaque poste).
                                         # Pour les caches seulement, voir STUDENT_USE_PORTABLE_CACHE.
export STUDENT_USE_PORTABLE_IDEA=0      # IntelliJ portable
export STUDENT_USE_PORTABLE_CLAUDE=0    # Claude Code portable (symlinks ~/.local/share/claude)
export STUDENT_USE_PORTABLE_CACHE=0     # Caches VS Code régénérables (Crashpad, GPUCache, logs) - zéro impact
export STUDENT_USE_PORTABLE_XDG=0       # Variables XDG (DANGEREUX!)
```

> **Compatibilité OS** : l'ensemble du projet supporte Ubuntu 20.04+ **et Fedora**. Le `$HOME` étant partagé NFS entre postes, tous les symlinks portables ciblent `/tmp/$USER` (path déterministe) pour rester valides lors d'une bascule Ubuntu↔Fedora.

### Modes de Configuration

#### Mode Sécurisé (Recommandé)

```bash
safe_setup
```

- ✅ Préserve toutes vos configurations existantes
- ✅ Active uniquement Node.js, Rust, Go, Android
- ✅ Aucun risque de perte de configuration

#### Mode Portable Complet (Avancé)

```bash
portable_setup
```

- ⚠️ Peut affecter vos configurations existantes
- 🚀 Isole complètement votre environnement de développement
- 🔄 Nécessite redémarrage du terminal

## 🔍 Diagnostic de l'Environnement

### Commande de Diagnostic

```bash
env_diagnostic
```

Cette commande affiche :

- État de toutes les variables d'environnement
- Niveau d'impact actuel
- Avertissements de sécurité
- Recommandations de configuration

### Exemple de Sortie

```
=== DIAGNOSTIC ENVIRONNEMENT DÉVELOPPEMENT ===

📁 Variables XDG (Impact élevé!):
  XDG_CONFIG_HOME: NON DÉFINI (utilise ~/.config)
  XDG_DATA_HOME: NON DÉFINI (utilise ~/.local/share)
  XDG_CACHE_HOME: NON DÉFINI (utilise ~/.cache)

📊 Analyse d'impact:
  Niveau d'impact: FAIBLE
  Nombre d'avertissements: 0
```

## 🚨 Scénarios de Récupération

### Si vous avez perdu vos configurations

#### 1. Configurations XDG perdues

```bash
# Désactiver les variables XDG
export STUDENT_USE_PORTABLE_XDG=0

# Redémarrer le terminal
exec zsh

# Vos configurations devraient réapparaître dans ~/.config
```

#### 2. Configuration Java/Python perdue

```bash
# Désactiver Java portable
export STUDENT_USE_PORTABLE_JAVA=0
export STUDENT_USE_PORTABLE_PYTHON=0

# Redémarrer le terminal
exec zsh
```

#### 3. Récupération complète

```bash
# Retour aux paramètres système complets
safe_setup

# Redémarrer le terminal
exec zsh
```

## 📋 Liste de Vérification de Sécurité

Avant d'activer le mode portable complet :

- [ ] **Sauvegarder** vos configurations importantes
- [ ] **Tester** avec le mode sécurisé d'abord
- [ ] **Vérifier** quelles applications vous utilisez quotidiennement
- [ ] **Comprendre** comment désactiver si nécessaire
- [ ] **Documenter** vos variables d'environnement actuelles

### Sauvegarde Préventive

```bash
# Sauvegarder les variables actuelles
env | grep -E "(JAVA_HOME|PYTHON|XDG_|DOCKER_)" > ~/backup_env_vars.txt

# Sauvegarder les configurations importantes
cp -r ~/.config ~/.config.backup.$(date +%Y%m%d)
cp -r ~/.local/share ~/.local/share.backup.$(date +%Y%m%d)
```

## 🔧 Configuration Recommandée

### Pour Débutants

```bash
# Dans ~/.zshrc, ajoutez AVANT de sourcer la configuration 42
export STUDENT_USE_PORTABLE_XDG=0       # Sécurité maximale
export STUDENT_USE_PORTABLE_JAVA=0      # Utiliser Java système
export STUDENT_USE_PORTABLE_PYTHON=0    # Utiliser Python système
```

### Pour Utilisateurs Avancés

```bash
# Isolation complète avec contrôle
export STUDENT_USE_PORTABLE_JAVA=1      # Java isolé
export STUDENT_USE_PORTABLE_PYTHON=1    # Python isolé
export STUDENT_USE_PORTABLE_XDG=0       # Garder XDG système (sécurité)
```

### Pour Développeurs Expérimentés

```bash
# Isolation totale (testez d'abord!)
portable_setup
```

## 📞 Support

Si vous rencontrez des problèmes :

1. **Diagnostic immédiat:** `env_diagnostic`
2. **Mode de récupération:** `safe_setup`
3. **Redémarrage propre:** `exec zsh`
4. **Restauration manuelle:** Restaurer depuis vos sauvegardes

## 🔄 Mise à Jour de la Configuration

Quand vous modifiez les variables de contrôle, **redémarrez toujours votre terminal** :

```bash
exec zsh
```

Ceci garantit que toutes les variables sont correctement appliquées.
