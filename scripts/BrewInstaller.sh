#!/bin/bash

# Dynamic workspace detection with user-specific fallback
WORKSPACE_DIR="${STUDENT_WORKSPACE:-/tmp/tmp/${USER:-$(whoami)}}"

# Ensure the workspace directory exists and is writable
if ! mkdir -p "$WORKSPACE_DIR" 2>/dev/null || [[ ! -w "$WORKSPACE_DIR" ]]; then
    echo "Warning: Ecriture impossible dans $WORKSPACE_DIR. Utilisation de /tmp/tmp à la place."
    WORKSPACE_DIR="/tmp/tmp"
    mkdir -p "$WORKSPACE_DIR" 2>/dev/null
fi

echo "Installation de Homebrew dans: $WORKSPACE_DIR"

cd "$WORKSPACE_DIR"
mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | \
	tar xz --strip-components 1 -C homebrew
eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"

echo "Homebrew installé avec succès dans: $WORKSPACE_DIR/homebrew"
