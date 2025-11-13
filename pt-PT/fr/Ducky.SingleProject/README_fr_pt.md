<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.SingleProject/README.md) | [Português] (../../en/Ducky.SingleProject/README_en.md) | [Alemão] (../../de/Ducky.SingleProject/README_de.md) | [Français] (README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japonês] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Chinês tradicional] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod d'exemple Ducky.SingleProject

Descrição de Brève

Cet exemple montre comment utiliser Ducky.Sdk pour créer un mod de projet unique, y compris l'initialisation du projet, l'introduction du SDK, le cycle de vie du mod et le processus d'empaquetage.

Avant de commencer, assurez-vous que les exigences préalables à l'environnement sont prêtes : [Préparation de l'environnement](../docs/Prequirement.md)

1. Présentation du projet

Ce répertoire ('Ducky.SingleProject/') ilustra le mode Mod de SingleProject：Tout le code et les ressources sont placés dans le même projet, et la classe entry hérite de la 'ModBehaviourBase', voir ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Inicializador do projeto

- Commencer avec un modèle ou un référentiel：Clonez le référentiel d'exemples et ouvrez 'Ducky.SingleProject/'.
- Configuration nécessaire du projet (il est recommandé de garantir dans '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>Vrai</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C :\Arquivos de Programas (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

exemplificativo：Assurez-vous que le ModName correspond au nom de l'assembly/du projet.

1. Installer et configurer Ducky.Sdk

Il est recommandé d'installer Ducky.Sdk via NuGet.Vous pouvez utiliser l'interface de ligne de commande pour ajouter rapidement (exemple - veuillez remplacer par la version souhaitée)：

```bash
dotnet ajouter le paquet Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>tout</PrivateAssets>
    <IncludeAssets>Duree; construire; Indigène; arquivos de conteúdo ; Analisadores; construiretransitivo</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Écrire le premier ModBehaviour

- La classe ingress hérite de la ModBehaviourBase et implémente les méthodes de cycle de vie ModEnabled() et ModDisabled().

Exemple de code：

```csharp
en utilisant Ducky.Sdk ;
à l'aide de Ducky.Sdk.Logging ;

espace de noms Ducky.SingleProject ;

classe publique ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Enregistrement des informations lors de l'initialisation
        Log.Info(« Ducky.SingleProject Mod Enabled ») ;
    }

    protegido substituir void ModDisabled()
    {
        Log.Info(« Mod Ducky.SingleProject désactivé ») ;
    }
}
```

5. Exécuter et empaqueter

Commandes de compilation courantes：

```bash
# Construire l'ensemble de la solution (.slnx)
dotnet construir Docky.Sdk.Sample.slnx

# Générer un seul exemple de projet
dotnet construir Ducky.SingleProject/
```

6. Activer le mod (exécuter le jeu)

Build déploie automatiquement les mods dans le catalogue de jeux et lance le jeu pour activer le mod dans l'interface de gestion des mods ou dans le jeu. Une fois activé, vous pouvez voir les informations d'activation du mod dans le journal du jeu.
