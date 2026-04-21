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

La nouvelle architecture `/tmp/$USER` présente trois propriétés alignées avec l'infrastructure 42 :

- **`$HOME` partagé NFS** entre tous les postes : le `~/.zshrc` déployé est le même partout, donc `$STUDENT_WORKSPACE` dérivé de `$USER` reste cohérent quelle que soit la machine.
- **`/tmp` local par machine** : chaque poste repart d'un workspace vide, ce qui évite les conflits d'état entre sessions simultanées.
- **Dual OS Ubuntu + Fedora** : la migration école est en cours, Fedora = cible finale. Aucun chemin dépendant de la distribution - le script `Deploy.sh` utilise `grep -Eq "^ID=(ubuntu|fedora)" /etc/os-release` pour valider le prérequis.

Les redirections portables (Claude Code via `~/.local/share/claude`, caches VS Code via `STUDENT_USE_PORTABLE_CACHE`) s'appuient sur cette invariance de `$USER` et fonctionnent transparentement lors d'une bascule Ubuntu↔Fedora.
