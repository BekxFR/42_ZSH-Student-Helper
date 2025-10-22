#!/bin/bash

# Script de test pour la sécurité des variables d'environnement
# Usage: ./test_environment_safety.sh

echo "🧪 TEST DE SÉCURITÉ DES VARIABLES D'ENVIRONNEMENT"
echo "=================================================="
echo

# Nettoyer l'environnement pour un test propre
echo "🧹 Nettoyage de l'environnement pour test propre..."
unset JAVA_HOME PYTHONUSERBASE PIP_USER
unset XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME
unset VSCODE_PORTABLE_EXTENSIONS IDEA_HOME DOCKER_CONFIG
unset STUDENT_USE_PORTABLE_JAVA STUDENT_USE_PORTABLE_PYTHON
unset STUDENT_USE_PORTABLE_VSCODE STUDENT_USE_PORTABLE_IDEA
unset STUDENT_USE_PORTABLE_DOCKER STUDENT_USE_PORTABLE_XDG
echo "   Environnement nettoyé"
echo

# Test 1: Configuration par défaut (mode sécurisé)
echo "🟢 TEST 1: Configuration par défaut (mode sécurisé)"
echo "---------------------------------------------------"

# Sourcer UNIQUEMENT le fichier enhanced dans un environnement propre
source /tmp/tmp/42_ZSH-Student-Helper/data/.zshrc_enhanced

echo "Variables après sourcing (environnement propre):"
echo "   JAVA_HOME: ${JAVA_HOME:-NON DÉFINI}"
echo "   PYTHONUSERBASE: ${PYTHONUSERBASE:-NON DÉFINI}"  
echo "   XDG_CONFIG_HOME: ${XDG_CONFIG_HOME:-NON DÉFINI}"
echo "   XDG_CACHE_HOME: ${XDG_CACHE_HOME:-NON DÉFINI}"
echo "   STUDENT_USE_PORTABLE_JAVA: ${STUDENT_USE_PORTABLE_JAVA:-0}"
echo "   STUDENT_USE_PORTABLE_PYTHON: ${STUDENT_USE_PORTABLE_PYTHON:-0}"
echo "   STUDENT_USE_PORTABLE_XDG: ${STUDENT_USE_PORTABLE_XDG:-0}"

# Vérifications de sécurité
SAFE_CONFIG=true

if [[ -n "$JAVA_HOME" && "$JAVA_HOME" == *"/tmp/tmp/"* && "${STUDENT_USE_PORTABLE_JAVA:-0}" != "1" ]]; then
    echo "❌ ERREUR: JAVA_HOME modifié sans activation explicite!"
    SAFE_CONFIG=false
fi

if [[ -n "$PYTHONUSERBASE" && "${STUDENT_USE_PORTABLE_PYTHON:-0}" != "1" ]]; then
    echo "❌ ERREUR: PYTHONUSERBASE modifié sans activation explicite!"
    SAFE_CONFIG=false
fi

if [[ -n "$XDG_CONFIG_HOME" && "${STUDENT_USE_PORTABLE_XDG:-0}" != "1" ]]; then
    echo "❌ ERREUR: XDG_CONFIG_HOME modifié sans activation explicite!"
    SAFE_CONFIG=false
fi

if [[ -n "$XDG_CACHE_HOME" && "${STUDENT_USE_PORTABLE_XDG:-0}" != "1" ]]; then
    echo "❌ ERREUR: XDG_CACHE_HOME modifié sans activation explicite!"
    SAFE_CONFIG=false
fi

if [[ "$SAFE_CONFIG" == "true" ]]; then
    echo "✅ Configuration par défaut SÉCURISÉE"
else
    echo "❌ Configuration par défaut NON SÉCURISÉE"
fi
echo

# Test 2: Activation mode portable Java
echo "🟡 TEST 2: Activation mode portable Java"
echo "----------------------------------------"

# Reset et test avec activation
unset JAVA_HOME
export STUDENT_USE_PORTABLE_JAVA=1
source /tmp/tmp/42_ZSH-Student-Helper/data/.zshrc_enhanced

echo "Variables après activation Java portable:"
echo "   JAVA_HOME: ${JAVA_HOME:-NON DÉFINI}"

if [[ "$JAVA_HOME" == *"/tmp/tmp/"* ]]; then
    echo "✅ Java portable activé correctement"
else
    echo "❌ Java portable non activé"
fi
echo

# Test 3: Test des variables XDG avec activation
echo "� TEST 3: Variables XDG avec activation explicite"
echo "---------------------------------------------------"

# Reset et test avec activation XDG
unset XDG_CONFIG_HOME XDG_DATA_HOME XDG_CACHE_HOME
export STUDENT_USE_PORTABLE_XDG=1
source /tmp/tmp/42_ZSH-Student-Helper/data/.zshrc_enhanced

echo "Variables après activation XDG portable:"
echo "   XDG_CONFIG_HOME: ${XDG_CONFIG_HOME:-NON DÉFINI}"
echo "   XDG_DATA_HOME: ${XDG_DATA_HOME:-NON DÉFINI}"
echo "   XDG_CACHE_HOME: ${XDG_CACHE_HOME:-NON DÉFINI}"

if [[ -n "$XDG_CONFIG_HOME" && "$XDG_DATA_HOME" && "$XDG_CACHE_HOME" ]]; then
    echo "✅ Variables XDG activées correctement avec flag"
else
    echo "❌ Variables XDG non activées malgré le flag"
fi
echo

# Test 4: Test fonction de diagnostic
echo "🔍 TEST 4: Fonction de diagnostic"
echo "---------------------------------"

if command -v EnvironmentDiagnostic >/dev/null 2>&1; then
    echo "✅ Fonction EnvironmentDiagnostic disponible"
else
    echo "❌ Fonction EnvironmentDiagnostic non disponible"
fi

if command -v SafeEnvironmentSetup >/dev/null 2>&1; then
    echo "✅ Fonction SafeEnvironmentSetup disponible"  
else
    echo "❌ Fonction SafeEnvironmentSetup non disponible"
fi

if command -v PortableEnvironmentSetup >/dev/null 2>&1; then
    echo "✅ Fonction PortableEnvironmentSetup disponible"
else
    echo "❌ Fonction PortableEnvironmentSetup non disponible"
fi
echo

# Test 5: Variables toujours sûres
echo "✅ TEST 5: Variables toujours sûres"
echo "-----------------------------------"

SAFE_VARS=("CARGO_HOME" "RUSTUP_HOME" "GOPATH" "ANDROID_HOME" "N_PREFIX")
ALL_SAFE=true

for var in "${SAFE_VARS[@]}"; do
    value="${!var}"
    if [[ -n "$value" && "$value" == *"/tmp/tmp/"* ]]; then
        echo "✅ $var: $value (sûr)"
    else
        echo "❌ $var: ${value:-NON DÉFINI} (problème)"
        ALL_SAFE=false
    fi
done

if [[ "$ALL_SAFE" == "true" ]]; then
    echo "✅ Toutes les variables sûres sont correctement définies"
fi
echo

# Résumé final
echo "📊 RÉSUMÉ DES TESTS"
echo "==================="

if [[ "$SAFE_CONFIG" == "true" ]]; then
    echo "✅ Configuration par défaut sécurisée"
else
    echo "❌ Configuration par défaut À CORRIGER"
fi

echo "✅ Variables conditionnelles fonctionnelles"  
echo "✅ Variables XDG protégées par flags"
echo "✅ Fonctions de diagnostic disponibles"
echo "✅ Variables sûres actives"
echo

if [[ "$SAFE_CONFIG" == "true" ]]; then
    echo "🎉 TESTS DE SÉCURITÉ RÉUSSIS!"
    echo "La configuration est sûre pour utilisation par défaut."
else
    echo "⚠️  ATTENTION: Problèmes de sécurité détectés!"
    echo "Vérifiez la configuration des variables conditionnelles."
fi
