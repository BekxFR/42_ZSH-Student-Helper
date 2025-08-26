# 🔧 Dépannage

## Problèmes fréquents

### Fonts Powerline manquantes

**Symptômes** : Caractères étranges dans le prompt, carrés ou points d'interrogation

```bash
# Solution 1: Via le script Deploy.sh (Recommandée)
./Deploy.sh Fonts

# Solution 2: Installation manuelle
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Solution 3: Vérification des fonts installées
fc-list | grep -i powerline
```

### Homebrew non accessible

**Symptômes** : `brew: command not found`

```bash
# Diagnostic
ls -la /tmp/tmp/homebrew/bin/brew
echo $PATH | grep -o '/tmp/tmp/homebrew/bin'

# Solutions
# 1. Réinstallation Homebrew
~/42/42_ZSH_Scripts/BrewInstaller.sh

# 2. Rechargement configuration
source ~/.zshrc

# 3. Configuration manuelle PATH (temporaire)
export PATH="/tmp/tmp/homebrew/bin:$PATH"
```

### Variables d'environnement non configurées

**Symptômes** : Comportement incohérent des alias de contrôle

```bash
# Vérification variables
setup_status
echo "LOGLEVEL: ${LOGLEVEL:-NON_DEFINI}"
echo "ASYNC_SETUP: ${ASYNC_SETUP:-NON_DEFINI}"
echo "AUTO_INSTALL_BREW: ${AUTO_INSTALL_BREW:-NON_DEFINI}"

# Solution : Recharger la configuration
source ~/.zshrc

# Si le problème persiste, vérifier que les exports sont présents dans ~/.zshrc
grep -n "export.*ASYNC_SETUP\|export.*AUTO_INSTALL_BREW\|export.*DISABLE_SETUP" ~/.zshrc
```

## Logs de débogage

### Activation debug complet

```bash
# Activation temporaire
log_debug && source ~/.zshrc

# Activation permanente (déconseillée)
echo "export LOGLEVEL=4" >> ~/.zshrc
```

### Commandes de diagnostic

```bash
# Vérification setup
setup_status                    # État variables configuration
log_status                      # Niveau de log actuel
prompt_level                    # Configuration prompt

# Vérification environnement
which brew                      # Localisation brew
brew --version 2>/dev/null || echo "Brew non disponible"
echo $PATH | tr ':' '\n' | grep -E "(homebrew|tmp/tmp)"
```

## Problèmes spécifiques

### Setup asynchrone qui ne fonctionne pas

```bash
# Forcer le mode synchrone pour déboguer
setup_sync
source ~/.zshrc

# Vérifier les processus en arrière-plan
jobs

# Retour au mode asynchrone
setup_async
```

### Norminette/flake8 non trouvé

```bash
# Diagnostic
which flake8
pip3 show flake8 2>/dev/null || echo "flake8 non installé"

# Solutions
# 1. Installation via fonction intégrée
PyNormInstall

# 2. Installation manuelle
pip3 install --user flake8

# 3. Configuration manuelle alias
alias norminette="$(command -v flake8)"
```

### Fonction rlwrap qui échoue

```bash
# Diagnostic
which brew
brew list | grep rlwrap 2>/dev/null || echo "rlwrap non installé"

# Solution automatique
rlwrap --version  # Déclenche l'installation automatique si brew disponible

# Installation manuelle
brew install rlwrap
```

### Rollback inattendu lors de l'installation

**Explication des signaux** :

- `ERR` : Erreur bash (commande échouée avec `set -e`)
- `SIGINT` : Interruption clavier (Ctrl+C)
- `SIGTERM` : Signal de terminaison système
- ~~`EXIT`~~ : Se déclenche à chaque sortie, même réussie

### c_formatter_42 non installé - Extension VS Code 42 C-Format

**Symptômes** : Extension VS Code "42 C-Format" ne fonctionne pas, erreurs de formatage C

```bash
# Diagnostic
pip3 show c_formatter_42 2>/dev/null || echo "c_formatter_42 non installé"
which pip3 || echo "pip3 non disponible"

# Solutions
# 1. Installation automatique via fonction intégrée
c_formatter_42_pipInstall

# 2. Installation manuelle
pip3 install c_formatter_42

# 3. Vérification installation
pip3 show c_formatter_42
c_formatter_42 --version 2>/dev/null || echo "Installation échouée"

# 4. Si pip3 n'est pas disponible
# Sur les systèmes 42, installer python3-pip via gestionnaire de paquets
# ou utiliser l'environnement Python dans /tmp/tmp si configuré
```

**Note** : Cette extension améliore significativement le workflow de développement C à l'école 42 en formatant automatiquement le code selon la norme.

## Reset complet

### Sauvegarde et reset

```bash
# Sauvegarde configuration actuelle
cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)

# Sauvegarde dossier 42
cp -r ~/42 ~/42.backup.$(date +%Y%m%d_%H%M%S) 2>/dev/null || true

# Reset environnement temporaire
rm -rf /tmp/tmp

# Recopie configuration propre
cp ~/42_ZSH-Student-Helper/data/.zshrc ~/.zshrc
cp ~/42_ZSH-Student-Helper/scripts/BrewInstaller.sh ~/42/42_ZSH_Scripts/

# Rechargement
source ~/.zshrc
```

### Reset partiel (préservation utilisateur)

```bash
# Reset seulement l'environnement temporaire
rm -rf /tmp/tmp

# Force la recréation
unset DISABLE_SETUP
export ASYNC_SETUP=0  # Mode synchrone pour voir les erreurs
source ~/.zshrc
```

## Logs et traces

### Localisation des logs

```bash
# Logs du script de déploiement
tail -f /tmp/42_zsh_deploy.log
```

### Nettoyage logs

```bash
# Suppression logs temporaires
rm -f /tmp/42_zsh_deploy.log
```
