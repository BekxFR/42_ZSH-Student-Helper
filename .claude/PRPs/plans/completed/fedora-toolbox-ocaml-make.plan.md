# Plan: Script portable `tb-ocaml` pour compilation OCaml via Toolbox sur Fedora

## Summary

Créer un script shell **autonome** (`scripts/tb-ocaml.sh`) qui permet à un étudiant de compiler des programmes OCaml (Makefile, `ocamlopt`, `ocaml`, `rlwrap`, etc.) à l'intérieur d'un conteneur Fedora Toolbox, sur **n'importe quel poste Fedora 42**, même ceux qui n'ont pas le projet `42_ZSH-Student-Helper` déployé. Le stockage du conteneur est redirigé vers `/tmp/$USER/containers` pour respecter le quota NFS, et une sous-commande `clean` libère tout l'espace en une étape.

## User Story

En tant qu'étudiant 42 qui a migré son environnement via ce projet,
je veux pouvoir copier un unique script sur n'importe quel poste Fedora et lancer `tb-ocaml make` dans mon répertoire de projet OCaml,
afin de compiler mes rendus sans installer quoi que ce soit de permanent sur le poste ni consommer le quota NFS.

## Problem → Solution

**Avant** : sur un poste Fedora sans notre solution, `ocamlopt`/`ocamlc` ne sont pas installés. Lancer un `make` dans un exercice OCaml (ex. `GitOcaml/21/ex00`) échoue avec `command not found`. La voie officielle (créer un toolbox manuellement, installer les paquets, gérer le stockage Podman qui peut saturer `$HOME`) demande plusieurs commandes avec des détails faciles à oublier.

**Après** : un unique script `tb-ocaml.sh` copiable (scp, clé USB, gist), exécutable sans sourcer le `.zshrc` du projet, qui fournit :
- `tb-ocaml setup` — création toolbox + `dnf install ocaml ... rlwrap make`
- `tb-ocaml make [args...]` — exécution de `make` dans le toolbox avec cwd préservé
- `tb-ocaml <cmd> [args...]` — exécution de n'importe quelle commande dans le toolbox (ex. `tb-ocaml ocamlopt -c atom.ml`, `tb-ocaml rlwrap ocaml`, `tb-ocaml bash`)
- `tb-ocaml status` — état du conteneur + taille occupée
- `tb-ocaml clean` — suppression complète (conteneur + images + storage) → libère le disque

## Metadata

- **Complexity** : Small–Medium (1 nouveau script bash autonome, ~150 lignes, + docs)
- **Source PRD** : N/A (free-form)
- **PRD Phase** : N/A
- **Estimated Files** : 3 (`scripts/tb-ocaml.sh` nouveau, `CLAUDE.md` update, `docs/ENVIRONMENT_SAFETY.md` update)

---

## UX Design

### Before (poste Fedora sans la solution)

```
┌─────────────────────────────────────────────────────────────┐
│ $ cd /tmp/chillion/GitOcaml/21/ex00                         │
│ $ make                                                      │
│ ocamlopt -c atom.ml                                         │
│ make: ocamlopt: Command not found                           │
│ make: *** [Makefile:15: atom.cmx] Error 127                 │
└─────────────────────────────────────────────────────────────┘
```

### After

```
┌─────────────────────────────────────────────────────────────┐
│ $ scp poste-origine:tb-ocaml.sh ./                          │
│ $ chmod +x tb-ocaml.sh                                      │
│ $ ./tb-ocaml.sh setup        # une fois, ~30s              │
│ Setup terminé. Conteneur 'student-dev' prêt.            │
│                                                             │
│ $ cd /tmp/chillion/GitOcaml/21/ex00                         │
│ $ /chemin/vers/tb-ocaml.sh make                             │
│ ocamlopt -c atom.ml                                         │
│ ocamlopt -c main.ml                                         │
│ ocamlopt -o ex00 atom.cmx main.cmx                          │
│                                                             │
│ $ ./ex00                     # binaire natif, pas de toolbox│
│ Hello, world.                                               │
│                                                             │
│ $ /chemin/vers/tb-ocaml.sh clean    # fin de session TP     │
│ Libère 420 Mo dans /tmp/chillion/containers              │
└─────────────────────────────────────────────────────────────┘
```

### Interaction Changes

| Touchpoint | Before | After | Notes |
|---|---|---|---|
| Installation OCaml sur poste étranger | `sudo dnf install ocaml ...` (refusé sans root utilisateur) | `./tb-ocaml.sh setup` (root est dans le toolbox uniquement) | Isolation propre |
| Compilation Makefile | `make` → échec | `tb-ocaml make` | cwd préservée par Toolbox |
| Espace disque occupé | Bloqué sur NFS `$HOME` si on installe | `/tmp/$USER/containers/` via `CONTAINERS_STORAGE_CONF` | Quota NFS préservé |
| Nettoyage de fin de session | Manuel : `toolbox rm -f`, `podman rmi -a`, `rm -rf` | `tb-ocaml clean` | Une commande, tout libéré |

---

## Mandatory Reading

| Priority | File | Lines | Why |
|---|---|---|---|
| P0 | `data/.zshrc` | 127–175 | Bloc détection OS + `_ensure_toolbox_storage` à répliquer en autonome |
| P0 | `data/.zshrc` | 1540–1595 | `OCamlInstall()` Fedora — même séquence à adapter |
| P1 | `scripts/BrewInstaller.sh` | 1–20 | Convention workspace (`/tmp/$USER`, messages erreur) |
| P1 | `/tmp/chillion/GitOcaml/21/ex00/Makefile` | all | Cibles `all`, `clean`, `fclean`, `re`, `test` — le script doit supporter tous les appels `make <target>` |
| P2 | `CLAUDE.md` | 30–45 | Section Workspace model — aligner le ton de la doc |

## External Documentation

| Topic | Source | Key Takeaway |
|---|---|---|
| `toolbox run` cwd | `man toolbox-run` | `toolbox run` propage cwd si le chemin est dans un bind-mount (`$HOME`, `/tmp`). Sinon retombe sur `$HOME`. |
| Podman `storage.conf` | `man containers-storage.conf` | `CONTAINERS_STORAGE_CONF` override complet — graphroot/runroot redirigés évitent `~/.local/share/containers` |
| `toolbox rm -f` | `man toolbox-rm` | Supprime le conteneur même s'il tourne. Les images restent tant que `podman rmi` n'est pas appelé. |

---

## Patterns to Mirror

### WORKSPACE_DEFAULT
```bash
# SOURCE: scripts/BrewInstaller.sh:4
WORKSPACE_DIR="${STUDENT_WORKSPACE:-/tmp/$(id -un)}"
```
→ Le script autonome doit fonctionner **même sans `.zshrc`** donc calcule son propre workspace.

### STORAGE_CONF_GENERATION
```bash
# SOURCE: data/.zshrc:_ensure_toolbox_storage (lignes ~155–175)
cat > "$conf" <<EOF
[storage]
driver = "overlay"
graphroot = "$graphroot"
runroot = "$runroot"

[storage.options]
additionalimagestores = []

[storage.options.overlay]
mountopt = "nodev,metacopy=on"
EOF
```
→ Générer le même format TOML dans le script autonome.

### OCAML_INSTALL_SEQUENCE
```bash
# SOURCE: data/.zshrc:OCamlInstall Fedora branch (lignes ~1540–1595)
toolbox create -y -c "$TOOLBOX_NAME"
toolbox run -c "$TOOLBOX_NAME" sudo dnf install -y \
    ocaml ocaml-compiler-libs ocaml-findlib rlwrap
```
→ Ajouter `make` à la liste pour garantir sa présence dans le conteneur.

### STRICT_MODE
```bash
# SOURCE: Deploy.sh:1
set -euo pipefail
```
→ Appliquer au nouveau script.

### FRENCH_UX_MESSAGES
```bash
# SOURCE: data/.zshrc partout
echo "📦 Stockage redirigé vers $STUDENT_WORKSPACE/containers (quota NFS préservé)"
logs_success "OCaml + rlwrap installés dans '$STUDENT_TOOLBOX_NAME'"
```
→ Messages utilisateur en français avec émojis, cohérents avec le reste du projet.

---

## Files to Change

| File | Action | Justification |
|---|---|---|
| `scripts/tb-ocaml.sh` | CREATE | Script autonome portable |
| `CLAUDE.md` | UPDATE | Mentionner le script dans la section « OS detection & Fedora/Toolbox integration » |
| `docs/ENVIRONMENT_SAFETY.md` | UPDATE | Ajouter sous-section usage portable |
| `README.md` | UPDATE (optionnel) | Bullet « Script Toolbox portable pour compilation OCaml sur poste étranger » |

## NOT Building

- **Pas de support Ubuntu dans ce script** — Ubuntu utilise déjà `brew install ocaml` via `OCamlInstall` existant. Le script refuse explicitement de tourner ailleurs que sur Fedora.
- **Pas de gestion multi-conteneurs** — un seul toolbox `$STUDENT_TOOLBOX_NAME` (défaut `student-dev`). Override par env var si besoin.
- **Pas de packaging système** — pas de rpm/deb, pas de `.desktop`, pas d'auto-symlink dans `/usr/local/bin`.
- **Pas de CI** — validation manuelle + `bash -n` + `shellcheck` (optionnel).
- **Pas de `dnf upgrade` automatique** du conteneur. Fraîcheur via `clean` + `setup`.

---

## Step-by-Step Tasks

### Task 1 — Créer `scripts/tb-ocaml.sh`

- **ACTION** : nouveau fichier exécutable, ~150 lignes bash strict
- **IMPLEMENT** : structure à subcommands
  - En-tête : shebang `#!/usr/bin/env bash` + `set -euo pipefail` + bloc de commentaires doc d'usage (parsé par `cmd_help`)
  - Constantes : `TOOLBOX_NAME="${STUDENT_TOOLBOX_NAME:-student-dev}"`, `WORKSPACE="${STUDENT_WORKSPACE:-/tmp/${USER:-$(id -un)}}"`, `STORAGE_CONF="$WORKSPACE/containers/storage.conf"`, `GRAPHROOT`, `RUNROOT`
  - Fonction `ensure_storage()` : `mkdir -p` les chemins, génère `storage.conf` si absent ou obsolète, `export CONTAINERS_STORAGE_CONF`
  - Fonction `ensure_fedora()` : vérifie `/etc/os-release` contient `ID=fedora`, échoue sinon
  - Fonction `ensure_toolbox()` : `command -v toolbox` ou message pointant sur `sudo dnf install -y toolbox`
  - Fonction `cmd_setup()` : ensure_* + `toolbox create -y -c "$TOOLBOX_NAME"` (si absent) + `toolbox run -c "$TOOLBOX_NAME" sudo dnf install -y ocaml ocaml-compiler-libs ocaml-findlib rlwrap make`
  - Fonction `cmd_clean()` : `toolbox rm -f "$TOOLBOX_NAME"` (ignore erreur si absent) + `podman rmi -a -f` sous le storage.conf custom + `rm -rf "$WORKSPACE/containers"` + affiche l'espace libéré
  - Fonction `cmd_status()` : affiche nom conteneur / workspace / storage path / taille `du -sh` / présence conteneur via `toolbox list -c`
  - Fonction `cmd_help()` : imprime le bloc de commentaires du haut
  - Fonction `cmd_run()` : ensure_* + vérifie conteneur existe sinon renvoie vers `setup` + warn si cwd hors `$HOME`/`/tmp` + `exec toolbox run -c "$TOOLBOX_NAME" "$@"`
  - Dispatcher final :
    ```bash
    case "${1:-help}" in
      setup)  shift; cmd_setup "$@"  ;;
      clean)  shift; cmd_clean "$@"  ;;
      status) shift; cmd_status "$@" ;;
      help|-h|--help) cmd_help ;;
      *)      cmd_run "$@"           ;;
    esac
    ```
- **MIRROR** : `WORKSPACE_DEFAULT`, `STORAGE_CONF_GENERATION`, `OCAML_INSTALL_SEQUENCE`, `STRICT_MODE`, `FRENCH_UX_MESSAGES`
- **IMPORTS** : aucun (bash pur ; dépendances externes : `toolbox`, `podman`, `dnf` dans le conteneur)
- **GOTCHA** :
  - `toolbox rm -f` nécessite parfois `toolbox stop` d'abord — utiliser `|| true` pour tolérer.
  - `podman rmi -a -f` sans `CONTAINERS_STORAGE_CONF` ciblerait le storage par défaut (`~/.local/share/containers`) — d'où l'appel à `ensure_storage` avant.
  - `toolbox create` DOIT tourner avec `CONTAINERS_STORAGE_CONF` exporté, sinon le conteneur atterrit dans `$HOME` et sature le NFS.
  - `toolbox run` du poste hôte hérite de `$PWD` si celui-ci est dans un bind-mount (`$HOME` et `/tmp` le sont par défaut). Sinon retombe sur `$HOME` → d'où le warn.
  - `make` n'est pas toujours présent dans l'image toolbox de base → l'ajouter explicitement au `dnf install`.
- **VALIDATE** :
  ```bash
  bash -n scripts/tb-ocaml.sh
  scripts/tb-ocaml.sh help
  # sur Fedora uniquement :
  scripts/tb-ocaml.sh setup
  scripts/tb-ocaml.sh status                # → « conteneur présent »
  cd /tmp/$USER/GitOcaml/21/ex00 && /tmp/chillion/42_ZSH-Student-Helper/scripts/tb-ocaml.sh make
  ls *.cmx ex00                              # artefacts créés
  ./ex00                                     # binaire natif tourne
  scripts/tb-ocaml.sh clean
  du -sh /tmp/$USER/containers 2>/dev/null   # doit être inexistant
  ```

### Task 2 — Mettre à jour `CLAUDE.md`

- **ACTION** : ajouter une bullet dans la sous-section « OS detection & Fedora/Toolbox integration »
- **IMPLEMENT** :
  > - **Portable script `scripts/tb-ocaml.sh`**: standalone wrapper (no `.zshrc` dependency) that compiles OCaml via Toolbox on any Fedora workstation. Subcommands: `setup`, `clean`, `status`, `help`; any other argument is forwarded to `toolbox run -c "$STUDENT_TOOLBOX_NAME"` (e.g. `tb-ocaml make`, `tb-ocaml ocamlopt -c atom.ml`, `tb-ocaml rlwrap ocaml`). Re-implements `_ensure_toolbox_storage` internally so the NFS quota is preserved even on machines where the project isn't deployed.
- **MIRROR** : ton factuel anglais du reste de `CLAUDE.md`
- **IMPORTS** : N/A
- **GOTCHA** : ne pas supprimer la section existante, juste l'étendre
- **VALIDATE** : `grep tb-ocaml CLAUDE.md` doit matcher

### Task 3 — Étendre `docs/ENVIRONMENT_SAFETY.md`

- **ACTION** : ajouter sous la section « Variables Fedora / Toolbox (auto-détectées) » un sous-bloc « Usage portable sur poste étranger »
- **IMPLEMENT** :
  ```markdown
  #### Usage portable sur poste Fedora étranger

  Le script `scripts/tb-ocaml.sh` fonctionne **sans** avoir déployé le projet :
  copie-le simplement sur le poste cible et utilise :

  ```bash
  chmod +x tb-ocaml.sh
  ./tb-ocaml.sh setup          # crée le toolbox + installe ocaml/rlwrap/make
  cd /tmp/$USER/GitOcaml/21/ex00
  /path/to/tb-ocaml.sh make    # compile via le toolbox, cwd preservee
  /path/to/tb-ocaml.sh make test
  /path/to/tb-ocaml.sh clean   # fin de TP → libere tout l'espace disque
  ```

  Le stockage reste dans `/tmp/$USER/containers/` → quota NFS intact.
  ```
- **MIRROR** : style des blocs de code existants dans le fichier
- **IMPORTS** : N/A
- **GOTCHA** : aligner le nom `student-dev` avec `STUDENT_TOOLBOX_NAME` déjà documenté plus haut
- **VALIDATE** : `grep tb-ocaml docs/ENVIRONMENT_SAFETY.md` doit matcher

---

## Testing Strategy

Pas de framework bash → **validation manuelle** + `bash -n` + `shellcheck` (optionnel).

### Checklist manuelle (poste Fedora 42 réel)

- [ ] `bash -n scripts/tb-ocaml.sh` → 0 erreur
- [ ] `shellcheck scripts/tb-ocaml.sh` → 0 warning critique
- [ ] `scripts/tb-ocaml.sh help` affiche l'usage complet
- [ ] `scripts/tb-ocaml.sh status` avant setup → « conteneur absent »
- [ ] `scripts/tb-ocaml.sh setup` crée le toolbox, installe les paquets, idempotent sur 2ème appel
- [ ] `ls /tmp/$USER/containers/storage/` non vide après setup
- [ ] `ls $HOME/.local/share/containers` vide ou inchangé (NFS préservé)
- [ ] `cd /tmp/$USER/GitOcaml/21/ex00 && scripts/tb-ocaml.sh make` → produit `ex00`
- [ ] `./ex00` s'exécute hors toolbox
- [ ] `scripts/tb-ocaml.sh make clean && scripts/tb-ocaml.sh make re` → cycle complet OK
- [ ] `scripts/tb-ocaml.sh rlwrap ocaml` ouvre un REPL interactif
- [ ] `scripts/tb-ocaml.sh clean` supprime le conteneur + images + dossier containers
- [ ] `du -sh /tmp/$USER/containers 2>/dev/null` → vide après clean

### Edge Cases

- [ ] Exécution sur Ubuntu → refus propre (`ensure_fedora` échoue avec message)
- [ ] Exécution sans `toolbox` → message pointant sur `dnf install toolbox`
- [ ] `setup` quand le conteneur existe déjà → message informatif, pas de recréation
- [ ] `clean` quand le conteneur n'existe pas → pas d'erreur fatale
- [ ] cwd hors `$HOME` et `/tmp` (ex. `/usr/local/src/foo`) → warning puis tentative
- [ ] `$STUDENT_WORKSPACE` non défini → fallback `/tmp/$(id -un)`
- [ ] `$USER` non défini → fallback `id -un`

---

## Validation Commands

### Static Analysis

```bash
bash -n /tmp/chillion/42_ZSH-Student-Helper/scripts/tb-ocaml.sh
```
EXPECT : aucune sortie, code retour 0

```bash
shellcheck /tmp/chillion/42_ZSH-Student-Helper/scripts/tb-ocaml.sh
```
EXPECT : 0 erreur, warnings stylistiques acceptables

### Functional (Fedora uniquement)

```bash
./tb-ocaml.sh setup
./tb-ocaml.sh status
cd GitOcaml/21/ex00
/path/to/tb-ocaml.sh make test
/path/to/tb-ocaml.sh clean
```

### Manual Validation
- [ ] `scp` du script sur un 2ème poste Fedora → workflow identique sans `.zshrc`
- [ ] `df -h $HOME` avant/après setup → pas de changement visible (tout est dans `/tmp`)

---

## Acceptance Criteria

- [ ] `scripts/tb-ocaml.sh` présent, exécutable, `bash -n` clean
- [ ] Chaque subcommand (`setup`, `make`, `clean`, `status`, `help`) fonctionne sur un poste Fedora
- [ ] Le conteneur et ses images vivent exclusivement sous `/tmp/$USER/containers/`
- [ ] `clean` libère 100 % de l'espace occupé
- [ ] Le script fonctionne sans avoir sourcé le `.zshrc` du projet
- [ ] Compilation de `GitOcaml/21/ex00/Makefile` réussit via `tb-ocaml make`
- [ ] Documentation mise à jour dans `CLAUDE.md` et `docs/ENVIRONMENT_SAFETY.md`

## Completion Checklist

- [ ] Script suit `set -euo pipefail`
- [ ] Messages utilisateur en français avec émojis cohérents avec `data/.zshrc`
- [ ] Aucune dépendance au `.zshrc` (variables avec défaut)
- [ ] `CONTAINERS_STORAGE_CONF` exporté avant toute commande `toolbox`/`podman`
- [ ] `ensure_fedora` + `ensure_toolbox` appelés avant toute opération destructive
- [ ] Commit : `feat: script portable tb-ocaml pour compilation OCaml via Toolbox Fedora`

## Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Image `registry.fedoraproject.org/fedora-toolbox` indisponible (réseau école) | Faible | `setup` échoue | Message d'erreur clair, pas de retry infini |
| cwd sur un FS non monté | Faible | `make` échoue silencieusement | Warning préalable dans `cmd_run` |
| `podman rmi -a -f` supprime d'autres images | Moyenne | Perte d'images Podman de l'étudiant | Limité par `CONTAINERS_STORAGE_CONF` custom → n'affecte que `/tmp/$USER/containers/` |
| `set -e` interrompt `cmd_clean` si toolbox absent | Moyenne | `clean` partiel | Chaque suppression utilise `\|\| true` explicite |

## Notes

- Nom court retenu : `tb-ocaml` = « toolbox ocaml ». Alternative rejetée : `ocaml-in-toolbox.sh` (trop long pour usage répété).
- Image `fedora-toolbox` ~400 Mo téléchargée une fois. Après `dnf install ocaml`, le conteneur occupe ~450–500 Mo — annoncer dans le message de `setup` pour éviter les surprises sur les postes avec `/tmp` petit.
- Option future (NOT building) : alias zsh `tb-ocaml` pointant sur `$PROJECT/scripts/tb-ocaml.sh` pour les postes déployés.
