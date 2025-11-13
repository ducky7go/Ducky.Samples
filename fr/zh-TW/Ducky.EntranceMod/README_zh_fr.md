<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.EntranceMod/README.md) | [Traduction] (../../en/Ducky.EntranceMod/README_en.md) | [Deutsch] (../../de/Ducky.EntranceMod/README_de.md) | [English] (../../fr/Ducky.EntranceMod/README_fr.md) | [Español] (../../es-ES/Ducky.EntranceMod/README_es.md) | [Japonais] (../../ja/Ducky.EntranceMod/README_ja.md) | [한국어] (../../ko/Ducky.EntranceMod/README_ko.md) | [Português] (../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский] (../../ru/Ducky.EntranceMod/README_ru.md) | [Chinois traditionnel] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod exemple de mod

簡要說明

Cet exemple montre comment développer des mods à l’aide d’un modèle d’architecture multicouche, en séparant le code partagé en projets de bibliothèque indépendants et en réalisant la réutilisation du code et la conception modulaire.Convient aux mods volumineux ou aux scénarios où le code doit être partagé entre plusieurs mods.

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

## 1. Présentation du projet

Cet exemple se compose de deux éléments：

- ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Entrée de mod contenant des fichiers de ressources
- **Projet de bibliothèque publique** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Base de code partagée

Ce modèle architectural s’applique：

- Les mods de grande taille nécessitent une gestion hiérarchique
- Plusieurs mods partagent une logique commune
- Développement collaboratif en équipe
- La logique métier doit être testée de manière indépendante

## 2. Structure du projet

```
Ducky.EntranceMod/ # Projet de mod principal
Configuration du projet Ducky.EntranceMod.csproj #
├── ModBehaviour.cs # Entrée du mod
"├── README.md
└── asset/ # répertoire de documents de ressource
    "├── info.ini
    « description.md
    « lkeys.json
    "├── keys.hash.txt
    └── Locales/
        "├── zh.csv
        └── en.csv

ducky.EntranceMod.Common/ # projet de bibliothèque publique
"Ducky.EntranceMod.Common.csproj # Configuration du projet de bibliothèque
├── LK.cs # Partager la clé de localisation
└── MyModBase.cs # Classe de base partagée
```

## 3. Configuration du projet de mod principal

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj :1).：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>vrai</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>tout</PrivateAssets>
      <IncludeAssets>Duree; construire; indigène; contentfiles ; Analyseurs; construiretransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**Description de la configuration de base：**

- \\`<ExcludeSdkLib>vrai</ExcludeSdkLib>- Évitez d’empaqueter à plusieurs reprises les bibliothèques SDK dans le répertoire de sortie

## 4. Configuration du projet de bibliothèque publique

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj :1).：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>vrai</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/assets</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>tout</PrivateAssets>
      <IncludeAssets>Duree; construire; indigène; contentfiles ; Analyseurs; construiretransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**Description de la configuration de base：**

- \\`<IsModLib>vrai</IsModLib>' - Marquez cet élément comme une bibliothèque de mods, et le SDK le gérera spécialement
- \\`<AssetsDir>' - Pointe vers le répertoire assets du projet principal afin que la clé de localisation soit générée correctement

## 5. Partagez des exemples de code

### Partager les clés de localisation

['Ducky.EntranceMod.Common/LK.cs'] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
espace de noms Ducky.EntranceMod.Common ;

public statique classe LK
{
    interface utilisateur de classe statique publique
    {
        public const string NiceWelcomeMessage = « ducky_entrancemod.common.ui.nicewelcomemessage » ;
    }
}
```

### Classes de base partagées

['Ducky.EntranceMod.Common/MyModBase.cs'] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
en utilisant Ducky.Sdk.ModBehaviours ;

espace de noms Ducky.EntranceMod.Common ;

classe abstraite publique MyModBase : ModBehaviourBase
{
    Une méthode commune partagée par tous les mods peut être ajoutée ici
    protected virtual void LogModInfo(message de chaîne)
    {
        Log.Info($"[{GetType(). Nom}] {message}");
    }
}
```

### Le mod principal utilise un code partagé

['Ducky.EntranceMod/ModBehaviour.cs'] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
à l’aide de Ducky.Sdk.Logging ;
en utilisant Ducky.EntranceMod.Common ;

espace de noms Ducky.EntranceMod ;

Hériter de la classe de base commune
classe publique ModBehaviour : MyModBase
{
    protected override void ModEnabled()
    {
        Log.Info(« Mod Enabled ») ;
        Utiliser une clé de localisation partagée
        var message = LK. UI. NiceWelcomeMessage ;
        LogModInfo($"Clé du message de bienvenue : {message}");
    }

    protected override void ModDisabled()
    {
        Log.Info(« Mod désactivé ») ;
    }
}
```

## 6. Avantages de l’architecture multicouche

### ✅ Multiplexage de code

- Plusieurs modérateurs peuvent partager la bibliothèque 'Ducky.EntranceMod.Common'
- Évitez la duplication de code et améliorez la maintenabilité

### ✅ Conception modulaire

- La logique métier est séparée de l’entrée Mod
- Test unitaire facile
- Effacer les dépendances

### ✅ Collaboration d’équipe

- Différents développeurs peuvent développer différentes couches indépendamment
- Réduire les conflits de code
- Révision facile du code

### ✅ Partage localisé

- Les bibliothèques publiques peuvent définir des clés de localisation partagées
- Tous les mods qui utilisent la bibliothèque sont automatiquement pris en charge pour la traduction

## 7. Construisez le processus

Le SDK gère automatiquement les dépendances multi-éléments：

```bash
# Construire l’ensemble de la solution (recommandé)
dotnet build Docky.Sdk.Sample.slnx

# ou construire le projet principal séparément (le projet de bibliothèque dépendant sera automatiquement construit)
dotnet build Ducky.EntranceMod/
```

**Produits de construction：**

- L’ensemble de mods principal + l’ensemble de la bibliothèque publique seront regroupés
- Le fichier de ressources est obtenu à partir du répertoire 'assets/' du projet principal
- Les bibliothèques SDK ne sont pas incluses de manière répétée (car la fonction '<ExcludeSdkLib>vrai</ExcludeSdkLib>\\`）

## 8. Activer les mods

Une fois construits, les mods sont automatiquement déployés dans le catalogue de jeux：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── assets/
    ├── info.ini
    ├── lkeys.json
    └── Locales/</游戏目录>
```

Activez le mod dans l’interface de gestion des mods du jeu.

## 9. Suggestions d’extension

### Créer plus de bibliothèques publiques

Pour les projets complexes, plusieurs bibliothèques publiques peuvent être créées：

```
Ducky.EntranceMod/ # Mod Maître
Ducky.EntranceMod.Common/ # Code universel
Ducky.EntranceMod.Gameplay/ # Logique de jeu
Ducky.EntranceMod.UI/ # Lié à l’interface utilisateur
```

## 10. Foire aux questions

### Q： Pourquoi définir '<ExcludeSdkLib>vrai</ExcludeSdkLib>\\`？

Un： Évitez l’empaquetage en double des fichiers de bibliothèque de Ducky.Sdk dans le répertoire de sortie du mod.La bibliothèque SDK existe déjà dans le jeu et n’a pas besoin d’être incluse à nouveau.

### Q: \\`<AssetsDir>Est-il nécessaire de le régler ?

Un： Pour les projets de bibliothèque publique, si une clé de localisation (LK.cs) est incluse, la fonction '<AssetsDir>' au répertoire assets du projet principal afin que le SDK puisse générer correctement des métadonnées localisées.

### Q： Plusieurs projets de mods principaux peuvent-ils partager la même bibliothèque publique ?

Un： D’ACCORD!C’est l’avantage des architectures multi-niveaux.Plusieurs mods peuvent faire référence au même projet de bibliothèque publique.

### Q： Où la clé de localisation de la bibliothèque publique sera-t-elle générée ?

Un： produira '<AssetsDir>' dans le répertoire spécifié, c’est-à-dire le fichier 'lkeys.json' sous le répertoire 'assets/' du projet maître.

## 11. Ressources connexes

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - Une référence de modèle pour un seul projet
- [Ducky.Localisation] (.. /Ducky.Localization/README.md) - Explication détaillée du système de localisation
- [Document de préparation environnementale] (../docs/Prequirement.md)

## 12. Résumé

Le modèle d’architecture multicouche convient：

- ✅ Grands projets de mods
- ✅ Scénarios nécessitant une réutilisation du code
- ✅ Développement collaboratif en équipe
- ✅ Développement de mods de série

Si votre mod est relativement simple, nous vous recommandons d’utiliser [Ducky.SingleProject](.. /Ducky.SingleProject/README.md) en mode projet unique.
