<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.SingleProject/README.md) | [Traduction] (../../en/Ducky.SingleProject/README_en.md) | [Deutsch] (../../de/Ducky.SingleProject/README_de.md) | [English] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japonais] (README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Chinois traditionnel] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

簡単な説明

Cet exemple montre comment utiliser Ducky.Sdk pour créer des mods pour un seul projet, y compris l’initialisation du projet, le déploiement du SDK, le cycle de vie du mod et le processus d’empaquetage.

Avant de commencer, assurez-vous d’avoir préparé les exigences préalables à l’environnement : Préparez l’environnement (../docs/Prequirement.md)

1. プロジェクト紹介

Ce répertoire ('Ducky.SingleProject/') montre le mode Mod de SingleProject：Tout le code et les ressources sont placés dans le même projet, et la classe d’entrée hérite de 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. プロジェクトを初期化する

- Commencer avec un modèle ou un référentiel：Clonez le référentiel d’exemples et ouvrez « Ducky.SingleProject/ ».
- Configuration de projet requise (nous vous recommandons de vous assurer avec '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C :\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

exemple：Assurez-vous que le ModName correspond au nom de l’assembly/du projet.

1. Ducky.Sdk をインストールして構成する

Nous vous recommandons d’installer Ducky.Sdk via NuGet.Vous pouvez utiliser l’interface de ligne de commande pour l’ajouter rapidement (par exemple, le remplacer par la version souhaitée)：

```bash
dotnet ajouter le paquet Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>実行中; 建てる; ネイティブ; contentファイル; アナライザー; ビルド推移的</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Créez votre premier ModBehaviour

- イングレスクラスは ModBehaviourBase を継承し、ライフサイクルメソッド ModEnabled() と ModDisabled() を実装します。

サンプルコード：

```csharp
Ducky.Sdk.
Utilisez ducky.Sdk.Logging.

espace de noms Ducky.SingleProject ;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Enregistrement des informations au moment de l’initialisation
        Log.Info(« Ducky.SingleProject Mod Enabled ») ;
    }

    protected override void ModDisabled()
    {
        Log.Info(« Mod Ducky.SingleProject désactivé ») ;
    }
}
```

5. 実行とパッケージ化

一般的なビルドコマンド：

```bash
# Construire l’ensemble de la solution (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet build Ducky.SingleProject/
```

6. Modを有効にする(ゲームを実行する)

La version déploie automatiquement le mod dans le catalogue de jeux, lance le jeu et active le mod dans l’interface de gestion des mods ou dans le jeu.Une fois activé, vous pouvez vérifier les informations d’activation du mod dans le journal du jeu.
