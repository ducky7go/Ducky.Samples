<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](../en/Ducky.SingleProject/README_en.md) | [Deutsch](../de/Ducky.SingleProject/README_de.md) | [Français](../fr/Ducky.SingleProject/README_fr.md) | [Español](../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../ja/Ducky.SingleProject/README_ja.md) | [한국어](../ko/Ducky.SingleProject/README_ko.md) | [Português](../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../ru/Ducky.SingleProject/README_ru.md) | [繁體中文](../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject sample mod

Brief description

This example shows how to use Ducky.Sdk to create a single-project mod, including project initialization, SDK introduction, mod lifecycle, and packaging process.

Before you begin, make sure that the pre-environment requirements are ready: [Environment Preparation](../docs/Prequirement.md)

1. Project Introduction

This directory ('Ducky.SingleProject/') demonstrates the SingleProject Mod mode：All code and resources are placed in the same project, and the entry class inherits the 'ModBehaviourBase', see ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Initialize the project

- Start with a template or repository：Clone the sample repository and open 'Ducky.SingleProject/'.
- Necessary project setup (recommended to be guaranteed in '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

example：Make sure the ModName matches the assembly/project name.

1. Install and configure Ducky.Sdk

Installing Ducky.Sdk via NuGet is recommended.You can use the CLI to add quickly (example - please replace with the desired version)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>all</PrivateAssets>
    <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Write the first ModBehaviour

- The ingress class inherits the ModBehaviourBase and implements the lifecycle methods ModEnabled() and ModDisabled().

Sample code：

```csharp
using Ducky.Sdk;
using Ducky.Sdk.Logging;

namespace Ducky.SingleProject;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Record information at initialization
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    protected override void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Disabled");
    }
}
```

5. Run and package

Common build commands：

```bash
# Build the whole solution (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Build only a single sample project
dotnet build Ducky.SingleProject/
```

6. Enable Mod (Run the Game)

Build automatically deploys mods to the game catalog, and launches the game to enable the mod in the mod management interface or in-game.Once enabled, you can see the mod's activation information in the game log.
