# Migration du Workspace: /tmp/tmp vers /tmp/USERNAME

## Problème Identifié

### Situation Initiale

- Architecture: `/tmp/tmp/USERNAME`
- Propriétaire de `/tmp/tmp`: `chillion:2022_paris`
- Permissions: `drwxr-xr-x` (755)
- **Problème**: Les autres utilisateurs ne peuvent pas créer de sous-répertoires

### Impact

- Solution inutilisable en environnement multi-utilisateur
- Blocage complet pour tout utilisateur autre que `chillion`
- Violation du principe d'accessibilité universelle

## Solution Implémentée

### Nouvelle Architecture

```bash
# Avant (problématique)
export STUDENT_WORKSPACE="/tmp/tmp/${USER:-$(whoami)}"

# Après (corrigée)
export STUDENT_WORKSPACE="/tmp/${USER:-$(whoami)}"
```

### Avantages de la Migration

1. **Accessibilité Universelle**
   - Chaque utilisateur peut créer son propre workspace
   - Pas de dépendance aux permissions d'un autre utilisateur

2. **Isolation Naturelle**
   - `/tmp/alice`, `/tmp/bob`, `/tmp/charlie`
   - Séparation automatique par utilisateur

3. **Conformité Standards Unix**
   - Utilisation directe de `/tmp` (permissions 1777)
   - Respect des conventions système

4. **Robustesse**
   - Pas de point de défaillance unique
   - Gestion automatique des permissions

## Changements Techniques

### 1. Variable Principale

```bash
# Configuration Node.js et npm dans /tmp/USERNAME (sans sudo)
# Dynamic user workspace - accessible to all users
export STUDENT_WORKSPACE="/tmp/${USER:-$(whoami)}"
```

### 2. Fonction setup_temp_directories()

- Suppression du fallback vers `/tmp/tmp`
- Ajout de gestion robuste des permissions
- Implémentation de nettoyage des processus orphelins

### 3. Système de Lock

```bash
cleanup_stale_processes() {
    local workspace="$1"
    local lock_file="$workspace/.workspace_lock"

    if [[ -f "$lock_file" ]]; then
        local lock_pid=$(cat "$lock_file" 2>/dev/null)
        if [[ -n "$lock_pid" ]] && ! kill -0 "$lock_pid" 2>/dev/null; then
            logs_debug "Nettoyage du lock orphelin: PID $lock_pid"
            rm -f "$lock_file"
        fi
    fi

    # Créer un nouveau lock
    echo $$ > "$lock_file"
}
```

### 4. Tests Mis à Jour

- Adaptation des tests de sécurité
- Validation du nouveau chemin
- Vérification de l'accessibilité multi-utilisateur

## Gestion de la Transition

### Pour les Utilisateurs Existants

1. **Migration Automatique**
   - Le script détecte automatiquement le nouveau chemin
   - Pas d'intervention manuelle requise

2. **Nettoyage Optionnel**
   ```bash
   # Si l'ancien workspace existe encore
   rm -rf /tmp/tmp/$USER  # Optionnel, pour libérer l'espace
   ```

### Validation Post-Migration

1. **Test Multi-Utilisateur**

   ```bash
   # En tant qu'utilisateur A
   source ~/.zshrc
   echo $STUDENT_WORKSPACE  # Doit afficher /tmp/userA

   # En tant qu'utilisateur B
   source ~/.zshrc
   echo $STUDENT_WORKSPACE  # Doit afficher /tmp/userB
   ```

2. **Test de Permissions**
   ```bash
   mkdir -p $STUDENT_WORKSPACE/test
   touch $STUDENT_WORKSPACE/test/file
   [[ -w $STUDENT_WORKSPACE ]] && echo "Permissions OK"
   ```

## Bénéfices de Sécurité

### Avant (Problématique)

- Dépendance aux permissions d'un utilisateur spécifique
- Point de défaillance unique
- Blocage possible de tous les utilisateurs

### Après (Sécurisé)

- Isolation complète par utilisateur
- Permissions natives de `/tmp` (1777)
- Pas de dépendance inter-utilisateur
- Nettoyage automatique des processus orphelins

## Conformité et Standards

### Respect des Conventions Unix

- Utilisation de `/tmp` selon les standards FHS
- Permissions système natives
- Nettoyage automatique par le système

### Bonnes Pratiques

- Un workspace par utilisateur
- Gestion des locks pour éviter les conflits
- Logging approprié pour le diagnostic

## Conclusion

Cette migration résout définitivement le problème d'accessibilité multi-utilisateur tout en maintenant l'isolation et la sécurité. L'architecture est maintenant conforme aux standards Unix et robuste en environnement partagé.

**Status**: ✅ Migration Complète - Solution Fonctionnelle Multi-Utilisateur

## Compatibilité OS et NFS (postes 42)

L'architecture workspace présente trois propriétés alignées avec l'infrastructure 42 :

- **`$HOME` partagé NFS** entre tous les postes : le `~/.zshrc` déployé est le même partout, donc `$STUDENT_WORKSPACE` dérivé de `$USER` reste cohérent quelle que soit la machine.
- **`/tmp` et `/goinfre` locaux par machine** : chaque poste utilise son propre stockage, ce qui évite les conflits d'état entre sessions simultanées.
- **Dual OS Ubuntu + Fedora** : la migration école est en cours, Fedora = cible finale. Aucun chemin dépendant de la distribution - le script `Deploy.sh` utilise `grep -Eq "^ID=(ubuntu|fedora)" /etc/os-release` pour valider le prérequis.

Les redirections portables (Claude Code via `~/.local/share/claude`, caches VS Code via `STUDENT_USE_PORTABLE_CACHE`) s'appuient sur cette invariance de `$USER` et fonctionnent transparentement lors d'une bascule Ubuntu↔Fedora.

---

## Migration v2 → v3 : `/tmp/$USER` → `/goinfre/$USER` (avec fallback)

### Motivation

Le workspace `/tmp/$USER` était purgé entre les sessions (et parfois en cours de session sur certains postes). Conséquences observées :

1. **Symlinks orphelins VS Code** : `~/.config/Code/Crashpad → /tmp/$USER/vscode-cache/Crashpad` devient un lien cassé après purge, provoquant `chrome_crashpad_handler: --database is required` au lancement de VS Code.
2. **Réinstallations répétées** : Homebrew (~500 MB), Node.js, Cargo, container images Podman (multi-GB sur Fedora) téléchargés à chaque login.
3. **Marketplaces Claude Code reset** : symlink `~/.claude/plugins/marketplaces` cassé entre sessions.

Sur les postes 42, `/goinfre/$USER` offre une persistance entre sessions sur la même machine et un quota plus généreux. La v3 introduit une **résolution adaptative** :

```
STUDENT_WORKSPACE_BASE override → /goinfre/$USER (si dispo) → /tmp/$USER (fallback)
```

### Avant (v2.x — workspace hardcodé)

```bash
export STUDENT_WORKSPACE="/tmp/${USER:-$(whoami)}"
```

### Après (v3.x — workspace adaptatif)

```bash
_resolve_student_workspace_base() {
    local _user="${USER:-$(whoami)}"
    # 1. Override absolu
    [[ -n "${STUDENT_WORKSPACE_BASE:-}" ]] && { printf '%s' "$STUDENT_WORKSPACE_BASE"; return 0; }
    # 2. /goinfre/$USER déjà créé et accessible (cas standard 42)
    local _goinfre_user="/goinfre/$_user"
    if [[ -d "$_goinfre_user" && -w "$_goinfre_user" ]]; then
        printf '%s' "$_goinfre_user"; return 0
    fi
    # 3. /goinfre existe + on peut créer /goinfre/$USER
    if [[ -d "/goinfre" && -w "/goinfre" ]] \
        && mkdir -p "$_goinfre_user" 2>/dev/null \
        && [[ -w "$_goinfre_user" ]]; then
        printf '%s' "$_goinfre_user"; return 0
    fi
    # 4. Fallback /tmp/$USER
    printf '%s' "/tmp/$_user"
}
export STUDENT_WORKSPACE="$(_resolve_student_workspace_base)"
export STUDENT_WORKSPACE_KIND=...   # goinfre | tmp | custom
```

### Bénéfices

| Aspect | v2 (`/tmp`) | v3 (`/goinfre` prioritaire) |
|---|---|---|
| Homebrew réinstallé | À chaque purge /tmp | Une seule fois par machine |
| Node/npm | À chaque purge /tmp | Persistant |
| Container Podman | Re-pull multi-GB | Persistant |
| Symlinks VS Code Crashpad | Cassés entre sessions | Stables |
| Quota disponible | /tmp limité | ~50 GB /goinfre |
| Compatibilité hors-42 | OK | OK (fallback /tmp) |

### Auto-réparation des symlinks Claude Code

La fonction `_ensure_claude_symlinks()` (et `_ensure_vscode_cache_symlinks()` pour VS Code) détecte les symlinks pointant vers un workspace obsolète (ex. ancien `/tmp/$USER` après bascule sur `/goinfre/$USER`) et les repointe automatiquement.

### Override pour CI / tests / cas spécifiques

```bash
# Forcer /tmp même si /goinfre est disponible
export STUDENT_WORKSPACE_BASE="/tmp/$USER"

# Forcer un chemin entièrement différent
export STUDENT_WORKSPACE_BASE="/data/$USER/workspace"

# Puis sourcer le .zshrc
source ~/.zshrc
```

⚠️ `STUDENT_WORKSPACE_BASE` est un **chemin complet** — le `$USER` n'est pas ajouté.

### Statut migration

✅ **Migration v3 complète et compatible v2** : les utilisateurs sans `/goinfre` continuent automatiquement avec `/tmp/$USER` (aucune action requise). Sur les postes 42, le bénéfice est immédiat dès le re-sourcing du `.zshrc`.
