<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.SingleProject/README.md) | [Traduction] (../../en/Ducky.SingleProject/README_en.md) | [Deutsch] (../../de/Ducky.SingleProject/README_de.md) | [English] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japonais] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Chinois traditionnel] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod d’exemple Ducky.SingleProject

簡要說明

Cet exemple montre comment créer un mod de projet unique à l’aide de Ducky.Sdk, y compris l’initialisation du projet, l’introduction du SDK, le cycle de vie du mod et le processus d’empaquetage.

Avant de commencer, assurez-vous que les exigences de pré-environnement sont prêtes： [Préparation de l’environnement](.. /docs/Prequirement.md)

1. 項目簡介

Ce catalogue ('Ducky. SingleProject/') illustre le mode Mod SingleProject：Tout le code et les ressources sont placés dans le même projet, et la classe d’entrée hérite de 'ModBehaviourBase', qui peut être implémenté dans ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs :1).

2. 初始化專案

- Commencer avec un modèle ou un entrepôt：Clonez le référentiel d’exemples et ouvrez « Ducky.SingleProject/ ».
- Paramètres d’élément requis (il est recommandé de garantir dans '.csproj')：

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

exemple：Assurez-vous que le ModName est cohérent avec le nom de l’assembly/du projet.

1. 安裝並配置 Ducky.Sdk

Il est recommandé d’installer Ducky.Sdk via NuGet.Vous pouvez utiliser l’interface de ligne de commande pour ajouter rapidement (exemple - remplacer par la version souhaitée)：

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

- La classe entry doit hériter de 'ModBehaviourBase' et implémenter les méthodes de cycle de vie 'ModEnabled()' et 'ModDisabled()'.

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

常用構建命令：

```bash
# Construire l’ensemble de la solution (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Générer un seul exemple de projet
dotnet build Ducky.SingleProject/
```

6. 開啟 Mod（執行遊戲）

Build déploiera automatiquement les mods dans le catalogue de jeux et lancera le jeu pour activer le mod dans l’interface de gestion des mods ou dans le jeu.Après l’activation, vous pouvez voir les informations d’activation du mod dans le journal du jeu.
