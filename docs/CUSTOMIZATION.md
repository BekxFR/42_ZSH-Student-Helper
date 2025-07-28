# 🎨 Personnalisation

## Thèmes et couleurs

Le thème Agnoster supporte la personnalisation complète :

### Installation fonts Powerline

```bash
# Option 1: Via le script Deploy.sh (Recommandée)
./Deploy.sh Fonts

# Option 2: Installation manuelle
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
```

### Configuration thème

```bash
# Dans ~/.zshrc
ZSH_THEME="agnoster"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

# Emojis aléatoires dans prompt
emojis=("⚡️" "🔥" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🌙")
```

## Prompt personnalisé

### Configuration utilisateur par défaut

```bash
export DEFAULT_USER="votre_nom"  # Masquer le nom d'utilisateur dans le prompt
```

### Segments du prompt

Le prompt Agnoster peut être personnalisé via les segments :

```bash
# Fonction build_prompt personnalisée
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
  if [[ $PROMPTLEVEL == 0 ]]; then
    prompt_historyline    # Affiche l'heure
    prompt_time          # Affiche la date
  fi
  prompt_terraform
  prompt_context
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}
```

## Ajout de fonctions personnalisées

### Template pour nouvelles fonctions

```bash
# Dans ~/.zshrc, après la section setup
ma_fonction_custom() {
    local param1="$1"

    logs_info "Exécution fonction personnalisée avec: $param1"

    # Validation des paramètres
    if [[ -z "$param1" ]]; then
        logs_error "Paramètre requis manquant"
        return 1
    fi

    # Votre logique ici

    logs_success "Fonction terminée avec succès"
}

# Alias personnalisé
alias ma_cmd="ma_fonction_custom"
```

## Personnalisation des plugins

### Configuration autosuggestions

```bash
# Style des suggestions automatiques
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

# Stratégie de suggestions (history, completion, match_prev_cmd)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
```

### Configuration syntax highlighting

```bash
# Dans ~/.zshrc après le chargement des plugins
# Personnalisation des couleurs
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
```

## Variables d'environnement personnalisées

```bash
# Ajout de variables personnalisées dans ~/.zshrc
export MON_VARIABLE_CUSTOM="valeur"
export MON_PATH_CUSTOM="/mon/chemin/custom"

# Ajout au PATH si nécessaire
export PATH="$MON_PATH_CUSTOM:$PATH"
```

## Configuration avancée du terminal

### Support des couleurs étendues

```bash
# Forcer le support 256 couleurs
export TERM="xterm-256color"

# Configuration locale pour éviter les problèmes d'encodage
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
```
