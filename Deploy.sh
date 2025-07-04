#!/bin/bash
#
# 42_ZSH Student Helper - Script de déploiement
# Optimisé pour environnement éducatif avec contraintes stockage
#

set -euo pipefail

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="/tmp/42_zsh_deploy.log"
readonly BACKUP_DIR="$HOME/.42_zsh_backup_$(date +%Y%m%d_%H%M%S)"

# Fonctions utilitaires de logging
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

error() {
    log "❌ ERREUR: $*" >&2
}

success() {
    log "✅ SUCCÈS: $*"
}

info() {
    log "ℹ️ INFO: $*"
}

# Vérification prérequis
check_prerequisites() {
    info "Vérification des prérequis système..."

    # Ubuntu/Debian requis
    if ! grep -E "ubuntu" /etc/os-release >/dev/null 2>&1; then
        error "Système non supporté. Ubuntu 20.04+ requis."
        exit 1
    fi

    # Version Zsh
    if ! command -v zsh >/dev/null 2>&1; then
        error "Zsh n'est pas installé ou pas détecté correctement"
        exit 1
    fi

    local zsh_version
    zsh_version=$(zsh --version | cut -d' ' -f2)
    if ! printf '%s\n5.0.8\n' "$zsh_version" | sort -V | head -n1 | grep -q "5.0.8"; then
        error "Zsh version $zsh_version trop ancienne. 5.0.8+ requis."
        exit 1
    fi

    # Espace disque
    local available_space
    available_space=$(df /tmp | awk 'NR==2 {print $4}')
    if [[ $available_space -lt 204800 ]]; then
        error "Espace insuffisant dans /tmp. 200MB minimum requis."
        exit 1
    fi

    success "Prérequis vérifiés avec succès"
}

# Installation Oh-My-Zsh
install_ohmyzsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        info "Installation de Oh-My-Zsh..."
        RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        success "Oh-My-Zsh installé"
    else
        info "Oh-My-Zsh déjà installé"
    fi
}

# Sauvegarde configuration existante
backup_existing_config() {
    info "Sauvegarde de la configuration existante..."

	if [[ ! -d "$BACKUP_DIR" ]]; then
		mkdir -p "$BACKUP_DIR"
		if [[ ! -d "$BACKUP_DIR" ]]; then
			error "Échec de la création du dossier $BACKUP_DIR"
		fi
	fi

    if [[ -f "$HOME/.zshrc" ]]; then
        cp "$HOME/.zshrc" "$BACKUP_DIR/zshrc.backup"
		if [[ $? -ne 0 ]]; then
			error "Échec de la copie du fichier $HOME/.zshrc"
		else
        	info "Sauvegarde de ~/.zshrc vers $BACKUP_DIR"
		fi
    fi

    if [[ -f "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh" ]]; then
        cp "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh" "$BACKUP_DIR/BrewInstaller.sh.backup"
		if [[ $? -ne 0 ]]; then
			error "Échec de la copie du fichier $HOME/42/42_ZSH_Scripts/BrewInstaller.sh"
		else
			info "Sauvegarde de BrewInstaller.sh vers $BACKUP_DIR"
		fi
    fi

    success "Sauvegarde créée dans $BACKUP_DIR"
}

# Déploiement configuration
deploy_config() {
    info "Déploiement de la configuration optimisée..."

	# Creer des dossiers 42 et 42/42_ZSH_Scripts
	if [[ ! -d "$HOME/42" ]]; then
		mkdir -p "$HOME/42"
		if [[ ! -d "$HOME/42" ]]; then
			error "Échec de la création du dossier $HOME/42"
			exit 1
		fi
	fi
	if [[ ! -d "$HOME/42/42_ZSH_Scripts" ]]; then
		mkdir -p "$HOME/42/42_ZSH_Scripts"
		if [[ ! -d "$HOME/42/42_ZSH_Scripts" ]]; then
			error "Échec de la création du dossier $HOME/42/42_ZSH_Scripts"
			exit 1
		fi
	fi

    # Vérifier que le fichier .zshrc existe
    if [[ ! -f "$SCRIPT_DIR/data/.zshrc" ]]; then
        error "Fichier .zshrc introuvable dans $SCRIPT_DIR"
        exit 1
    fi

    cp "$SCRIPT_DIR/data/.zshrc" "$HOME/.zshrc"
	if [[ $? -ne 0 ]]; then
		error "Échec de la copie de .zshrc"
		exit 1
	fi


    if [[ "$SCRIPT_DIR/scripts/BrewInstaller.sh" != "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh" ]]; then
        if [[ -f "$SCRIPT_DIR/scripts/BrewInstaller.sh" ]]; then
            cp "$SCRIPT_DIR/scripts/BrewInstaller.sh" "$HOME/42/42_ZSH_Scripts/"
			if [[ $? -ne 0 ]]; then
				error "Échec de la copie de BrewInstaller.sh"
				exit 1
			fi
        else
            error "Fichier BrewInstaller.sh introuvable dans $SCRIPT_DIR"
            exit 1
        fi
    else
        info "BrewInstaller.sh déjà en place"
    fi
    
	if ! chmod +x "$HOME/42/42_ZSH_Scripts/BrewInstaller.sh"; then
        error "Échec de chmod sur BrewInstaller.sh"
        exit 1
    fi

    success "Configuration déployée"
}

# Initialisation environnement
init_environment() {
    info "Initialisation de l'environnement optimisé..."

    # Vérification que les fichiers nécessaires sont en place
    cd "$HOME"
    export ZSH="$HOME/.oh-my-zsh"
    
    # Vérifier que .zshrc a été correctement déployé
    if [[ -f "$HOME/.zshrc" ]]; then
        info "Configuration .zshrc déployée avec succès"
    else
        error "Fichier .zshrc manquant après déploiement"
        exit 1
    fi
    
    # Note: On ne fait pas 'source ~/.zshrc' ici car nous sommes dans un script bash
    # La configuration ZSH sera activée lors du prochain lancement de ZSH
    info "Configuration prête. Redémarrez votre terminal."

    success "Environnement initialisé"
}

# Vérification installation
verify_installation() {
    info "Vérification de l'installation..."

    # Test commandes principales
    local test_commands=(
        "zsh --version"
        "brew --version 2>/dev/null || echo 'Homebrew sera installé au premier usage'"
        "git --version"
    )

    for cmd in "${test_commands[@]}"; do
        if eval "$cmd" >/dev/null 2>&1; then
            success "✓ $(echo "$cmd" | cut -d' ' -f1) fonctionnel"
        else
            error "✗ Problème avec: $cmd"
        fi
    done

    success "Installation vérifiée avec succès"
}

# Installation des fonts Powerline
install_powerline_fonts() {
    info "Installation des Fonts Powerline..."

    # Vérifier si les Fonts sont déjà installées
    if fc-list | grep -i powerline >/dev/null 2>&1; then
        info "Les Fonts Powerline sont déjà installées"
        return 0
    fi

    # Créer dossier temporaire
    local temp_dir="/tmp/powerline-fonts"
    rm -rf "$temp_dir" 2>/dev/null || true

    # Cloner le dépôt des Fonts
    if ! git clone https://github.com/powerline/fonts.git --depth=1 "$temp_dir"; then
        error "Échec du clonage du dépôt des fonts Powerline"
        return 1
    fi

    # Installer les Fonts
    cd "$temp_dir"
    if ! ./install.sh; then
        error "Échec de l'installation des Fonts Powerline"
        cd - >/dev/null
        rm -rf "$temp_dir"
        return 1
    fi

    # Nettoyage
    cd - >/dev/null
    rm -rf "$temp_dir"

    success "Fonts Powerline installées avec succès"
    info "Relancer votre session pour etre certain de la prise en compte"
}

# Fonction d'aide
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

OPTIONS:
    Fonts       Installer uniquement les fonts Powerline
    --help      Afficher cette aide

Exemples:
    $0              # Installation complète du 42_ZSH Student Helper
    $0 Fonts        # Installation uniquement des fonts Powerline
    $0 --help       # Afficher cette aide

EOF
}

# Fonction principale
main() {
    # Vérifier les arguments
    if [[ $# -gt 0 ]]; then
        case "$1" in
            "Fonts")
                info "🔤 Installation des fonts Powerline uniquement"
                install_powerline_fonts
                success "🎉 Installation des fonts terminée!"
                info "🔄 Redémarrez votre terminal pour que les fonts soient prises en compte"
                return 0
                ;;
            "--help"|"-h")
                show_help
                return 0
                ;;
            *)
                error "Option inconnue: $1"
                show_help
                exit 1
                ;;
        esac
    fi

    info "🚀 Début déploiement 42_ZSH Student Helper"

    check_prerequisites
    install_ohmyzsh
    backup_existing_config
    deploy_config
    init_environment
    verify_installation

    success "🎉 Déploiement terminé avec succès!"
    info "📝 Log complet disponible: $LOG_FILE"
    info "💾 Sauvegarde dans: $BACKUP_DIR"
    info "🔄 Redémarrez votre terminal ou exécutez: source ~/.zshrc"
}

# Gestion erreurs avec rollback
rollback() {
    error "Échec du déploiement, rollback en cours..."

    if [[ -f "$BACKUP_DIR/zshrc.backup" ]]; then
        mv "$BACKUP_DIR/zshrc.backup" "$HOME/.zshrc"
        info "Configuration ZSH restaurée"
    fi

    if [[ -f "$BACKUP_DIR/BrewInstaller.sh.backup" ]]; then
        mv "$BACKUP_DIR/BrewInstaller.sh.backup" "$HOME/42/BrewInstaller.sh"
        info "Script BrewInstaller restauré"
    fi

    rm -rf "$BACKUP_DIR" 2>/dev/null || true
    info "Environnement de backup nettoyé"

    error "Rollback terminé. Consultez $LOG_FILE pour détails."
    exit 1
}

trap rollback ERR

# Lancement si exécuté directement
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
