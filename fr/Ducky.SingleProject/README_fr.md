<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.SingleProject/README.md) | [English](../../en/Ducky.SingleProject/README_en.md) | [Deutsch](../../de/Ducky.SingleProject/README_de.md) | [Français](README_fr.md) | [Español](../../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../../ja/Ducky.SingleProject/README_ja.md) | [한국어](../../ko/Ducky.SingleProject/README_ko.md) | [Português](../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../../ru/Ducky.SingleProject/README_ru.md) | [繁體中文](../../zh-TW/Ducky.SingleProject/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Mod d’exemple Ducky.SingleProject

Brève description

Cet exemple montre comment utiliser Ducky.Sdk pour créer un mod de projet unique, y compris l’initialisation du projet, l’introduction du SDK, le cycle de vie du mod et le processus d’empaquetage.

Avant de commencer, assurez-vous que les exigences préalables à l’environnement sont prêtes : [Préparation de l’environnement](../docs/Prequirement.md)

1. Présentation du projet

Ce répertoire ('Ducky.SingleProject/') illustre le mode Mod de SingleProject：Tout le code et les ressources sont placés dans le même projet, et la classe entry hérite de la 'ModBehaviourBase', voir ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Initialiser le projet

- Commencer avec un modèle ou un référentiel：Clonez le référentiel d’exemples et ouvrez 'Ducky.SingleProject/'.
- Configuration nécessaire du projet (il est recommandé de garantir dans '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C :\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

exemple：Assurez-vous que le ModName correspond au nom de l’assembly/du projet.

1. Installer et configurer Ducky.Sdk

Il est recommandé d’installer Ducky.Sdk via NuGet.Vous pouvez utiliser l’interface de ligne de commande pour ajouter rapidement (exemple - veuillez remplacer par la version souhaitée)：

```bash
dotnet ajouter le paquet Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>tout</PrivateAssets>
    <IncludeAssets>Duree; construire; indigène; contentfiles ; Analyseurs; construiretransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Écrire le premier ModBehaviour

- La classe ingress hérite de la ModBehaviourBase et implémente les méthodes de cycle de vie ModEnabled() et ModDisabled().

Exemple de code：

```csharp
en utilisant Ducky.Sdk ;
à l’aide de Ducky.Sdk.Logging ;

espace de noms Ducky.SingleProject ;

classe publique ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Enregistrement des informations lors de l’initialisation
        Log.Info(« Ducky.SingleProject Mod Enabled ») ;
    }

    protected override void ModDisabled()
    {
        Log.Info(« Mod Ducky.SingleProject désactivé ») ;
    }
}
```

5. Exécuter et empaqueter

Commandes de compilation courantes：

```bash
# Construire l’ensemble de la solution (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Générer un seul exemple de projet
dotnet build Ducky.SingleProject/
```

6. Activer le mod (exécuter le jeu)

Build déploie automatiquement les mods dans le catalogue de jeux et lance le jeu pour activer le mod dans l’interface de gestion des mods ou dans le jeu.Une fois activé, vous pouvez voir les informations d’activation du mod dans le journal du jeu.
