#!/bin/bash

# Workspace utilisateur isolé. Aligné sur data/.zshrc :
#   1. $STUDENT_WORKSPACE (hérité du shell sourcé)
#   2. /goinfre/$USER si /goinfre est présent et accessible en écriture (postes 42)
#   3. /tmp/$USER en fallback (sticky bit 1777 — multi-user safe)
_resolve_workspace_dir() {
    local _user
    _user="$(id -un)"
    if [[ -n "${STUDENT_WORKSPACE:-}" ]]; then
        printf '%s' "$STUDENT_WORKSPACE"
        return 0
    fi
    local _goinfre_user="/goinfre/$_user"
    if [[ -d "$_goinfre_user" && -w "$_goinfre_user" ]]; then
        printf '%s' "$_goinfre_user"; return 0
    fi
    if [[ -d "/goinfre" && -w "/goinfre" ]] \
        && mkdir -p "$_goinfre_user" 2>/dev/null \
        && [[ -w "$_goinfre_user" ]]; then
        printf '%s' "$_goinfre_user"; return 0
    fi
    printf '%s' "/tmp/$_user"
}
WORKSPACE_DIR="$(_resolve_workspace_dir)"

# Echec explicite si le workspace n'est pas accessible (plus de fallback multi-user-unsafe)
if ! mkdir -p "$WORKSPACE_DIR" 2>/dev/null || [[ ! -w "$WORKSPACE_DIR" ]]; then
    echo "Erreur: Ecriture impossible dans $WORKSPACE_DIR." >&2
    echo "Vérifiez les permissions de /tmp (doit être sticky 1777) et que \$USER est défini." >&2
    exit 1
fi

echo "Installation de Homebrew dans: $WORKSPACE_DIR"

cd "$WORKSPACE_DIR"
mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | \
	tar xz --strip-components 1 -C homebrew
eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"

echo "Homebrew installé avec succès dans: $WORKSPACE_DIR/homebrew"
