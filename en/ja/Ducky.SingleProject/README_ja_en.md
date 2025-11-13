<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (../../Ducky.SingleProject/README.md) | [English] (../../en/Ducky.SingleProject/README_en.md) | [Deutsch] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japanese] (README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Traditional Chinese] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

Short description

This example shows how to use Ducky.Sdk to create mods for a single project, including project initialization, SDK deployment, mod lifecycle, and packaging process.

Before you begin, make sure you have prepared the pre-environment requirements: Prepare the environment (../docs/Prequirement.md)

1. Project Introduction

This directory ('Ducky.SingleProject/') shows the SingleProject Mod mode：All code and resources are placed in the same project, and the entry class inherits 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Initialize the project

- Start with a template or repository：Clone the sample repository and open "Ducky.SingleProject/".
- Required project configuration (we recommend ensuring with '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

example：Ensure that the ModName matches the assembly/project name.

1. Install and configure Ducky.Sdk

We recommend installing Ducky.Sdk via NuGet.You can use the CLI to add it quickly (e.g. - replace it with the version you want)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>running; Build; ネイティブ; contentファイル; アナライザー; Build Transitional</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Create your first ModBehaviour

- The ingress class inherits from ModBehaviourBase and implements the lifecycle methods ModEnabled() and ModDisabled().

サンプルコード：

```csharp
Ducky.Sdk.
Use ducky.Sdk.Logging.

namespace Ducky.SingleProject;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Record of information at the time of initialization
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    protected override void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Disabled");
    }
}
```

5. Execution and packaging

General build commands：

```bash
# Build the entire solution (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet build Ducky.SingleProject/
```

6. Enable mods (run the game)

The build automatically deploys the mod to the game catalog, launches the game, and enables the mod in the mod management interface or in-game.Once enabled, you can check the mod's activation information in the game log.
