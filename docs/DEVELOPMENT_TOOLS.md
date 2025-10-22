# Outils de Développement Modernes

## 🎯 Vue d'ensemble

Cette documentation couvre l'installation et la configuration d'outils de développement modernes dans l'environnement 42_ZSH Student Helper, permettant aux étudiants de développer dans tous les langages populaires sans restrictions d'espace home.

## 🛠️ Outils Supportés

### ☕ Java et Écosystème JVM

- **OpenJDK** : Java Development Kit
- **Maven** : Gestionnaire de dépendances Java
- **Gradle** : Outil de build moderne

### 🤖 Développement Android

- **Android SDK** : Outils de développement Android
- **Command Line Tools** : Interface en ligne de commande
- **Platform Tools** : ADB, fastboot, etc.

### 🦀 Rust

- **Rust Compiler** : Langage système moderne
- **Cargo** : Gestionnaire de packages Rust
- **Rustup** : Gestionnaire de versions Rust

### 🐹 Go

- **Go Compiler** : Langage de Google
- **Go Modules** : Système de modules intégré
- **Go Tools** : Outils de développement Go

## 🚀 Installation Rapide

### Installation Individuelle

```bash
# Java (version par défaut: 17)
DevInstall java

# Java version spécifique
DevInstall java 11

# Android SDK
DevInstall android

# Rust
DevInstall rust

# Go (version par défaut: 1.21.4)
DevInstall go

# Go version spécifique
DevInstall go 1.20.0
```

### Installation Complète

```bash
# Installe tous les outils de développement
DevInstall all
```

## 📂 Structure des Répertoires

Après installation, votre espace utilisateur contient :

```
$STUDENT_WORKSPACE/
├── java/                    # OpenJDK installation
├── maven/                   # Maven (si installé)
├── gradle/                  # Gradle (si installé)
├── .gradle/                 # Cache Gradle
├── android-sdk/             # Android SDK
│   ├── cmdline-tools/
│   ├── platform-tools/
│   └── platforms/
├── .android/                # Configuration Android
├── .cargo/                  # Rust Cargo
├── .rustup/                 # Rust toolchain
├── go-install/              # Go binaires
├── go/                      # GOPATH workspace
│   ├── src/
│   ├── pkg/
│   └── bin/
├── .cache/                  # Caches généraux
└── node/                    # Node.js (existant)
```

## ⚙️ Variables d'Environnement

Les variables suivantes sont automatiquement configurées :

### Java

```bash
export JAVA_HOME="$STUDENT_WORKSPACE/java"
export MAVEN_HOME="$STUDENT_WORKSPACE/maven"
export GRADLE_HOME="$STUDENT_WORKSPACE/gradle"
export GRADLE_USER_HOME="$STUDENT_WORKSPACE/.gradle"
```

### Android

```bash
export ANDROID_HOME="$STUDENT_WORKSPACE/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_USER_HOME="$STUDENT_WORKSPACE/.android"
```

### Rust

```bash
export CARGO_HOME="$STUDENT_WORKSPACE/.cargo"
export RUSTUP_HOME="$STUDENT_WORKSPACE/.rustup"
```

### Go

```bash
export GOPATH="$STUDENT_WORKSPACE/go"
export GOCACHE="$STUDENT_WORKSPACE/.cache/go-build"
export GOMODCACHE="$STUDENT_WORKSPACE/go/pkg/mod"
```

## 💡 Exemples d'Utilisation

### Développement Java

```bash
# Installation
DevInstall java

# Vérification
java -version
javac -version

# Projet Maven
cd $STUDENT_WORKSPACE
mkdir mon-projet-java
cd mon-projet-java
# Utiliser Maven ou Gradle normalement
```

### Développement Android

```bash
# Installation
DevInstall android

# Installation des packages SDK
sdkmanager "platform-tools" "platforms;android-33"

# Vérification
adb version
```

### Développement Rust

```bash
# Installation
DevInstall rust

# Nouveau projet
cargo new mon-projet-rust
cd mon-projet-rust
cargo build
cargo run
```

### Développement Go

```bash
# Installation
DevInstall go

# Nouveau module
cd $GOPATH/src
mkdir mon-projet-go
cd mon-projet-go
go mod init mon-projet-go
```

## 🧹 Gestion de l'Espace

### Nettoyage Automatique

```bash
# Nettoie les caches et fichiers temporaires
cleanup_dev
```

### Monitoring de l'Espace

```bash
# Voir l'utilisation actuelle
du -sh $STUDENT_WORKSPACE

# Détail par répertoire
du -sh $STUDENT_WORKSPACE/*
```

### Optimisation

- **Gradle** : Les caches de build sont automatiquement nettoyés
- **Go** : Les modules cachés sont gérés intelligemment
- **Rust** : Les artefacts de compilation sont optimisés
- **Android** : Seuls les outils essentiels sont téléchargés

## 🚨 Limitations et Considérations

### Espace Disque

- **Java** : ~150MB par version
- **Android SDK** : ~500MB minimum, peut atteindre plusieurs GB
- **Rust** : ~100MB
- **Go** : ~120MB par version

### Performance

- **Première installation** : Peut prendre 5-15 minutes selon la connexion
- **Compilations** : Plus rapides car tout est local
- **Caches** : Amélioration progressive des performances

### Sécurité

- **Téléchargements** : Sources officielles uniquement
- **Permissions** : Aucun privilège sudo requis
- **Isolation** : Chaque utilisateur a son environnement

## 📋 Dépannage

### Problèmes Courants

**Java non trouvé après installation :**

```bash
# Recharger l'environnement
source ~/.zshrc

# Vérifier la variable
echo $JAVA_HOME
```

**Android SDK inaccessible :**

```bash
# Vérifier les permissions
ls -la $ANDROID_HOME

# Reconfigurer si nécessaire
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
```

**Cargo command not found :**

```bash
# Recharger Rust
source $CARGO_HOME/env

# Ou redémarrer le terminal
```

### Réinstallation Propre

```bash
# Supprimer complètement un outil (exemple: Java)
rm -rf $STUDENT_WORKSPACE/java
rm -rf $STUDENT_WORKSPACE/.gradle

# Réinstaller
DevInstall java
```

## 🎯 Cas d'Usage Avancés

### Développement Mobile Complet

```bash
# Installation complète Android
DevInstall android
DevInstall java

# Installation des outils nécessaires
sdkmanager "build-tools;33.0.0" "platforms;android-33"
sdkmanager "system-images;android-33;google_apis;x86_64"
```

### Développement Backend Multi-Langage

```bash
# Stack complète
DevInstall all
NodeInstall  # Déjà présent

# Maintenant vous avez : Java, Go, Rust, Node.js, Python/Poetry
```

### Configuration IDE Complète

```bash
# Configuration VS Code avec extensions
DevInstall vscode-ext

# Setup environnement IDE complet
DevInstall ide

# Python avec Poetry pour gestion des dépendances
DevInstall poetry
```

### Variables d'Environnement Étendues

**IDE et Éditeurs :**

```bash
export VSCODE_EXTENSIONS="$STUDENT_WORKSPACE/.vscode-extensions"
export IDEA_HOME="$STUDENT_WORKSPACE/.idea"
```

**Python Avancé :**

```bash
export POETRY_HOME="$STUDENT_WORKSPACE/.poetry"
export CONDA_PKGS_DIRS="$STUDENT_WORKSPACE/.conda/pkgs"
export PIP_USER="1"
```

**Standards XDG :**

```bash
export XDG_CONFIG_HOME="$STUDENT_WORKSPACE/.config"
export XDG_DATA_HOME="$STUDENT_WORKSPACE/.local/share"
```

### Projets Étudiants 42

- **C/C++** : Compilateurs déjà présents système
- **Python** : Environnement optimisé déjà configuré
- **Web** : Node.js, npm pour frameworks modernes
- **Mobile** : Android SDK pour projets mobiles
- **Système** : Rust pour projets bas niveau

---

**Note** : Cette configuration permet un développement professionnel complet tout en respectant les contraintes d'espace de l'école 42.
