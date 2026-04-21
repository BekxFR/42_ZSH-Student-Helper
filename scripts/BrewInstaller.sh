#!/bin/bash

# Workspace utilisateur isolé (aligné avec data/.zshrc : /tmp/$USER, sticky bit 1777)
WORKSPACE_DIR="${STUDENT_WORKSPACE:-/tmp/$(id -un)}"

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
