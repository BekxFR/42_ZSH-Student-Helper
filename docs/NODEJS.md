# 🚀 Node.js et npm - Guide complet

## 🎯 Vue d'ensemble

Ce guide détaille l'utilisation de la fonction `NodeInstall` qui permet d'installer et gérer Node.js et npm dans l'environnement 42 sans privilèges sudo.

## ⚡ Installation rapide

```bash
# Installation de la dernière version
NodeInstall

# Installation d'une version spécifique
NodeInstall 20
NodeInstall 18.17.0
NodeInstall lts
```

## 🔧 Fonctionnement technique

### Architecture d'installation

```
/tmp/tmp/
├── node/                  # Installation Node.js (N_PREFIX)
│   ├── bin/
│   │   ├── node
│   │   ├── npm
│   │   └── npx
│   └── lib/node_modules/
└── npm-global/            # Packages npm globaux
    ├── bin/
    └── lib/node_modules/
```

### Variables d'environnement configurées

```bash
export N_PREFIX="/tmp/tmp/node"
export PATH="/tmp/tmp/node/bin:/tmp/tmp/npm-global/bin:$PATH"
```

### Configuration npm

```bash
npm config set prefix '/tmp/tmp/npm-global'
```

## 🛠️ Utilisation avancée

### Gestion des versions avec 'n'

```bash
# Lister les versions installées
n ls

# Installer une version spécifique
n 18.17.0
n 20.10.0

# Passer à la dernière version
n latest

# Passer à la dernière LTS
n lts

# Supprimer une version
n rm 18.17.0

# Afficher la version active
n --version
```

### Installation de packages globaux

```bash
# Les packages s'installent automatiquement dans /tmp/tmp/npm-global
npm install -g create-react-app
npm install -g @angular/cli
npm install -g typescript
npm install -g nodemon

# Vérifier les packages installés
npm list -g --depth=0
```

### Projets locaux

```bash
# Dans vos projets, npm fonctionne normalement
mkdir mon-projet
cd mon-projet
npm init -y
npm install express
node app.js
```

## 🔍 Diagnostic et dépannage

### Vérification de l'installation

```bash
# Vérifier les versions
node --version
npm --version

# Vérifier la configuration npm
npm config get prefix
npm config get registry

# Vérifier les chemins
which node
which npm
echo $N_PREFIX
echo $PATH
```

### Problèmes courants

#### 1. npm non trouvé après installation

```bash
# Recharger la configuration
hash -r
source ~/.zshrc

# Vérifier le PATH
echo $PATH | grep -o '/tmp/tmp/node/bin'
```

#### 2. Permission denied lors d'installations globales

```bash
# Vérifier la configuration du préfixe
npm config get prefix
# Doit retourner : /tmp/tmp/npm-global

# Reconfigurer si nécessaire
npm config set prefix '/tmp/tmp/npm-global'
```

#### 3. Version de Node.js incorrecte

```bash
# Forcer l'utilisation de la bonne version
n use 20.10.0

# Réinitialiser le cache
hash -r
```

## 📊 Comparaison avec installation système

| Aspect | Installation système | NodeInstall |
|--------|---------------------|-------------|
| Privilèges | Sudo requis | Aucun privilège |
| Espace utilisé | Quota utilisateur | `/tmp/tmp` |
| Versions multiples | Complexe | Simple avec `n` |
| Configuration | Manuelle | Automatique |
| Portabilité | Limitée | Totale |

## 🎨 Cas d'usage typiques

### Développement web

```bash
# Installation complète pour développement web
NodeInstall lts
npm install -g create-react-app
npm install -g @vue/cli
npm install -g live-server

# Création d'un projet React
npx create-react-app mon-app
cd mon-app
npm start
```

### Développement backend

```bash
# Installation pour backend Node.js
NodeInstall 20
npm install -g nodemon
npm install -g pm2

# Projet Express
mkdir api-server
cd api-server
npm init -y
npm install express cors dotenv
```

### Outils de build

```bash
# Installation d'outils de build
NodeInstall latest
npm install -g webpack
npm install -g parcel
npm install -g vite
```

## 🔗 Intégration avec d'autres outils

### Avec VS Code

```bash
# Lancer VS Code avec l'environnement Node.js configuré
STmp mon-projet-node
# VS Code s'ouvre avec le bon PATH et les bonnes variables d'environnement
```

### Avec Git

```bash
# Workflow complet avec Git
NodeInstall
npm install -g @commitlint/cli
# Configuration de hooks Git avec Node.js
```

### Avec Homebrew

```bash
# NodeInstall fonctionne parfaitement avec l'environnement Homebrew
# Les deux systèmes utilisent des PATH séparés
```

## 📈 Optimisation des performances

### Cache npm

```bash
# Le cache npm est automatiquement configuré dans /tmp/tmp
npm config get cache
# Retourne : /tmp/tmp/.npm

# Nettoyage si nécessaire
npm cache clean --force
```

### Optimisation des installations

```bash
# Installation plus rapide (sans audit)
npm install --no-audit

# Installation production uniquement
npm install --production

# Installation avec cache partagé
npm install --prefer-offline
```

## 🛡️ Sécurité et bonnes pratiques

### Audit des packages

```bash
# Vérifier les vulnérabilités
npm audit
npm audit fix

# Mise à jour des packages
npm update
npm outdated
```

### Gestion des versions

```bash
# Utiliser .nvmrc pour la cohérence d'équipe
echo "20.10.0" > .nvmrc
n $(cat .nvmrc)
```

## 🔄 Migration et sauvegarde

### Sauvegarde de l'environnement

```bash
# Lister les packages globaux installés
npm list -g --depth=0 > packages-globaux.txt

# Sauvegarder la version Node.js
node --version > node-version.txt
```

### Restauration

```bash
# Réinstaller l'environnement
NodeInstall $(cat node-version.txt)

# Réinstaller les packages globaux
cat packages-globaux.txt | grep -E '^[├└]' | sed 's/[├└]─ //' | xargs npm install -g
```

## 📚 Ressources supplémentaires

- [Documentation officielle Node.js](https://nodejs.org/docs/)
- [Documentation npm](https://docs.npmjs.com/)
- [Gestionnaire n](https://github.com/tj/n)
- [Bonnes pratiques Node.js](https://github.com/goldbergyoni/nodebestpractices)

---

**💡 Conseil :** Cette installation est idéale pour l'environnement 42 car elle respecte les contraintes de stockage tout en offrant un environnement de développement complet et moderne.
