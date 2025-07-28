# ⚙️ Configuration avancée

## Système de logs configurables

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

## Personnalisation du prompt

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

## Variables d'environnement

Ces variables ont été ajoutées pour améliorer la cohérence :

```bash
# Contrôle setup automatique
export DISABLE_SETUP=${DISABLE_SETUP:-0}     # Valeur par défaut: setup automatique activé
export ASYNC_SETUP=${ASYNC_SETUP:-1}         # Valeur par défaut: setup asynchrone activé
export AUTO_INSTALL_BREW=${AUTO_INSTALL_BREW:-1}  # Valeur par défaut: installation automatique de Homebrew activée

# Contrôle prompt
export PROMPTLEVEL=${PROMPTLEVEL:-0}          # Valeur par défaut: prompt long (0=complet avec date+heure, 1=minimal)

# Contrôle logs
export LOGLEVEL=${LOGLEVEL:-0}                # Valeur par défaut: mode silencieux
```

### Aliases de contrôle

```bash
# Contrôle des logs
alias log_silent='export LOGLEVEL=0 && echo "🔇 Mode silencieux activé"'
alias log_errors='export LOGLEVEL=1 && echo "❌ Affichage des erreurs seulement"'
alias log_warnings='export LOGLEVEL=2 && echo "⚠️ Affichage des warnings et erreurs"'
alias log_info='export LOGLEVEL=3 && echo "ℹ️ Affichage des infos, warnings et erreurs"'
alias log_debug='export LOGLEVEL=4 && echo "🐛 Mode debug activé (tous les logs)"'
alias log_status='echo "📊 Niveau de log actuel: $LOGLEVEL"'

# Contrôle du prompt
alias prompt_short='export PROMPTLEVEL=1 && echo "🐛 Affichage du prompt version réduite"'
alias prompt_long='export PROMPTLEVEL=0 && echo "🐛 Affichage du prompt version longue"'
alias prompt_level='echo "📊 Niveau du prompt actuel: $PROMPTLEVEL (1 = short, 0 = long)"'

# Contrôle du setup
alias setup_sync='export ASYNC_SETUP=0 && echo "🔄 Setup synchrone activé"'
alias setup_async='export ASYNC_SETUP=1 && echo "⚡ Setup asynchrone activé"'
alias setup_off='export DISABLE_SETUP=1 && echo "🚫 Setup automatique désactivé"'
alias setup_on='export DISABLE_SETUP=0 && echo "✅ Setup automatique activé"'
alias brew_auto_install_off='export AUTO_INSTALL_BREW=0 && echo "🚫 Installation automatique de Homebrew désactivée"'
alias brew_auto_install_on='export AUTO_INSTALL_BREW=1 && echo "✅ Installation automatique de Homebrew activée"'
alias setup_status='echo "📊 ASYNC_SETUP: ${ASYNC_SETUP:-1}, AUTO_INSTALL_BREW: ${AUTO_INSTALL_BREW:-1}, DISABLE_SETUP: ${DISABLE_SETUP:-0}"'
```

## Configuration PATH optimisée

### Corrections récentes

Le système configure le PATH pour Homebrew :

```bash
# Configuration automatique dans setup_environment()
setup_environment() {
    local homebrew_dir="/tmp/tmp/homebrew"

    # Configuration Homebrew avec PATH correct
    if [[ -d "$homebrew_dir/bin" ]]; then
        if [[ -x "$homebrew_dir/bin/brew" ]]; then
            if eval "$($homebrew_dir/bin/brew shellenv)" 2>/dev/null; then
                logs_debug "Environnement Homebrew configuré via shellenv"
            else
                logs_warning "Erreur lors de la configuration de l'environnement Homebrew"
                export PATH="$homebrew_dir/bin:$PATH"
                logs_debug "Fallback: PATH Homebrew ajouté manuellement"
            fi
        else
            logs_info "Homebrew non installé, ajout du PATH uniquement"
            export PATH="$homebrew_dir/bin:$PATH"
        fi
    fi
}
```
