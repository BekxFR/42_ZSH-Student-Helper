#!/bin/bash
mkdir -p /tmp/tmp
cd /tmp/tmp
mkdir -p homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | \
	tar xz --strip-components 1 -C homebrew
eval "$(homebrew/bin/brew shellenv)"
brew update --force --quiet
chmod -R go-w "$(brew --prefix)/share/zsh"
