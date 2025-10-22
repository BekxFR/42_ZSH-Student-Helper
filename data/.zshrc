# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  web-search
  copybuffer
  dirhistory
  copyfile
  history
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#663399,standout"

source $ZSH/oh-my-zsh.sh

DEFAULT_USER=votre_nom

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Configuration globale des logs
# LOGLEVEL: 0=silencieux, 1=erreurs, 2=warnings+erreurs, 3=info+warnings+erreurs, 4=debug (tout)
export LOGLEVEL=${LOGLEVEL:-0}  # Valeur par défaut: mode silencieux
export PROMPTLEVEL=${PROMPTLEVEL:-0}  # Valeur par défaut: prompt long
export AUTO_INSTALL_BREW=${AUTO_INSTALL_BREW:-1}  # Valeur par défaut: installation automatique de Homebrew activée
export ASYNC_SETUP=${ASYNC_SETUP:-0}  # Valeur par défaut: setup synchrone pour première installation
export DISABLE_SETUP=${DISABLE_SETUP:-0}  # Valeur par défaut: setup automatique activé

# Configuration Node.js et npm dans /tmp/tmp/USERNAME (sans sudo)
# Dynamic user workspace - more secure and collision-resistant
export STUDENT_WORKSPACE="/tmp/tmp/${USER:-$(whoami)}"
export N_PREFIX="$STUDENT_WORKSPACE/node"
export PATH="$STUDENT_WORKSPACE/node/bin:$STUDENT_WORKSPACE/npm-global/bin:$PATH"

# Configuration étendue pour outils de développement modernes
# Java et outils JVM
export JAVA_HOME="$STUDENT_WORKSPACE/java"
export MAVEN_HOME="$STUDENT_WORKSPACE/maven"
export GRADLE_HOME="$STUDENT_WORKSPACE/gradle"
export GRADLE_USER_HOME="$STUDENT_WORKSPACE/.gradle"

# Android Development
export ANDROID_HOME="$STUDENT_WORKSPACE/android-sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export ANDROID_USER_HOME="$STUDENT_WORKSPACE/.android"

# Rust
export CARGO_HOME="$STUDENT_WORKSPACE/.cargo"
export RUSTUP_HOME="$STUDENT_WORKSPACE/.rustup"

# Go
export GOPATH="$STUDENT_WORKSPACE/go"
export GOCACHE="$STUDENT_WORKSPACE/.cache/go-build"
export GOMODCACHE="$STUDENT_WORKSPACE/go/pkg/mod"

# Docker (si supporté)
export DOCKER_CONFIG="$STUDENT_WORKSPACE/.docker"

# Configuration IDE et éditeurs - PRÉSERVATION DE L'ENVIRONNEMENT EXISTANT
# Note: Ces variables sont optionnelles et n'écrasent pas la configuration système par défaut
export VSCODE_PORTABLE_EXTENSIONS="$STUDENT_WORKSPACE/.vscode-extensions"
export IDEA_PORTABLE_HOME="$STUDENT_WORKSPACE/.idea"

# Configuration Python avancée
export PIP_USER="1"
export POETRY_HOME="$STUDENT_WORKSPACE/.poetry"
export CONDA_PKGS_DIRS="$STUDENT_WORKSPACE/.conda/pkgs"
export CONDA_ENVS_PATH="$STUDENT_WORKSPACE/.conda/envs"

# Configuration des caches génériques XDG (préservation de la config utilisateur)
# Ces variables ne sont définies que si aucune configuration utilisateur n'existe
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    export XDG_CONFIG_HOME="$STUDENT_WORKSPACE/.config"
fi
if [[ -z "$XDG_DATA_HOME" ]]; then
    export XDG_DATA_HOME="$STUDENT_WORKSPACE/.local/share"
fi

# Mise à jour du PATH pour tous les outils
export PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$CARGO_HOME/bin:$GOPATH/bin:$PATH"

# Fonctions de logging
logs_error() {
    [[ $LOGLEVEL -ge 1 ]] && echo "❌ $*" >&2
}

logs_warning() {
    [[ $LOGLEVEL -ge 2 ]] && echo "⚠️  $*" >&2
}

logs_info() {
    [[ $LOGLEVEL -ge 3 ]] && echo "ℹ️  $*" >&2
}

logs_success() {
    [[ $LOGLEVEL -ge 3 ]] && echo "✅ $*" >&2
}

logs_debug() {
    [[ $LOGLEVEL -ge 4 ]] && echo "🐛 [DEBUG] $*" >&2
}

# Aliases simples
alias bp='vim ~/.zshrc'
alias sa='source ~/.zshrc && logs_success "ZSH aliases rechargés."'
alias GoC='rm -f ~/.config/google-chrome/SingletonLock 2>/dev/null || true'
alias BrC='rm -f ~/.config/BraveSoftware/Brave-Browser/SingletonLock 2>/dev/null || true'
alias x='printf "\033c"'
alias Wcc="gcc -Wall -Wextra -Werror"

# Contrôle des logs
alias log_silent='export LOGLEVEL=0 && echo "🔇 Mode silencieux activé"'
alias log_errors='export LOGLEVEL=1 && echo "❌ Affichage des erreurs seulement"'
alias log_warnings='export LOGLEVEL=2 && echo "⚠️  Affichage des warnings et erreurs"'
alias log_info='export LOGLEVEL=3 && echo "ℹ️  Affichage des infos, warnings et erreurs"'
alias log_debug='export LOGLEVEL=4 && echo "🐛 Mode debug activé (tous les logs)"'
alias log_status='echo "📊 Niveau de log actuel: $LOGLEVEL"'
alias super_silent='export LOGLEVEL=0 && export DISABLE_SETUP=1 && echo "🔇 Mode super silencieux : logs + setup désactivés"'

# Contrôle du prompt
alias prompt_short='export PROMPTLEVEL=1 && echo "🐛 Affichage du prompt version réduite"'
alias prompt_long='export PROMPTLEVEL=0 && echo "🐛 Affichage du prompt version longue"'
alias prompt_level='echo "📊 Niveau du prompt actuel: $PROMPTLEVEL (1 = short, 0 = long)"'

# Contrôle du setup
alias setup_sync='export ASYNC_SETUP=0 && echo "🔄 Setup synchrone activé"'
alias setup_async='export ASYNC_SETUP=1 && echo "⚡ Setup asynchrone activé (recommandé après la première installation)"'
alias setup_off='export DISABLE_SETUP=1 && echo "🚫 Setup automatique désactivé"'
alias setup_on='export DISABLE_SETUP=0 && echo "✅ Setup automatique activé"'
alias brew_auto_install_off='export AUTO_INSTALL_BREW=0 && echo "🚫 Installation automatique de Homebrew désactivée"'
alias brew_auto_install_on='export AUTO_INSTALL_BREW=1 && echo "✅ Installation automatique de Homebrew activée"'
alias setup_status='echo "📊 ASYNC_SETUP: ${ASYNC_SETUP:-0}, AUTO_INSTALL_BREW: ${AUTO_INSTALL_BREW:-1}, DISABLE_SETUP: ${DISABLE_SETUP:-0}"'

if [[ -f "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh" ]]; then
    alias IBrew="$HOME/42/42_ZSH_Scripts/BrewInstaller.sh"
else
    logs_warning "Script BrewInstaller.sh non trouvé"
fi

# Prompt configuration
prompt_historyline(){
  prompt_segment green white '%*'
}

prompt_time() {
  prompt_segment yellow white '%D{%d/%m/%Y}'
}

prompt_context() {
  local user=$(whoami)
  # Custom (Random emoji) - Fixed logic
  # emojis=("⚡️" "🔥" "💀" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🇹 🇭 " "🚦" "🌙")
  if [[ $user == $DEFAULT_USER ]] || [[ -n $SSH_CLIENT ]]; then
  	local emojis=("⚡️" "🔥" "👑" "😎" "🐸" "🐵" "🦄" "🌈" "🍻" "🚀" "💡" "🎉" "🔑" "🌙")
  	local RAND_EMOJI_N=$(( $RANDOM % ${#emojis[@]} + 1))
  	prompt_segment black default "${emojis[$RAND_EMOJI_N]} %(!.%F{orange}.%F{blue})%n%F{white}@%F{red}%m%F{reset}"
  	# prompt_segment black default "%(!.%{%F{yellow}%}.)$USER "
  	# prompt_segment black default "${emojis[$RAND_EMOJI_N]} $user - %D{%d/%m/%Y} %* "
  else
  	prompt_segment black default "%(!.%F{yellow}.%F{blue})%n%F{white}@%F{red}%m%F{reset}"
  fi
}

# Prioritaire par rapport à agnoster.zsh-theme
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
  if [[ $PROMPTLEVEL == 0 ]]; then 
    prompt_historyline
    prompt_time
  fi
  prompt_terraform
  prompt_context
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}

# setup environnement functions
setup_temp_directories() {
    # Dynamic user-specific workspace with intelligent fallback
    local username="${USER:-$(whoami)}"
    local base_dir="/tmp/tmp/${username}"
    local fallback_dir="/tmp/tmp"
    local selected_dir=""
    
    logs_debug "Configuration de l'espace de travail pour l'utilisateur: $username"
    
    if mkdir -p "$base_dir" 2>/dev/null && [[ -w "$base_dir" ]]; then
        selected_dir="$base_dir"
        logs_debug "Répertoire utilisateur créé: $selected_dir"
    else
        logs_warning "Impossible de créer le répertoire utilisateur, fallback vers le répertoire partagé"
        selected_dir="$fallback_dir"
        mkdir -p "$selected_dir" 2>/dev/null
    fi
    
    export STUDENT_WORKSPACE="$selected_dir"
    
    local dirs=("$selected_dir" "$selected_dir/.cache" "$selected_dir/homebrew" "$selected_dir/homebrew/bin")
    
    logs_debug "Création des répertoires temporaires dans: $selected_dir"
    
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            if ! mkdir -p "$dir" 2>/dev/null; then
                logs_error "Impossible de créer le répertoire $dir"
                return 1
            fi
            logs_debug "Répertoire créé: $dir"
        fi
    done
    
    if [[ ! -w "$selected_dir" ]]; then
        logs_error "Pas de permission d'écriture sur $selected_dir"
        return 1
    fi
    
    logs_debug "Répertoires temporaires configurés avec succès dans: $selected_dir"
    return 0
}

setup_environment() {
    # Use dynamic workspace path
    local cache_dir="${STUDENT_WORKSPACE}/.cache"
    local homebrew_dir="${STUDENT_WORKSPACE}/homebrew"
    
    logs_debug "Configuration de l'environnement dans: $STUDENT_WORKSPACE"
    
    # Configuration du cache XDG (standard système)
    if [[ -d "$cache_dir" ]]; then
        export XDG_CACHE_HOME="$cache_dir"
        export PYTHONPATH="$cache_dir:$PYTHONPATH"
        export PYTHONUSERBASE="$STUDENT_WORKSPACE"
        export PATH="$STUDENT_WORKSPACE/bin:$PATH"
        logs_debug "Configuration Python/XDG terminée"
    else
        logs_warning "Répertoire cache non disponible: $cache_dir"
    fi

    # Suppression du SingletonLock pour Chrome
    local lock_file="$HOME/.config/google-chrome/SingletonLock"
    if [[ -f "$lock_file" ]]; then
        rm -f "$lock_file" 2>/dev/null
    fi

    # Configuration Homebrew
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
    else
        logs_warning "Répertoire Homebrew non disponible: $homebrew_dir"
    fi
    
    logs_debug "Configuration de l'environnement terminée"
}

install_homebrew_if_needed() {
    local brew_path="${STUDENT_WORKSPACE}/homebrew/bin/brew"
    local installer_script="$HOME/42/42_ZSH_Scripts/BrewInstaller.sh"
    
    if [[ ! -f "$brew_path" ]]; then
        if [[ -f "$installer_script" && -x "$installer_script" ]]; then
            logs_info "Installation de Homebrew en cours dans: $STUDENT_WORKSPACE"
            # Lancement silencieux en arrière-plan avec gestion d'erreur améliorée
            {
                STUDENT_WORKSPACE="$STUDENT_WORKSPACE" zsh -c "$installer_script" >/dev/null 2>&1
                if [[ $? -eq 0 ]]; then
                    export PATH="${STUDENT_WORKSPACE}/homebrew/bin:$PATH"
                    logs_success "Homebrew installé avec succès dans $STUDENT_WORKSPACE!" >/dev/null 2>&1
                else
                    logs_error "Échec de l'installation de Homebrew" >/dev/null 2>&1
                fi
            } &!  # &! désactive les notifications de job
        else
            if [[ ! -f "$installer_script" ]]; then
                logs_warning "Script d'installation Homebrew introuvable: $installer_script"
            elif [[ ! -x "$installer_script" ]]; then
                logs_warning "Script d'installation Homebrew non exécutable: $installer_script"
            fi
        fi
    else
        logs_debug "Homebrew déjà installé dans $STUDENT_WORKSPACE"
    fi
}

setup_norminette_alias() {
    local flake8_locations=(
        "${STUDENT_WORKSPACE}/bin/flake8"                  # Installation temporaire utilisateur
        "/tmp/tmp/bin/flake8"                              # Installation temporaire legacy
        "/mnt/nfs/homes/chillion/.local/bin/flake8"        # Installation user classique
        "$(command -v flake8 2>/dev/null)"                 # PATH système
    )
    
    for location in "${flake8_locations[@]}"; do
        if [[ -n "$location" && -x "$location" ]]; then
            alias norminette="$location"
            logs_success "Norminette configuré: $location"
            return 0
        fi
    done
    
    logs_warning "Norminette (flake8) non trouvé dans les emplacements habituels"
    logs_warning "Veuillez installer flake8 pour utiliser l'alias norminette pour python."
    return 1
}

c_formatter_42_pipInstall() {
    local pip_path="$(command -v pip3 2>/dev/null)"
    
    if [[ -z "$pip_path" ]]; then
        logs_warning "pip3 non trouvé, installation de c_formatter_42 annulée"
        return 1
    fi

    logs_info "Installation de fc_formatter_42 via pip en arrière-plan..."
    if pip3 install c_formatter_42 >/dev/null 2>&1; then
        logs_success "c_formatter_42 installé avec succès"
    else
        logs_error "Échec de l'installation de c_formatter_42"
        return 1
    fi
}

# Fonction principale de setup
setup_42zsh_environment() {
    logs_debug "Initialisation des fonctions de setup..."

    if [[ "${DISABLE_SETUP:-0}" == "1" ]]; then
        logs_debug "Setup automatique désactivé"
        return 0
    fi

    local force_sync=0
    
    if [[ ! -d "/tmp/tmp" ]] || \
       [[ "${AUTO_INSTALL_BREW:-1}" == "1" && ! -x "${STUDENT_WORKSPACE}/homebrew/bin/brew" ]] || \
       [[ "$PATH" != *"${STUDENT_WORKSPACE}/homebrew/bin"* ]]; then
        force_sync=1
        logs_debug "Première installation détectée - mode synchrone forcé"
    fi

    if [[ "${ASYNC_SETUP:-0}" == "1" && $force_sync == "0" ]]; then
        setup_async_mode
    else
        setup_sync_mode
        if [[ $force_sync == "1" ]]; then
            export ASYNC_SETUP=1
            logs_info "Setup initial terminé. Mode async activé. Vous pouvez gérer le mode a/synchrone avec 'setup_async' ou 'setup_sync'"
        fi
    fi
}

# Mode asynchrone (pour environnements déjà configurés)
setup_async_mode() {
    logs_debug "Mode asynchrone - environnement déjà configuré"
    
    setup_temp_directories
    setup_environment
    
    setopt NO_NOTIFY # Gestion des notifications de jobs
    if [[ "${AUTO_INSTALL_BREW:-1}" == "1" ]]; then
        { install_homebrew_if_needed >/dev/null 2>&1; } &!
    fi
    { setup_norminette_alias >/dev/null 2>&1; } &!
    { c_formatter_42_pipInstall >/dev/null 2>&1; } &!
    setopt NOTIFY
    
    logs_debug "Environnement configuré, installations lancées en arrière-plan"
}

# Mode synchrone (pour debug)
setup_sync_mode() {
    setup_temp_directories
    setup_environment
    if [[ "${AUTO_INSTALL_BREW:-1}" == "1" ]]; then
        install_homebrew_if_needed
    fi
    setup_norminette_alias
    c_formatter_42_pipInstall
    logs_debug "Fonctions de setup exécutées de manière synchrone"
}

setup_42zsh_environment

PyNormInstall() {
    local pip_path="$(command -v pip3 2>/dev/null)"
    
    if [[ -z "$pip_path" ]]; then
        echo "❌ Erreur: pip3 n'est pas installé ou n'est pas dans le PATH"
        return 1
    fi
    
    logs_info "Installation de Norminette via pip..."
    if ! pip3 install --user flake8; then
        echo "❌ Erreur: Échec de l'installation de flake8"
        return 1
    fi
    
    echo "✅ Norminette installé avec succès"
    setup_norminette_alias
}

rlwrap() {
    local brew_installed=$(command -v brew 2>/dev/null)
    
    if [[ -z "$brew_installed" ]]; then
        echo "❌ Erreur: Homebrew n'est pas installé. Veuillez l'installer d'abord." >&2
        return 1
    fi
    
    # Vérifier spécifiquement l'exécutable rlwrap dans les emplacements Homebrew
    local rlwrap_locations=(
        "/tmp/tmp/homebrew/bin/rlwrap"     # Homebrew temporaire
        "$(brew --prefix 2>/dev/null)/bin/rlwrap"  # Homebrew système
    )
    
    local rlwrap_found=""
    for location in "${rlwrap_locations[@]}"; do
        if [[ -n "$location" && -x "$location" ]]; then
            rlwrap_found="$location"
            break
        fi
    done
    
    if [[ -z "$rlwrap_found" ]]; then
        echo "❓ rlwrap n'est pas installé via Homebrew. Voulez-vous l'installer ? (Y/n)"
        read -r answer
        if [[ "$answer" == "n" || "$answer" == "N" ]]; then
            echo "❌ Installation de rlwrap annulée"
            return 1
        fi
        echo "🔄 Installation de rlwrap via Homebrew..."
        if brew install rlwrap; then
            echo "✅ rlwrap installé avec succès"
            for location in "${rlwrap_locations[@]}"; do
                if [[ -n "$location" && -x "$location" ]]; then
                    rlwrap_found="$location"
                    break
                fi
            done
        else
            echo "❌ Erreur: Échec de l'installation de rlwrap via Homebrew" >&2
            return 1
        fi
    fi
    
    if [[ -n "$rlwrap_found" ]]; then
        echo "🔧 Utilisation de: $rlwrap_found"
        command rlwrap "$@"
    else
        echo "❌ Erreur: rlwrap introuvable même après installation" >&2
        return 1
    fi
}

# Alias pour ouvrir un répertoire temporaire dans VS Code
# Usage: STmp [chemin]
STmp() {
    local target_dir=""
    
    # Définir le répertoire cible
    if [ $# -eq 0 ]; then
        target_dir="${STUDENT_WORKSPACE:-/tmp/tmp}"
    else
        target_dir="$1"
    fi
    
    # Validation du chemin
    if [[ -z "$target_dir" ]]; then
        echo "❌ Erreur: Chemin invalide fourni" >&2
        return 1
    fi
    
    # Convertir en chemin absolu si nécessaire
    if [[ "$target_dir" != /* ]]; then
        target_dir="$(pwd)/$target_dir"
    fi
    
    # Vérifier si c'est un fichier existant (pas un dossier)
    if [[ -f "$target_dir" ]]; then
        echo "❌ Erreur: '$target_dir' est un fichier, pas un répertoire" >&2
        return 1
    fi
    
    # Si le répertoire existe déjà, vérifier les permissions
    if [[ -d "$target_dir" ]]; then
        if [[ ! -w "$target_dir" ]]; then
            echo "❌ Erreur: Pas de permission d'écriture sur '$target_dir'" >&2
            return 1
        fi
        echo "📁 Répertoire existant: $target_dir"
    else
        # Vérifier si le répertoire parent existe et est accessible
        local parent_dir=$(dirname "$target_dir")
        if [[ ! -d "$parent_dir" ]]; then
            echo "❌ Erreur: Répertoire parent '$parent_dir' n'existe pas" >&2
            return 1
        fi
        
        if [[ ! -w "$parent_dir" ]]; then
            echo "❌ Erreur: Pas de permission d'écriture sur le répertoire parent '$parent_dir'" >&2
            return 1
        fi
        
        # Vérifier si le nom du dossier est valide (pas de caractères interdits)
        local basename=$(basename "$target_dir")
        if [[ "$basename" =~ [[:cntrl:]] ]] || [[ "$basename" == *"/"* ]]; then
            echo "❌ Erreur: Nom de répertoire invalide '$basename'" >&2
            return 1
        fi
        
        # Créer le répertoire
        echo "📁 Création du répertoire: $target_dir"
        if ! mkdir -p "$target_dir" 2>/dev/null; then
            echo "❌ Erreur: Impossible de créer le répertoire '$target_dir'" >&2
            return 1
        fi
    fi
    
    # Changer de répertoire
    if ! cd "$target_dir" 2>/dev/null; then
        echo "❌ Erreur: Impossible d'accéder au répertoire '$target_dir'" >&2
        return 1
    fi
    
    # Afficher le répertoire de travail actuel
    echo "📁 Répertoire de travail: $(pwd)"
    
    # Lancer VS Code
    if command -v code >/dev/null 2>&1; then
        echo "🚀 Lancement de VS Code..."
        code . &>/dev/null &
        echo "✅ VS Code lancé en arrière-plan dans $(pwd)"
    else
        echo "❌ Erreur: VS Code n'est pas installé ou pas dans le PATH" >&2
        return 1
    fi
}

# Alias pour git add, commit et push - Git Function
# This function adds all changes, commits with a message, and pushes to the remote repository.
# Usage: GF "message de commit"
GF() {
	if [ $# -eq 0 ]; then
		echo -e "\033[0;31mAjoute un commentaire à ton commit!!\033[0m"
		return 1
	else
		local commit_name="$*"
		if ! git status --porcelain | grep -q .; then
			echo -e "\033[0;33mAucun changement à commiter\033[0m"
			return 0
		fi
		
		echo -e "\033[0;34mAjout des fichiers...\033[0m"
		if git add . && git commit -m "$commit_name"; then
			echo -e "\033[0;34mPush en cours...\033[0m"
			if git push; then
				echo -e "\033[0;32m✅ Git Add, commit \"$commit_name\" et push réussis\033[0m"
			else
				echo -e "\033[0;31m❌ Échec du push\033[0m"
				return 1
			fi
		else
			echo -e "\033[0;31m❌ Échec du commit\033[0m"
			return 1
		fi
	fi
}

discord() {
    local DISCORD_DIR="${STUDENT_WORKSPACE}/discord"
    local DOWNLOAD_URL="https://discord.com/api/download?platform=linux&format=tar.gz"
    local VS_CODE_DETECTED=false
    local BASE_FLAGS=("--no-sandbox" "--disable-dev-shm-usage")
    local VSCODE_FLAGS=("--disable-gpu-sandbox" "--disable-features=VizDisplayCompositor")
    local ALL_FLAGS=()
    local ORIGINAL_DIR="$(pwd)"
    
    ALL_FLAGS+=("${BASE_FLAGS[@]}")

    if [[ -n "$VSCODE_INJECTION" || "$TERM_PROGRAM" == "vscode" || -n "$VSCODE_PID" || 
          "$TERMINAL_EMULATOR" == "vscode" || -n "$VSCODE_IPC_HOOK" ]]; then
        VS_CODE_DETECTED=true
        ALL_FLAGS+=("${VSCODE_FLAGS[@]}")
        logs_warning "⚠️  VS Code détecté - Application de flags de compatibilité"
        logs_info "💡 Des flags spéciaux seront utilisés pour éviter les conflits"
        

        echo -n "🤔 Continuer le lancement de Discord dans VS Code ? [y/N]: "
        read -r response
        case "$response" in
            [yY][eE][sS]|[yY])
                logs_info "🔧 Utilisation des flags de compatibilité VS Code"
                ;;
            *)
                logs_info "⏸️  Lancement annulé. Conseil: utilisez un terminal externe pour Discord"
                return 0
                ;;
        esac
    fi

    if [[ -x "$DISCORD_DIR/Discord/Discord" ]]; then
        logs_info "🚀 Lancement de Discord..."
        cd "$DISCORD_DIR"
        nohup ./Discord/Discord "${ALL_FLAGS[@]}" >/dev/null 2>&1 &
        logs_success "✅ Discord lancé en arrière-plan"
        cd "$ORIGINAL_DIR"
        return 0
    fi

    logs_info "📥 Téléchargement de Discord..."
    mkdir -p "$DISCORD_DIR"
    cd "$DISCORD_DIR"

    if curl -L -o discord.tar.gz "$DOWNLOAD_URL" 2>/dev/null; then
        logs_success "✅ Téléchargement réussi"
        
        logs_info "📦 Extraction..."
        if tar -xzf discord.tar.gz 2>/dev/null; then
            logs_success "✅ Extraction réussie"
            
            if [[ -d "Discord" && -x "Discord/Discord" ]]; then
                logs_info "🚀 Lancement de Discord..."
                nohup ./Discord/Discord "${ALL_FLAGS[@]}" >/dev/null 2>&1 &
                logs_success "✅ Discord installé et lancé en arrière-plan"
                cd "$ORIGINAL_DIR"
                return 0
            else
                logs_error "❌ Erreur: L'exécutable Discord n'a pas été trouvé"
                cd "$ORIGINAL_DIR"
                return 1
            fi
        else
            logs_error "❌ Échec de l'extraction"
            cd "$ORIGINAL_DIR"
            return 1
        fi
    else
        logs_error "❌ Échec du téléchargement"
        cd "$ORIGINAL_DIR"
        return 1
    fi
}

# Version avec eval pour Discord
discord_eval() {
    local DISCORD_DIR="/tmp/tmp/discord"
    local DOWNLOAD_URL="https://discord.com/api/download?platform=linux&format=tar.gz"
    local VS_CODE_DETECTED=false
    local BASE_FLAGS=("--no-sandbox" "--disable-dev-shm-usage")
    local VSCODE_FLAGS=("--disable-gpu-sandbox" "--disable-features=VizDisplayCompositor")
    local ALL_FLAGS=()
    local ORIGINAL_DIR="$(pwd)"
    
    ALL_FLAGS+=("${BASE_FLAGS[@]}")

    if [[ -n "$VSCODE_INJECTION" || "$TERM_PROGRAM" == "vscode" || -n "$VSCODE_PID" || 
          "$TERMINAL_EMULATOR" == "vscode" || -n "$VSCODE_IPC_HOOK" ]]; then
        VS_CODE_DETECTED=true
        ALL_FLAGS+=("${VSCODE_FLAGS[@]}")
        logs_warning "⚠️  VS Code détecté - Application de flags de compatibilité"
        logs_info "💡 Des flags spéciaux seront utilisés pour éviter les conflits"
        

        echo -n "🤔 Continuer le lancement de Discord dans VS Code ? [y/N]: "
        read -r response
        case "$response" in
            [yY][eE][sS]|[yY])
                logs_info "🔧 Utilisation des flags de compatibilité VS Code (version eval)"
                ;;
            *)
                logs_info "⏸️  Lancement annulé. Conseil: utilisez un terminal externe pour Discord"
                return 0
                ;;
        esac
    fi

    if [[ -x "$DISCORD_DIR/Discord/Discord" ]]; then
        logs_info "🚀 Lancement de Discord (version eval)..."
        cd "$DISCORD_DIR"
        eval "nohup ./Discord/Discord "${ALL_FLAGS[@]}" >/dev/null 2>&1 &"
        logs_success "✅ Discord lancé en arrière-plan"
        cd "$ORIGINAL_DIR"
        return 0
    fi

    logs_info "📥 Téléchargement de Discord..."
    mkdir -p "$DISCORD_DIR"
    cd "$DISCORD_DIR"

    if curl -L -o discord.tar.gz "$DOWNLOAD_URL" 2>/dev/null; then
        logs_success "✅ Téléchargement réussi"
        
        logs_info "📦 Extraction..."
        if tar -xzf discord.tar.gz 2>/dev/null; then
            logs_success "✅ Extraction réussie"
            
            if [[ -d "Discord" && -x "Discord/Discord" ]]; then
                logs_info "🚀 Lancement de Discord (version eval)..."
                eval "nohup ./Discord/Discord "${ALL_FLAGS[@]}" >/dev/null 2>&1 &"
                logs_success "✅ Discord installé et lancé en arrière-plan"
                cd "$ORIGINAL_DIR"
                return 0
            else
                logs_error "❌ Erreur: L'exécutable Discord n'a pas été trouvé"
                cd "$ORIGINAL_DIR"
                return 1
            fi
        else
            logs_error "❌ Échec de l'extraction"
            cd "$ORIGINAL_DIR"
            return 1
        fi
    else
        logs_error "❌ Échec du téléchargement"
        cd "$ORIGINAL_DIR"
        return 1
    fi
}

# Version avec pushd/popd pour une gestion plus robuste des répertoires
discord_pushd() {
    local DISCORD_DIR="/tmp/tmp/discord"
    local DOWNLOAD_URL="https://discord.com/api/download?platform=linux&format=tar.gz"
    local VS_CODE_DETECTED=false
    local BASE_FLAGS=("--no-sandbox" "--disable-dev-shm-usage")
    local VSCODE_FLAGS=("--disable-gpu-sandbox" "--disable-features=VizDisplayCompositor")
    local ALL_FLAGS=()
    
    ALL_FLAGS+=("${BASE_FLAGS[@]}")

    if [[ -n "$VSCODE_INJECTION" || "$TERM_PROGRAM" == "vscode" || -n "$VSCODE_PID" || 
          "$TERMINAL_EMULATOR" == "vscode" || -n "$VSCODE_IPC_HOOK" ]]; then
        VS_CODE_DETECTED=true
        ALL_FLAGS+=("${VSCODE_FLAGS[@]}")
        logs_warning "⚠️  VS Code détecté - Application de flags de compatibilité"
        logs_info "💡 Version pushd/popd utilisée pour la gestion des répertoires"
        
        echo -n "🤔 Continuer le lancement de Discord dans VS Code ? [y/N]: "
        read -r response
        case "$response" in
            [yY][eE][sS]|[yY])
                logs_info "🔧 Utilisation des flags de compatibilité VS Code (version pushd)"
                ;;
            *)
                logs_info "⏸️  Lancement annulé"
                return 0
                ;;
        esac
    fi

    # Sauvegarder le répertoire avec pushd
    pushd "$DISCORD_DIR" >/dev/null 2>&1 || {
        mkdir -p "$DISCORD_DIR"
        pushd "$DISCORD_DIR" >/dev/null 2>&1
    }

    if [[ -x "Discord/Discord" ]]; then
        logs_info "🚀 Lancement de Discord (version pushd)..."
        nohup ./Discord/Discord "${ALL_FLAGS[@]}" >/dev/null 2>&1 &
        logs_success "✅ Discord lancé en arrière-plan"
        popd >/dev/null 2>&1
        return 0
    fi

    logs_info "📥 Téléchargement de Discord..."
    
    if curl -L -o discord.tar.gz "$DOWNLOAD_URL" 2>/dev/null; then
        logs_success "✅ Téléchargement réussi"
        
        logs_info "📦 Extraction..."
        if tar -xzf discord.tar.gz 2>/dev/null; then
            logs_success "✅ Extraction réussie"
            
            if [[ -d "Discord" && -x "Discord/Discord" ]]; then
                logs_info "🚀 Lancement de Discord..."
                nohup ./Discord/Discord "${ALL_FLAGS[@]}" >/dev/null 2>&1 &
                logs_success "✅ Discord installé et lancé en arrière-plan"
                popd >/dev/null 2>&1
                return 0
            else
                logs_error "❌ Erreur: L'exécutable Discord n'a pas été trouvé"
                popd >/dev/null 2>&1
                return 1
            fi
        else
            logs_error "❌ Échec de l'extraction"
            popd >/dev/null 2>&1
            return 1
        fi
    else
        logs_error "❌ Échec du téléchargement"
        popd >/dev/null 2>&1
        return 1
    fi
}

# Alias de debug pour Discord avec retour au répertoire d'origine
alias discord_debug='VSCODE_PID="" discord'
alias discord_force='ORIGINAL_PWD="$(pwd)" && cd /tmp/tmp/discord && ./Discord/Discord --no-sandbox --disable-dev-shm-usage 2>&1; cd "$ORIGINAL_PWD"'
alias discord_minimal='ORIGINAL_PWD="$(pwd)" && cd /tmp/tmp/discord && ./Discord/Discord 2>&1; cd "$ORIGINAL_PWD"'

# Fonction utilitaire pour tester Discord depuis n'importe quel répertoire
discord_test() {
    echo "🧪 Test de lancement Discord depuis: $(pwd)"
    echo "📂 Installation/lancement dans: /tmp/tmp/discord"
    discord
    echo "📁 Vous êtes maintenant dans: $(pwd)"
}

# Installation automatique de Node.js et npm dans l'espace utilisateur
# Usage: NodeInstall [version] - par défaut installe la dernière version
NodeInstall() {
    local node_version="${1:-latest}"
    local npm_global_dir="${STUDENT_WORKSPACE}/npm-global"
    local node_dir="${STUDENT_WORKSPACE}/node"
    local original_dir="$(pwd)"
    
    echo "🚀 Installation de Node.js et npm dans l'espace utilisateur..."
    echo "📂 Répertoire de travail: $STUDENT_WORKSPACE"
    echo "📌 Version demandée: $node_version"
    
    # Création des répertoires nécessaires
    echo "📁 Création des répertoires..."
    if ! mkdir -p "$npm_global_dir" "$node_dir" 2>/dev/null; then
        echo "❌ Erreur: Impossible de créer les répertoires nécessaires" >&2
        return 1
    fi
    
    # Configuration des variables d'environnement
    echo "🔧 Configuration des variables d'environnement..."
    export N_PREFIX="$node_dir"
    export PATH="$node_dir/bin:$npm_global_dir/bin:$PATH"
    
    # Vérification de npm actuel pour installer 'n'
    echo "🔍 Vérification de npm..."
    if ! command -v npm >/dev/null 2>&1; then
        echo "❌ Erreur: npm n'est pas disponible pour installer 'n'" >&2
        echo "💡 Suggestion: Installez d'abord Node.js système ou utilisez un autre gestionnaire" >&2
        return 1
    fi
    
    # Configuration du préfixe npm pour les installations globales
    echo "⚙️  Configuration du préfixe npm..."
    npm config set prefix "$npm_global_dir" 2>/dev/null || {
        echo "⚠️  Avertissement: Impossible de configurer le préfixe npm" >&2
    }
    
    # Installation de 'n' si nécessaire
    if ! command -v n >/dev/null 2>&1; then
        echo "📦 Installation du gestionnaire de versions Node.js 'n'..."
        if ! npm install -g n 2>/dev/null; then
            echo "❌ Erreur: Échec de l'installation de 'n'" >&2
            return 1
        fi
        
        # Mise à jour du PATH pour 'n'
        export PATH="$npm_global_dir/bin:$PATH"
        hash -r
        
        if ! command -v n >/dev/null 2>&1; then
            echo "❌ Erreur: 'n' n'est toujours pas disponible après installation" >&2
            return 1
        fi
        echo "✅ 'n' installé avec succès"
    else
        echo "✅ 'n' est déjà disponible"
    fi
    
    # Installation de Node.js avec 'n'
    echo "🔄 Installation de Node.js $node_version..."
    if ! n "$node_version" 2>/dev/null; then
        echo "❌ Erreur: Échec de l'installation de Node.js $node_version" >&2
        return 1
    fi
    
    # Mise à jour du cache des commandes
    echo "🔄 Mise à jour du cache des commandes..."
    hash -r
    
    # Vérification de l'installation
    echo "🧪 Vérification de l'installation..."
    local node_path="$node_dir/bin/node"
    local npm_path="$node_dir/bin/npm"
    
    if [[ -x "$node_path" && -x "$npm_path" ]]; then
        local node_ver=$("$node_path" --version 2>/dev/null)
        local npm_ver=$("$npm_path" --version 2>/dev/null)
        
        echo "✅ Installation réussie!"
        echo "📋 Résumé:"
        echo "   • Node.js: $node_ver (installé dans $node_dir)"
        echo "   • npm: $npm_ver"
        echo "   • Préfixe npm global: $npm_global_dir"

        echo ""
        echo "🎉 Node.js et npm sont maintenant disponibles sans privilèges sudo!"
        echo "💡 Commandes utiles:"
        echo "   • node --version    # Vérifier la version de Node.js"
        echo "   • npm --version     # Vérifier la version de npm"
        echo "   • n latest          # Mettre à jour vers la dernière version"
        echo "   • n <version>       # Installer une version spécifique"
        echo "   • n ls              # Lister les versions installées"
        
    else
        echo "❌ Erreur: L'installation semble avoir échoué" >&2
        echo "🔍 Diagnostic:"
        echo "   • Node.js path: $node_path (existe: $(test -f "$node_path" && echo "oui" || echo "non"))"
        echo "   • npm path: $npm_path (existe: $(test -f "$npm_path" && echo "oui" || echo "non"))"
        return 1
    fi
    
    return 0
}

# Alias pour installation rapide
alias node_install='NodeInstall'
alias install_node='NodeInstall'
alias setup_node='NodeInstall'

# Installation Java OpenJDK
JavaInstall() {
    local java_version="${1:-17}"
    local java_dir="$STUDENT_WORKSPACE/java"
    
    echo "🔧 Installation de Java OpenJDK $java_version dans l'espace utilisateur..."
    
    if [[ ! -d "$java_dir" ]]; then
        mkdir -p "$java_dir"
        
        # Téléchargement via Eclipse Adoptium
        local download_url="https://download.java.net/openjdk/jdk${java_version}/ri/openjdk-${java_version}+35_linux-x64_bin.tar.gz"
        
        echo "📥 Téléchargement de Java $java_version..."
        if curl -L -o "/tmp/openjdk-${java_version}.tar.gz" "$download_url" 2>/dev/null; then
            tar -xzf "/tmp/openjdk-${java_version}.tar.gz" -C "$java_dir" --strip-components=1
            rm "/tmp/openjdk-${java_version}.tar.gz"
            echo "✅ Java $java_version installé avec succès dans $java_dir"
        else
            echo "❌ Erreur: Échec du téléchargement de Java"
            return 1
        fi
    else
        echo "ℹ️ Java déjà installé dans $java_dir"
    fi
    
    # Mise à jour du PATH
    export PATH="$java_dir/bin:$PATH"
    hash -r
}

# Installation Android SDK (version légère)
AndroidSDKInstall() {
    local sdk_dir="$STUDENT_WORKSPACE/android-sdk"
    local tools_version="${1:-9477386}"
    
    echo "🤖 Installation Android SDK dans l'espace utilisateur..."
    
    if [[ ! -d "$sdk_dir" ]]; then
        mkdir -p "$sdk_dir"
        
        # Téléchargement des command-line tools (plus léger qu'Android Studio)
        local download_url="https://dl.google.com/android/repository/commandlinetools-linux-${tools_version}_latest.zip"
        
        echo "📥 Téléchargement Android Command Line Tools..."
        if curl -L -o "/tmp/android-tools.zip" "$download_url" 2>/dev/null; then
            unzip "/tmp/android-tools.zip" -d "$sdk_dir" >/dev/null 2>&1
            rm "/tmp/android-tools.zip"
            
            # Configuration des tools
            mkdir -p "$sdk_dir/cmdline-tools/latest"
            mv "$sdk_dir/cmdline-tools"/* "$sdk_dir/cmdline-tools/latest/" 2>/dev/null || true
            
            echo "✅ Android SDK Tools installés avec succès"
            echo "💡 Utilisez 'sdkmanager' pour installer les packages spécifiques"
        else
            echo "❌ Erreur: Échec du téléchargement Android SDK"
            return 1
        fi
    else
        echo "ℹ️ Android SDK déjà installé dans $sdk_dir"
    fi
    
    export PATH="$sdk_dir/cmdline-tools/latest/bin:$sdk_dir/platform-tools:$PATH"
    hash -r
}

# Installation Rust
RustInstall() {
    echo "🦀 Installation de Rust dans l'espace utilisateur..."
    
    if [[ ! -f "$CARGO_HOME/bin/cargo" ]]; then
        mkdir -p "$CARGO_HOME" "$RUSTUP_HOME"
        
        echo "📥 Téléchargement et installation de Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
            CARGO_HOME="$CARGO_HOME" RUSTUP_HOME="$RUSTUP_HOME" sh -s -- --no-modify-path -y
        
        echo "✅ Rust installé avec succès dans $CARGO_HOME"
    else
        echo "ℹ️ Rust déjà installé"
    fi
    
    export PATH="$CARGO_HOME/bin:$PATH"
    hash -r
}

# Installation Go
GoInstall() {
    local go_version="${1:-1.21.4}"
    local go_dir="$STUDENT_WORKSPACE/go-install"
    
    echo "🐹 Installation de Go $go_version dans l'espace utilisateur..."
    
    if [[ ! -f "$go_dir/bin/go" ]]; then
        mkdir -p "$go_dir"
        
        local download_url="https://dl.google.com/go/go${go_version}.linux-amd64.tar.gz"
        
        echo "📥 Téléchargement de Go $go_version..."
        if curl -L -o "/tmp/go${go_version}.tar.gz" "$download_url" 2>/dev/null; then
            tar -xzf "/tmp/go${go_version}.tar.gz" -C "$go_dir" --strip-components=1
            rm "/tmp/go${go_version}.tar.gz"
            echo "✅ Go $go_version installé avec succès"
        else
            echo "❌ Erreur: Échec du téléchargement de Go"
            return 1
        fi
    else
        echo "ℹ️ Go déjà installé"
    fi
    
    export PATH="$go_dir/bin:$PATH"
    hash -r
}

# Installation et gestion des extensions VS Code (mode portable)
VSCodeExtensionsInstall() {
    local extensions_dir="$VSCODE_PORTABLE_EXTENSIONS"
    local use_portable=false
    
    if ! command -v code >/dev/null 2>&1; then
        echo "❌ VS Code n'est pas installé sur ce système"
        return 1
    fi
    
    echo "🔧 Configuration des extensions VS Code..."
    echo "📋 Options disponibles :"
    echo "  1. Installer dans l'environnement système (recommandé)"
    echo "  2. Installer dans l'espace portable temporaire"
    echo -n "Choisissez une option [1-2]: "
    read -r choice
    
    case "$choice" in
        "2")
            use_portable=true
            mkdir -p "$extensions_dir"
            echo "📁 Mode portable activé: $extensions_dir"
            ;;
        *)
            echo "📁 Mode système activé (configuration par défaut)"
            ;;
    esac
    
    # Extensions recommandées pour les étudiants 42
    local recommended_extensions=(
        "ms-vscode.cpptools"                    # C/C++ IntelliSense
        "ms-python.python"                      # Python support
        "rust-lang.rust-analyzer"               # Rust analyzer
        "golang.go"                             # Go support
        "redhat.java"                          # Java support
        "ms-vscode.vscode-typescript-next"      # TypeScript
        "bradlc.vscode-tailwindcss"            # Tailwind CSS
        "esbenp.prettier-vscode"               # Code formatter
        "ms-vscode.hexeditor"                  # Hex editor
        "42Crunch.vscode-openapi"              # API development
    )
    
    echo "📦 Installation des extensions recommandées..."
    
    for extension in "${recommended_extensions[@]}"; do
        echo "Installing $extension..."
        if [[ "$use_portable" == "true" ]]; then
            code --extensions-dir "$extensions_dir" --install-extension "$extension" 2>/dev/null || \
                echo "⚠️ Échec installation: $extension"
        else
            code --install-extension "$extension" 2>/dev/null || \
                echo "⚠️ Échec installation: $extension"
        fi
    done
    
    if [[ "$use_portable" == "true" ]]; then
        echo "✅ Extensions VS Code configurées dans $extensions_dir"
        echo "💡 Pour utiliser ces extensions : code --extensions-dir \"$extensions_dir\""
        echo "🔧 Ajoutez cet alias : alias code-portable='code --extensions-dir \"$extensions_dir\"'"
    else
        echo "✅ Extensions VS Code installées dans l'environnement système"
        echo "💡 Extensions disponibles immédiatement dans VS Code"
    fi
}

# Installation Poetry pour Python
PoetryInstall() {
    echo "🐍 Installation de Poetry dans l'espace utilisateur..."
    
    if [[ ! -f "$POETRY_HOME/bin/poetry" ]]; then
        mkdir -p "$POETRY_HOME"
        
        echo "📥 Téléchargement de Poetry..."
        curl -sSL https://install.python-poetry.org | POETRY_HOME="$POETRY_HOME" python3 -
        
        echo "✅ Poetry installé dans $POETRY_HOME"
        echo "💡 Ajoutez $POETRY_HOME/bin au PATH pour utiliser poetry"
    else
        echo "ℹ️ Poetry déjà installé dans $POETRY_HOME"
    fi
    
    # Mise à jour du PATH
    export PATH="$POETRY_HOME/bin:$PATH"
    hash -r
}

# Fonction de setup IDE (non-invasive)
SetupIDEEnvironment() {
    echo "🛠️ Configuration de l'environnement IDE (préservation des paramètres existants)..."
    
    # Création des répertoires de configuration portable
    mkdir -p "$VSCODE_PORTABLE_EXTENSIONS" "$IDEA_PORTABLE_HOME" 
    
    # Configuration VS Code portable (optionnelle)
    local portable_vscode_config="$STUDENT_WORKSPACE/.config/Code/User"
    mkdir -p "$portable_vscode_config"
    
    # Création d'un settings.json basique pour l'environnement portable uniquement
    if [[ ! -f "$portable_vscode_config/settings.json" ]]; then
        cat > "$portable_vscode_config/settings.json" << 'EOF'
{
    "editor.tabSize": 4,
    "editor.insertSpaces": false,
    "editor.detectIndentation": true,
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,
    "C_Cpp.default.cStandard": "c99",
    "C_Cpp.default.cppStandard": "c++98",
    "editor.rulers": [80],
    "workbench.colorTheme": "Default Dark+",
    "extensions.autoUpdate": false
}
EOF
        echo "✅ Configuration VS Code portable créée dans $portable_vscode_config"
        echo "💡 Cette configuration n'affecte PAS votre VS Code principal"
    fi
    
    # Créer des alias pour l'environnement portable
    echo "🔧 Création des alias pour l'environnement portable..."
    
    # Vérification si les alias existent déjà
    if ! alias code-portable >/dev/null 2>&1; then
        alias code-portable='code --extensions-dir "$VSCODE_PORTABLE_EXTENSIONS" --user-data-dir "$STUDENT_WORKSPACE/.config/Code"'
        echo "✅ Alias 'code-portable' créé"
    fi
    
    echo "✅ Environnement IDE configuré (mode non-invasif)"
    echo "📋 Commandes disponibles :"
    echo "   • code          : VS Code normal (vos paramètres actuels)"
    echo "   • code-portable : VS Code avec environnement temporaire"
}

# Fonction étendue DevInstall avec support IDE
DevInstall() {
    local tool="$1"
    
    case "$tool" in
        "java")
            JavaInstall "${2:-17}"
            ;;
        "android")
            AndroidSDKInstall "$2"
            ;;
        "rust")
            RustInstall
            ;;
        "go")
            GoInstall "$2"
            ;;
        "poetry")
            PoetryInstall
            ;;
        "vscode-ext")
            VSCodeExtensionsInstall
            ;;
        "ide")
            SetupIDEEnvironment
            ;;
        "all")
            echo "🚀 Installation complète des outils de développement..."
            JavaInstall
            AndroidSDKInstall
            RustInstall  
            GoInstall
            PoetryInstall
            SetupIDEEnvironment
            echo "✅ Installation terminée. Redémarrez votre terminal."
            ;;
        *)
            echo "Usage: DevInstall {java|android|rust|go|poetry|vscode-ext|ide|all} [version]"
            echo "Exemples:"
            echo "  DevInstall java 11"
            echo "  DevInstall android"
            echo "  DevInstall poetry"
            echo "  DevInstall vscode-ext"
            echo "  DevInstall ide"
            echo "  DevInstall all"
            ;;
    esac
}

# Aliases supplémentaires pour les nouveaux outils
alias install_poetry='DevInstall poetry'
alias install_vscode_ext='DevInstall vscode-ext'
alias setup_ide='DevInstall ide'

# Fonction de diagnostic de l'environnement VS Code
VSCodeEnvironmentCheck() {
    echo "🔍 Diagnostic de l'environnement VS Code..."
    echo ""
    
    # Vérification VS Code installé
    if command -v code >/dev/null 2>&1; then
        echo "✅ VS Code installé : $(code --version | head -n1)"
    else
        echo "❌ VS Code non installé"
        return 1
    fi
    
    echo ""
    echo "📂 Emplacements des configurations :"
    
    # Configuration système par défaut
    local system_extensions="$HOME/.vscode/extensions"
    local system_config="$HOME/.config/Code"
    
    if [[ -d "$system_extensions" ]]; then
        local ext_count=$(ls "$system_extensions" 2>/dev/null | wc -l)
        echo "   🏠 Extensions système : $system_extensions ($ext_count extensions)"
    else
        echo "   🏠 Extensions système : Non trouvées"
    fi
    
    if [[ -d "$system_config" ]]; then
        echo "   🏠 Config système     : $system_config"
        if [[ -f "$system_config/User/settings.json" ]]; then
            echo "       └─ settings.json existant"
        fi
    else
        echo "   🏠 Config système     : Non trouvée"
    fi
    
    echo ""
    echo "   📦 Extensions portables: $VSCODE_PORTABLE_EXTENSIONS"
    if [[ -d "$VSCODE_PORTABLE_EXTENSIONS" ]]; then
        local portable_ext_count=$(ls "$VSCODE_PORTABLE_EXTENSIONS" 2>/dev/null | wc -l)
        echo "       └─ ($portable_ext_count extensions portables)"
    else
        echo "       └─ (non initialisé)"
    fi
    
    echo ""
    echo "⚙️  Variables d'environnement actuelles :"
    echo "   XDG_CONFIG_HOME = ${XDG_CONFIG_HOME:-'<non défini>'}"
    echo "   XDG_DATA_HOME   = ${XDG_DATA_HOME:-'<non défini>'}"
    
    echo ""
    echo "🎯 Recommandations :"
    echo "   • Utilisez 'code' pour votre environnement normal"
    echo "   • Utilisez 'code-portable' pour l'environnement temporaire"
    echo "   • Vos paramètres actuels sont préservés"
}

# Alias de diagnostic
alias vscode-check='VSCodeEnvironmentCheck'
alias check-vscode='VSCodeEnvironmentCheck'
