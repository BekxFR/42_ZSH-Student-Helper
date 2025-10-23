# 🎛️ Guide d'Activation des Variables Portables

## 🚀 Méthodes d'Activation Rapides

### Pour XDG Uniquement (Variables d'Environnement Système)

#### Option 1: Activation Interactive avec Avertissement

```bash
enable_xdg
```

Cette commande :

- ✅ Affiche un avertissement sur l'impact
- ✅ Demande confirmation
- ✅ Active les variables XDG pour la session
- ✅ Donne les instructions pour rendre permanent

#### Option 2: Activation Manuelle Directe

```bash
# Activation immédiate
export STUDENT_USE_PORTABLE_XDG=1
exec zsh
```

#### Option 3: Activation Permanente

```bash
# Ajouter à votre ~/.zshrc
echo 'export STUDENT_USE_PORTABLE_XDG=1' >> ~/.zshrc
exec zsh
```

### Configuration Interactive Complète

```bash
configure_portable
```

Cette commande permet de :

- 🎛️ Choisir quelles fonctionnalités activer
- ⚠️ Voir les avertissements pour chaque option
- 💾 Sauvegarder la configuration automatiquement
- 📊 Voir un résumé de la configuration

## 📋 Commandes de Gestion

### Vérifier l'État Actuel

```bash
portable_status
# ou
safety_check
```

### Désactiver Toutes les Variables Portables

```bash
disable_all_portable
```

### Diagnostic Complet

```bash
safety_check
```

## 🎯 Exemples d'Usage Pratiques

### Cas 1: Activer Uniquement XDG (Maximum d'Impact)

```bash
# Interactive avec avertissement
enable_xdg

# Ou directement
export STUDENT_USE_PORTABLE_XDG=1
exec zsh
```

### Cas 2: Activer Java + Python (Développement)

```bash
export STUDENT_USE_PORTABLE_JAVA=1
export STUDENT_USE_PORTABLE_PYTHON=1
exec zsh
```

### Cas 3: Configuration Complète Interactive

```bash
configure_portable
# Suivre les instructions à l'écran
```

### Cas 4: Retour au Mode Sécurisé

```bash
disable_all_portable
exec zsh
```

## ⚠️ Impact des Variables XDG

### Qu'est-ce que les Variables XDG ?

Les variables XDG (X Desktop Group) définissent où les applications stockent :

- **XDG_CONFIG_HOME** : Fichiers de configuration (`~/.config`)
- **XDG_DATA_HOME** : Données d'application (`~/.local/share`)
- **XDG_CACHE_HOME** : Fichiers de cache (`~/.cache`)

### Applications Affectées par XDG_CONFIG_HOME

- 🌐 **Navigateurs** : Firefox, Chrome, Brave
- 📝 **Éditeurs** : VS Code, Sublime Text, Vim
- 🖥️ **Environnements** : GNOME, KDE, XFCE
- 📄 **Suite Office** : LibreOffice, OnlyOffice
- 🎵 **Média** : VLC, Audacity
- 🔧 **Outils** : Git, SSH, GPG

### Comportement avec XDG Portable Activé

```bash
# AVANT (normal)
~/.config/Code/User/settings.json
~/.config/git/config

# APRÈS (avec XDG portable)
/tmp/tmp/USERNAME/.config/Code/User/settings.json
/tmp/tmp/USERNAME/.config/git/config
```

## 🛡️ Recommandations de Sécurité

### ✅ Configuration Recommandée pour Débutants

```bash
# Activer uniquement les outils sûrs
export STUDENT_USE_PORTABLE_JAVA=1
export STUDENT_USE_PORTABLE_PYTHON=1
# NE PAS activer XDG
```

### ⚠️ Configuration pour Utilisateurs Avancés

```bash
# Test temporaire des variables XDG
export STUDENT_USE_PORTABLE_XDG=1
exec zsh
# Tester vos applications
# Si problème : disable_all_portable
```

### 🔧 Configuration pour Développeurs Expérimentés

```bash
configure_portable
# Choisir selon les besoins du projet
```

## 🔄 Scénarios de Récupération

### Si vos configurations semblent "perdues"

```bash
# 1. Vérifier l'état
portable_status

# 2. Désactiver toutes les variables portables
disable_all_portable

# 3. Redémarrer le terminal
exec zsh

# 4. Vos configurations devraient réapparaître
```

### Si vous voulez basculer temporairement

```bash
# Session 1: Mode portable
export STUDENT_USE_PORTABLE_XDG=1
exec zsh

# Session 2: Mode normal
export STUDENT_USE_PORTABLE_XDG=0
exec zsh
```

## 📚 Liens Utiles

- **Documentation complète** : [ENVIRONMENT_SAFETY.md](ENVIRONMENT_SAFETY.md)
- **Guide VS Code** : [VSCODE_IMPACT.md](VSCODE_IMPACT.md)
- **Outils de développement** : [DEVELOPMENT_TOOLS.md](DEVELOPMENT_TOOLS.md)

## 🎯 Résumé des Commandes Essentielles

| Commande               | Description                        |
| ---------------------- | ---------------------------------- |
| `enable_xdg`           | Active XDG avec avertissement      |
| `configure_portable`   | Configuration interactive complète |
| `portable_status`      | Affiche l'état actuel              |
| `disable_all_portable` | Désactive tout                     |
| `safety_check`         | Diagnostic de sécurité             |

**💡 Conseil :** Commencez toujours par `configure_portable` pour une approche guidée et sécurisée !
