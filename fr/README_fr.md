<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (README.md) | [Traduction] (en/README_en.md) | [Deutsch] (de/README_de.md) | [English] (fr/README_fr.md) | [Español] (es-ES/README_es.md) | [Japonais] (ja/README_ja.md) | [한국어] (ko/README_ko.md) | [Português] (pt-PT/README_pt.md) | [Русский] (ru/README_ru.md) | [Chinois traditionnel] (zh-TW/README_zh.md) |

<!-- LANG_HEADER_END -->

# Collection d’exemples de projets Ducky SDK

[! [Construire] (https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.NET] (https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [NuGet] (https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [Licence] (https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [Plate-forme] (https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [Langue] (https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! [Cible] (https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [Questions] (https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [Demandes de tirage] (https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [Dernière validation] (https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

Ce dépôt contient plusieurs exemples de projets pour démontrer le développement du mod « Escape from Duckov », en utilisant [Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk).

## 📋 Préparé

Avant de commencer, assurez-vous que votre environnement de développement est prêt：

👉 [Voir la documentation de préparation de l’environnement](docs/Prequirement.md)\*\*

Principales exigences :：

- Kit de développement logiciel (SDK) .NET 10.x
- Outil global：'dotnet-script',��'dotnet-ilrepack'
- Systèmes d’exploitation pris en charge：Windows / Linux / macOS

## 🎯 Démarrez rapidement

```bash
# Cloner le dépôt
git clone <repository-url>
Échantillons de cd

# Construire tous les exemples
dotnet build Docky.Sdk.Sample.slnx

# ou construire un seul exemple
dotnet build Ducky.SingleProject/
```

## 📚 Exemple de visite du projet

Ce référentiel organise les exemples dans l’ordre de facile à difficile, et il est recommandé d’étudier dans l’ordre suivant：

### 1️⃣ Entrée de gamme - concepts de base

#### [Ducky.SingleProject] (Ducky.SingleProject/- Le mod le plus simple

**difficulté：⭐**

L’exemple de mod à objet unique le plus basique, adapté aux novices complets.

- ✅ Structure à élément unique
- ✅ Cycle de vie du mod ('ModEnabled' / 'ModDisabled')
- ✅ Journalisation de base
- ✅ Configuration et construction du projet

Points clés à apprendre：\*\*

- Comment créer un mod minimum fonctionnel
- ['ModBehaviour'] (Ducky.SingleProject/ModBehaviour.cs) classe d’entrée
- La configuration de base du fichier '.csproj'

**Convient aux personnes：** Développeurs novices sur le SDK Ducky

👉 [Voir le tutoriel détaillé](Ducky.SingleProject/README.md)

---

#### [Ducky.InstantKill] (Ducky.InstantKill/- Gestion des événements de jeu

**difficulté：⭐⭐**

Montre comment s’abonner aux événements du jeu et mettre en œuvre des modifications simples de la logique du jeu.

- ✅ Abonnement à un événement de jeu ('Health.OnHurt')
- ✅ Implémentation du gestionnaire d’événements
- ✅ Gestion des ressources tout au long du cycle de vie

Points clés à apprendre：\*\*

- Comment écouter les événements dans le jeu
- Comment s’abonner et se désabonner en toute sécurité d’événements
- ['DamageInfo'] (Ducky.InstantKill/ModBehaviour.cs) et d’autres API de jeu

**Convient aux personnes：** Les développeurs qui comprennent la structure de base du mod et qui souhaitent implémenter la logique du jeu

👉 [Voir le tutoriel détaillé](Ducky.InstantKill/README.md)

---

### 2️⃣ Niveau avancé - Fonctionnalités de base

#### [Ducky.Localisation] (Ducky.Localization/- Localisation multilingue

**difficulté：⭐⭐⭐**

Un exemple complet de système de localisation avec prise en charge multilingue et traduction basée sur des fichiers.

- ✅ Définition de clé localisée(['LK.cs'](Ducky.Localization/LK.cs)）
- ✅ Fichier de traduction CSV
- ✅ Traduction de documents (Markdown)
- ✅ Support multilingue (chinois simplifié et anglais)

Points clés à apprendre：\*\*

- Comment organiser les clés de localisation
- Utilisation des fonctionnalités '[LanguageSupport]' et '[TranslateFile]'
- Générées automatiquement par les fonctions « lkeys.json » et « keys.hash.txt » du SDK
- Accès d’exécution aux chaînes de traduction

**Convient aux personnes：** Les développeurs qui ont besoin de développer des mods multilingues

👉 [Voir le tutoriel détaillé](Ducky.Localization/README.md)

---

#### [Ducky.BuffRegistration] (Ducky.BuffRegistration/) - Entités de jeu personnalisées

\*\*difficulté：⭐⭐⭐

Montre comment enregistrer des buffs personnalisés et les intégrer à votre système de jeu.

- ✅ Utilisez 'Contract.Buffs.RegisterBuff' pour enregistrer le buff
- ✅ Gestion des événements de scène ('SceneLoader.onAfterSceneInitialize')
- ✅ Création et ajout d’instances de buff
- ✅ Localiser le nom et la description du Buff

Points clés à apprendre：\*\*

- Comment étendre le système de base du jeu
- Modèles d’utilisation de l’API Contract
- Gestion du cycle de vie des scénarios
- Configuration et enregistrement des entités de jeu

**Convient aux personnes：** Les développeurs qui souhaitent ajouter du contenu de jeu personnalisé

👉 [Voir le tutoriel détaillé](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/- Gestion des dépendances tierces

**difficulté：⭐⭐⭐**

Montre comment utiliser des packages NuGet dans des mods (en utilisant YamlDotNet comme exemple).

- ✅ Présentation des packages NuGet tiers
- ✅ Lire et analyser les fichiers de ressources
- ✅ Empaquetage et déploiement dépendants

Points clés à apprendre：\*\*

- Comment utiliser les bibliothèques externes dans les mods
- Le chemin d’accès du fichier de ressources
- Mécanisme de gestion des dépendances du SDK

**Convient aux personnes：** Les développeurs qui ont besoin d’étendre les fonctionnalités avec des bibliothèques tierces

---

### 3️⃣ Avancé - Mode complexe

#### [Ducky.EntranceMod] (Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/- Architecture à plusieurs niveaux

**difficulté：⭐⭐⭐⭐**

Montre comment diviser des mods en architectures multicouches pour la réutilisation du code.

- ✅ Le projet de mod principal est séparé de la bibliothèque publique
- ✅ \`<ExcludeSdkLib>» et «<IsModLib>' configuration
- ✅ Partage des clés de localisation entre les projets
- ✅ Gestion des références de projet

Points clés à apprendre：\*\*

- Organisation de solutions multi-projets
- Comment créer une bibliothèque de mods réutilisable
- Partage de fichiers de ressources entre projets
- Conception architecturale pour les grands mods

**Convient aux personnes：** Équipes développant des mods de grande taille ou en série

---

#### [Ducky.TryHarmony] (Ducky.TryHarmony/- Injection de code d’exécution

**difficulté：⭐⭐⭐⭐⭐**

Utilisez HarmonyLib pour corriger le code du jeu au moment de l’exécution afin d’apporter les modifications les plus importantes au jeu.

- ✅ Système de brassage Harmony
- ✅ méthode préfixe/suffixe/remplacement
- ✅ Enregistrement et nettoyage des correctifs
- ✅ Accès à l’API dans le jeu

Points clés à apprendre：\*\*

- Utilisation de base d’HarmonyLib
- Comment écrire des correctifs Prefix/Postfix
- Bonnes pratiques pour la modification du code d’exécution
- Gestion du cycle de vie des correctifs

**exemple：** ['SaveFilePatch'](Ducky.TryHarmony/SaveFilePatch.csDémonstration de l’interception des opérations d’archivage

**Convient aux personnes：** Développeurs avancés qui ont besoin de modifier profondément la logique du jeu

⚠️ **Note.：** Les correctifs Harmony sont puissants mais doivent être utilisés avec prudence, et des correctifs incorrects peuvent provoquer le plantage du jeu

👉 [Voir le tutoriel détaillé](Ducky.TryHarmony/README.md)

---

## 🏗️ Architecture du projet

Tous les exemples de projets suivent les conventions de base suivantes：

### Configuration du projet (obligatoire)

```xml
<PropertyGroup>
  <TargetFramework>netstandard2.1</TargetFramework>
  <Nullable>Activer</Nullable>
  <LangVersion>Aperçu</LangVersion>
  <ImplicitUsings>vrai</ImplicitUsings>
  <ModName>VotreModName</ModName>
</PropertyGroup>
```

### Point d’entrée du mod

```csharp
classe publique ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Logique d’initialisation lorsque le mod est activé
    }

    protected override void ModDisabled()
    {
        Logique de nettoyage lorsque le mod est désactivé
    }
}
```

### Structure du fichier de ressources

```
actif/
├── info.ini # Métadonnées du mod
├── description.md # Description détaillée (facultatif)
├── preview.png # Aperçu (facultatif)
"�── lkeys.json # Liste de contrôle de localisation (générée automatiquement)
"Hash de validation keys.hash.txt # (généré automatiquement)
└── Locales/
    "2�── zh.csv # Traduction en chinois simplifié
    "2�── en.csv # Traduction anglaise
    └── fr/ # Traduction basée sur des documents
        └── *.md
```

## 📖 Recommandations de parcours d’apprentissage

### Parcours débutant

1. [Ducky.SingleProject] (Ducky.SingleProject/- Comprendre l’infrastructure
2. [Ducky.InstantKill] (Ducky.InstantKill/- Apprendre la gestion des incidents
3. [Ducky.Localisation] (Ducky.Localization/- Localisation principale
4. [Ducky.BuffRegistration] (Ducky.BuffRegistration/) - Élargit le contenu du jeu

### Parcours avancé

1. [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/) - Utiliser des bibliothèques tierces
2. [Ducky.EntranceMod] (Ducky.EntranceMod/- Conception d’architecture multicouche
3. [Ducky.TryHarmony] (Ducky.TryHarmony/- Injection de code d’exécution

## 🛠️ Construire et déployer

### Commandes de compilation

```bash
# Construire tous les projets
dotnet build Docky.Sdk.Sample.slnx

# Construire un seul projet
dotnet build Ducky.SingleProject/

# Nettoyer le build
dotnet propre
```

### Déploiement automatisé

Le SDK déploie automatiquement les mods dans le répertoire du jeu au moment de la construction (nécessite la configuration de 'local.props' ou le réglage de '.csproj')<SteamFolder>`/`<DuckovFolder>\`）：

```xml
<PropertyGroup>
  <SteamFolder>C :\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 Spécifications du projet

- **Format de la solution**：Utiliser le nouveau format XML '.slnx'
- **Analyse du code**：L’analyseur SDK intégré valide la structure du projet
- **Génération automatique**：Les métadonnées localisées sont générées automatiquement au moment de la compilation

## 🔗 Ressources connexes

- [Paquet NuGet Ducky.Sdk] (https://www.nuget.org/packages/Ducky.Sdk)
- [Page Steam du jeu] (https://store.steampowered.com/app/XXXXX(remplacé par le lien réel)
- [Documentation pour les développeurs] (docs/)

## 🤝 Lignes directrices sur les contributions

N’hésitez pas à soumettre des problèmes et des demandes de tirage pour améliorer l’exemple de projet !

## 📄 Permettre.

Ce projet utilise [LICENSE(LICENCE).

---

**Bon développement !🎮**
