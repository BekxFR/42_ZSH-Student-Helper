# Configuration Dynamique de l'Espace Utilisateur

## 🎯 Vue d'ensemble

Le 42_ZSH Student Helper utilise un système d'espace de travail dynamique et spécifique à chaque utilisateur, avec **détection automatique** de la base de stockage la plus appropriée : `/goinfre/$USER` en priorité (postes 42, persistant), `/tmp/$USER` en fallback (hors-42 ou `/goinfre` indisponible).

## 🔄 Évolution de l'Architecture

### v3.x — Workspace adaptatif (actuel)

```bash
# Sélection automatique : /goinfre prioritaire, /tmp fallback
/goinfre/             # ← Préféré sur postes 42 (persistant, ~50 GB)
├── alice/            # Utilisateur alice
│   ├── homebrew/
│   ├── node/
│   ├── .cache/
│   └── containers/   # Images Podman/Toolbox (persistantes entre sessions)
├── bob/
└── chillion/

# OU (machine sans /goinfre : laptop perso, Docker, CI)
/tmp/
├── alice/            # Volatile (purgé entre sessions)
├── bob/
└── chillion/
```

### v2.x — `/tmp/$USER` (legacy multi-user)

Espaces utilisateur isolés dans `/tmp/$USER` avec sticky bit 1777.

### v1.x — `/tmp/tmp` partagé (obsolète)

Espace partagé sans isolation — risques de collision multi-utilisateur, remplacé en v2.

## 🚀 Fonctionnalités

### 1. Résolution Automatique du Workspace

```bash
# Au démarrage du shell, _resolve_student_workspace_base() applique :
#   1. Override : $STUDENT_WORKSPACE_BASE (si défini)
#   2. /goinfre/$USER si /goinfre est présent + écriture possible (postes 42)
#   3. /tmp/$USER en fallback (machines sans /goinfre)
export STUDENT_WORKSPACE="$(_resolve_student_workspace_base)"
export STUDENT_WORKSPACE_KIND="goinfre"  # ou "tmp" / "custom"
```

### 2. Fallback Robuste

Si `/goinfre/$USER` devient inaccessible en cours de session (perms changées, montage instable) :
- `setup_temp_directories()` bascule automatiquement sur `/tmp/$USER`
- Aucune intervention utilisateur requise
- Logs `logs_warning` émis pour traçabilité

### 3. Isolation des Ressources
Chaque utilisateur dispose de son propre espace pour :
- **Homebrew** : `$STUDENT_WORKSPACE/homebrew`
- **Node.js/npm** : `$STUDENT_WORKSPACE/node` et `$STUDENT_WORKSPACE/npm-global`
- **Discord** : `$STUDENT_WORKSPACE/discord`
- **Cache Python** : `$STUDENT_WORKSPACE/.cache`
- **Binaires** : `$STUDENT_WORKSPACE/bin`

## ⚙️ Configuration Technique

### Variables d'Environnement
```bash
# Résolution automatique au sourcing du .zshrc
export STUDENT_WORKSPACE="$(_resolve_student_workspace_base)"  # /goinfre/$USER ou /tmp/$USER
export STUDENT_WORKSPACE_KIND="goinfre"   # ou "tmp" / "custom"

# Dérivées (toujours basées sur $STUDENT_WORKSPACE)
export N_PREFIX="$STUDENT_WORKSPACE/node"
export XDG_CACHE_HOME="$STUDENT_WORKSPACE/.cache"     # si STUDENT_USE_PORTABLE_XDG=1
export PYTHONUSERBASE="$STUDENT_WORKSPACE"            # si STUDENT_USE_PORTABLE_PYTHON=1
export PATH="$STUDENT_WORKSPACE/node/bin:$STUDENT_WORKSPACE/npm-global/bin:$PATH"
```

### Override manuel

```bash
# Forcer un chemin spécifique (CI, tests, ou contrainte particulière)
export STUDENT_WORKSPACE_BASE="/tmp/$USER"   # forcer /tmp même si /goinfre est dispo
source ~/.zshrc

# Ou pour pointer vers un autre emplacement entièrement
export STUDENT_WORKSPACE_BASE="/data/$USER/workspace"
source ~/.zshrc
```

⚠️ `STUDENT_WORKSPACE_BASE` est un **chemin complet** (le `$USER` n'est PAS ajouté automatiquement).

### Gestion des Permissions
```bash
# Vérification automatique des permissions
if mkdir -p "$base_dir" 2>/dev/null && [[ -w "$base_dir" ]]; then
    selected_dir="$base_dir"  # Utilise l'espace utilisateur
else
    selected_dir="$fallback_dir"  # Fallback vers espace partagé
fi
```

## 🔧 Avantages

### 1. Isolation des Utilisateurs
- **Élimination des collisions** : Chaque utilisateur a son propre espace
- **Sécurité renforcée** : Pas d'accès aux données d'autres utilisateurs
- **Debugging simplifié** : Logs et états isolés par utilisateur

### 2. Compatibilité Garantie
- **Fallback automatique** : Fonctionne même si l'espace utilisateur est inaccessible
- **Rétrocompatibilité** : Les scripts existants continuent de fonctionner
- **Migration transparente** : Aucune action utilisateur requise

### 3. Optimisation des Ressources
- **Nettoyage ciblé** : Possibilité de nettoyer l'espace d'un utilisateur spécifique
- **Monitoring granulaire** : Tracking de l'utilisation par utilisateur
- **Quota potentiel** : Base pour implémenter des limitations par utilisateur

## 🚨 Considérations Importantes

### 1. Persistance des Données

**Mode `/goinfre` (postes 42, défaut)** :
- ✅ Survit aux fermetures de session / login-out
- ✅ Survit aux redémarrages du poste
- ❌ Perdu lors d'une bascule de poste (autre machine = autre `/goinfre`)
- ⚠️ Quota limité (~50 GB partagés avec autres outils 42)
- **Ne jamais stocker de données critiques** — c'est un cache, pas un backup

**Mode `/tmp` (fallback hors-42)** :
- ❌ Effacé entre les sessions / au redémarrage
- ❌ Régénération obligatoire de Homebrew, Node, Cargo à chaque login
- **Ne jamais stocker de données critiques**

Dans les deux cas, le contenu est régénérable (caches, binaires installés par scripts). Les données utilisateur (settings VS Code, extensions, sessions auth) restent dans `$HOME` (NFS).

### 2. Espace Disque
```bash
# Vérifier le mode actif et l'espace disponible
echo "Workspace: $STUDENT_WORKSPACE (mode: $STUDENT_WORKSPACE_KIND)"
df -h "$STUDENT_WORKSPACE"

# Voir l'utilisation détaillée du workspace utilisateur
du -sh "$STUDENT_WORKSPACE"/*

# Sur poste 42 : voir l'occupation de /goinfre par utilisateur (si lisible)
du -sh /goinfre/* 2>/dev/null | sort -h | tail -10
```

### 3. Sécurité
- Permissions standard Unix appliquées
- Répertoires utilisateur créés avec `umask` par défaut
- Pas de privilege escalation

## 🛠️ Utilisation Pratique

### Commandes de Diagnostic
```bash
# Voir l'espace de travail actuel et son type
echo "Workspace: $STUDENT_WORKSPACE"
echo "Type:      $STUDENT_WORKSPACE_KIND"   # goinfre | tmp | custom

# Vérifier l'utilisation
ls -la "$STUDENT_WORKSPACE"
du -sh "$STUDENT_WORKSPACE"/*

# Forcer une réévaluation du workspace après création de /goinfre/$USER
source ~/.zshrc

# Nettoyer son espace (attention : destructif, regénération nécessaire)
rm -rf "$STUDENT_WORKSPACE"/*

# Tester l'override
STUDENT_WORKSPACE_BASE="/tmp/$USER" zsh -c 'echo $STUDENT_WORKSPACE'
# → /tmp/$USER (force le fallback même si /goinfre est dispo)
```

### Fonctions Adaptées
Toutes les fonctions utilisent automatiquement `$STUDENT_WORKSPACE` :
- `STmp` : Ouvre VS Code dans l'espace utilisateur
- `discord` : Installe Discord dans l'espace utilisateur
- `NodeInstall` : Installe Node.js dans l'espace utilisateur
- Installation Homebrew : Se fait dans l'espace utilisateur

## 🔄 Migration depuis v1.x

### Migration Automatique
Le système détecte automatiquement l'ancien format et migre silencieusement vers le nouveau.

### Migration Manuelle (si nécessaire)
```bash
# Sauvegarder les données importantes de l'ancien système
cp -r /tmp/tmp/important_data ~/backup/

# Redémarrer le shell pour activer le nouveau système
source ~/.zshrc

# Réinstaller les outils si nécessaire
NodeInstall
IBrew  # Réinstaller Homebrew si nécessaire
```

## 📊 Monitoring et Maintenance

### Scripts de Nettoyage Recommandés
```bash
#!/bin/bash
# Nettoyer les espaces utilisateur orphelins (à exécuter par l'admin système)

USERS_IN_TMP=$(ls /tmp/tmp/ | grep -v '^[.]*$')
ACTIVE_USERS=$(who | awk '{print $1}' | sort -u)

for user_dir in $USERS_IN_TMP; do
    if ! echo "$ACTIVE_USERS" | grep -q "^$user_dir$"; then
        echo "Nettoyage de l'espace orphelin: /tmp/tmp/$user_dir"
        rm -rf "/tmp/tmp/$user_dir"
    fi
done
```

### Monitoring de l'Espace
```bash
# Voir l'utilisation par utilisateur
du -sh /tmp/tmp/* | sort -h

# Alerter si l'espace total dépasse un seuil
USAGE=$(du -s /tmp/tmp | cut -f1)
if [ $USAGE -gt 1048576 ]; then  # 1GB en KB
    echo "⚠️ Utilisation élevée de /tmp/tmp: $(du -sh /tmp/tmp | cut -f1)"
fi
```

## 🎯 Prochaines Évolutions

### Fonctionnalités Prévues
1. **Quota automatique** : Limitation de l'espace par utilisateur
2. **Cleanup intelligent** : Nettoyage automatique basé sur l'activité
3. **Backup optionnel** : Sauvegarde automatique des données critiques
4. **Monitoring avancé** : Métriques d'utilisation en temps réel

### Améliorations Possibles
1. **Chiffrement** : Chiffrement optionnel des données utilisateur
2. **Compression** : Compression automatique des caches inactifs
3. **Network storage** : Support pour stockage réseau temporaire
4. **Container support** : Compatibilité avec les environnements conteneurisés

---

**Note** : Cette documentation décrit les changements implementés pour résoudre les problèmes de collision entre utilisateurs tout en maintenant la compatibilité et la robustesse du système.
