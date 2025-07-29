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
alias sa='source ~/.zshrc && log_success "ZSH aliases rechargés."'
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
    local base_dir="/tmp/tmp"
    local dirs=("$base_dir" "$base_dir/.cache" "$base_dir/homebrew" "$base_dir/homebrew/bin")
    
    logs_debug "Création des répertoires temporaires..."
    
    for dir in "${dirs[@]}"; do
        if [[ ! -d "$dir" ]]; then
            if ! mkdir -p "$dir" 2>/dev/null; then
                logs_error "Impossible de créer le répertoire $dir"
                return 1
            fi
            logs_debug "Répertoire créé: $dir"
        fi
    done
    
    if [[ ! -w "$base_dir" ]]; then
        logs_error "Pas de permission d'écriture sur $base_dir"
        return 1
    fi
    
    logs_debug "Répertoires temporaires configurés avec succès"
    return 0
}

setup_environment() {
    local cache_dir="/tmp/tmp/.cache"
    local homebrew_dir="/tmp/tmp/homebrew"
    
    logs_debug "Configuration de l'environnement..."
    
    # Configuration du cache XDG (standard système)
    if [[ -d "$cache_dir" ]]; then
        export XDG_CACHE_HOME="$cache_dir"
        export PYTHONPATH="$cache_dir:$PYTHONPATH"
        export PYTHONUSERBASE="/tmp/tmp"
        export PATH="/tmp/tmp/bin:$PATH"
        logs_debug "Configuration Python/XDG terminée"
    else
        logs_warning "Répertoire cache non disponible: $cache_dir"
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
    local brew_path="/tmp/tmp/homebrew/bin/brew"
    local installer_script="$HOME/42/42_ZSH_Scripts/BrewInstaller.sh"
    
    if [[ ! -f "$brew_path" ]]; then
        if [[ -f "$installer_script" && -x "$installer_script" ]]; then
            logs_info "Installation de Homebrew en cours..."
            # Lancement silencieux en arrière-plan avec gestion d'erreur améliorée
            {
                if zsh -c "$installer_script" >/dev/null 2>&1; then
                    export PATH="/tmp/tmp/homebrew/bin:$PATH"
                    logs_success "Homebrew installé avec succès!" >/dev/null 2>&1
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
        logs_debug "Homebrew déjà installé"
    fi
}

setup_norminette_alias() {
    local flake8_locations=(
        "/tmp/tmp/bin/flake8"                              # Installation temporaire
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

# Fonction principale de setup
setup_42zsh_environment() {
    logs_debug "Initialisation des fonctions de setup..."

    if [[ "${DISABLE_SETUP:-0}" == "1" ]]; then
        logs_debug "Setup automatique désactivé"
        return 0
    fi

    local force_sync=0
    
    if [[ ! -d "/tmp/tmp" ]] || \
       [[ "${AUTO_INSTALL_BREW:-1}" == "1" && ! -x "/tmp/tmp/homebrew/bin/brew" ]] || \
       [[ "$PATH" != *"/tmp/tmp/homebrew/bin"* ]]; then
        force_sync=1
        logs_debug "Première installation détectée - mode synchrone forcé"
    fi

    if [[ "${ASYNC_SETUP:-0}" == "1" && $force_sync == "0" ]]; then
        setup_async_mode
    else
        setup_sync_mode
        if [[ $force_sync == "1" ]]; then
            setup_async
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
        target_dir="/tmp/tmp"
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
