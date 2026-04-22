#!/usr/bin/env bash
# tb-ocaml : wrapper portable pour compiler de l'OCaml via Fedora Toolbox.
#
# Fonctionne sur n'importe quel poste Fedora 42, SANS dependre du .zshrc du
# projet. Redirige le stockage Podman/Toolbox vers /tmp/$USER/containers pour
# respecter le quota NFS. Une seule commande "clean" libere tout l'espace.
#
# Usage :
#   tb-ocaml setup              Creer le toolbox et installer ocaml/rlwrap/make
#   tb-ocaml make [args...]     Lancer make dans le toolbox (cwd preservee)
#   tb-ocaml ocamlopt -c f.ml   Lancer n'importe quelle commande (ocaml, rlwrap, bash, ...)
#   tb-ocaml status             Afficher l'etat du conteneur et l'espace occupe
#   tb-ocaml clean              Supprimer le conteneur, les images et le storage
#   tb-ocaml help               Afficher cette aide
#
# Variables d'environnement respectees :
#   STUDENT_TOOLBOX_NAME   Nom du conteneur (defaut : student-dev)
#   STUDENT_WORKSPACE      Repertoire de travail (defaut : /tmp/$USER)
#
# Exemple d'usage depuis un poste etranger :
#   scp poste-source:tb-ocaml.sh .
#   chmod +x tb-ocaml.sh
#   ./tb-ocaml.sh setup
#   cd /tmp/$USER/GitOcaml/21/ex00
#   /path/to/tb-ocaml.sh make test
#   /path/to/tb-ocaml.sh clean

set -euo pipefail

TOOLBOX_NAME="${STUDENT_TOOLBOX_NAME:-student-dev}"
WORKSPACE="${STUDENT_WORKSPACE:-/tmp/${USER:-$(id -un)}}"
CONTAINERS_DIR="$WORKSPACE/containers"
STORAGE_CONF="$CONTAINERS_DIR/storage.conf"
GRAPHROOT="$CONTAINERS_DIR/storage"
RUNROOT="$CONTAINERS_DIR/runroot"

ensure_storage() {
    mkdir -p "$GRAPHROOT" "$RUNROOT" || {
        echo "ERROR: impossible de creer $CONTAINERS_DIR (verifier /tmp)" >&2
        return 1
    }
    if [[ ! -f "$STORAGE_CONF" ]] || ! grep -q "graphroot = \"$GRAPHROOT\"" "$STORAGE_CONF" 2>/dev/null; then
        cat > "$STORAGE_CONF" <<EOF
[storage]
driver = "overlay"
graphroot = "$GRAPHROOT"
runroot = "$RUNROOT"

[storage.options]
additionalimagestores = []

[storage.options.overlay]
mountopt = "nodev,metacopy=on"
EOF
    fi
    export CONTAINERS_STORAGE_CONF="$STORAGE_CONF"
}

ensure_fedora() {
    if [[ -r /etc/os-release ]] && ! grep -q '^ID=fedora' /etc/os-release; then
        echo "ERROR: ce script est destine aux sessions Fedora uniquement." >&2
        echo "       Sur Ubuntu, utilisez directement 'brew install ocaml rlwrap'." >&2
        return 1
    fi
}

ensure_toolbox() {
    if ! command -v toolbox >/dev/null 2>&1; then
        echo "ERROR: 'toolbox' introuvable. Installez-le : sudo dnf install -y toolbox" >&2
        return 1
    fi
}

container_exists() {
    toolbox list -c 2>/dev/null | grep -qw "$TOOLBOX_NAME"
}

cmd_setup() {
    ensure_fedora || return 1
    ensure_toolbox || return 1
    ensure_storage || return 1
    echo "==> Stockage redirige vers $CONTAINERS_DIR (quota NFS preserve)"
    echo "    Le conteneur et l'image fedora-toolbox occuperont ~500 Mo sous /tmp"

    if container_exists; then
        echo "==> Conteneur '$TOOLBOX_NAME' deja present, reutilisation"
    else
        echo "==> Creation du conteneur Toolbox '$TOOLBOX_NAME'..."
        toolbox create -y -c "$TOOLBOX_NAME" >/dev/null
    fi

    echo "==> Installation de ocaml, ocaml-compiler-libs, ocaml-findlib, rlwrap, make..."
    if toolbox run -c "$TOOLBOX_NAME" sudo dnf install -y \
        ocaml ocaml-compiler-libs ocaml-findlib rlwrap make; then
        echo "OK  setup termine. Essayez : $(basename "$0") make"
    else
        echo "ERROR: echec de l'installation des paquets via dnf" >&2
        return 1
    fi
}

cmd_clean() {
    ensure_fedora || return 1
    ensure_toolbox || return 1
    ensure_storage || return 1

    echo "==> Arret et suppression du conteneur '$TOOLBOX_NAME'..."
    toolbox rm -f "$TOOLBOX_NAME" 2>/dev/null || true

    if command -v podman >/dev/null 2>&1; then
        echo "==> Suppression des images Podman (scope: $CONTAINERS_DIR)..."
        podman rmi -a -f 2>/dev/null || true
    fi

    local freed=""
    if [[ -d "$CONTAINERS_DIR" ]]; then
        freed=$(du -sh "$CONTAINERS_DIR" 2>/dev/null | awk '{print $1}')
        rm -rf "$CONTAINERS_DIR"
    fi
    echo "==> Libere ${freed:-0} dans $CONTAINERS_DIR"
    echo "OK  nettoyage termine"
}

cmd_status() {
    ensure_storage || return 1
    echo "Toolbox     : $TOOLBOX_NAME"
    echo "Workspace   : $WORKSPACE"
    echo "Storage     : $GRAPHROOT"
    if [[ -d "$CONTAINERS_DIR" ]]; then
        echo "Taille      : $(du -sh "$CONTAINERS_DIR" 2>/dev/null | awk '{print $1}')"
    else
        echo "Taille      : (aucune donnee, container absent)"
    fi
    if command -v toolbox >/dev/null 2>&1 && container_exists; then
        echo "Etat        : OK conteneur present, pret a l'emploi"
    else
        echo "Etat        : KO conteneur absent, lancez : $(basename "$0") setup"
    fi
}

cmd_help() {
    sed -n '2,/^set -euo pipefail/p' "$0" | sed 's/^# \{0,1\}//' | sed '/^set -euo pipefail/d'
}

cmd_run() {
    ensure_fedora || return 1
    ensure_toolbox || return 1
    ensure_storage || return 1
    if ! container_exists; then
        echo "ERROR: conteneur '$TOOLBOX_NAME' absent. Lancez d'abord : $(basename "$0") setup" >&2
        return 1
    fi

    local cwd="$PWD"
    if [[ "$cwd" != "$HOME"* && "$cwd" != "/tmp"* ]]; then
        echo "WARNING: cwd ($cwd) n'est ni dans \$HOME ni dans /tmp." >&2
        echo "         Toolbox peut retomber sur \$HOME. Si la compilation echoue," >&2
        echo "         deplacez le projet dans \$HOME ou /tmp/\$USER." >&2
    fi

    exec toolbox run -c "$TOOLBOX_NAME" "$@"
}

case "${1:-help}" in
    setup)          shift; cmd_setup  "$@" ;;
    clean)          shift; cmd_clean  "$@" ;;
    status)         shift; cmd_status "$@" ;;
    help|-h|--help) cmd_help ;;
    *)              cmd_run "$@" ;;
esac
