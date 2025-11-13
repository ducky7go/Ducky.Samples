<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (../../Ducky.SingleProject/README.md) | [English] (../../en/Ducky.SingleProject/README_en.md) | [Deutsch] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japanese] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Traditional Chinese] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject sample mod

Briefly explained

This example shows how to create a single-project mod using Ducky.Sdk, including project initialization, SDK introduction, mod lifecycle, and packaging process.

Before you begin, make sure that the pre-environment requirements are ready： [Environmental Preparation](.. /docs/Prequirement.md)

1. Project Introduction

This catalog ('Ducky. SingleProject/') demonstrates the SingleProject Mod mode：All code and resources are placed in the same project, and the entry class inherits 'ModBehaviourBase', which can be implemented in ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1).

2. Initialize the project

- Start with a template or warehouse：Clone the sample repository and open "Ducky.SingleProject/".
- Required item settings (recommended to be guaranteed in '.csproj')：

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

example：Make sure that the ModName is consistent with the assembly/project name.

1. Install and configure Ducky.Sdk

Installing Ducky.Sdk via NuGet is recommended.You can use the CLI to quickly add (example - replace with the desired version)：

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

- The entry class needs to inherit 'ModBehaviourBase' and implement the lifecycle methods 'ModEnabled()' and 'ModDisabled()'.

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
# Build the entire solution (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Build only a single sample project
dotnet build Ducky.SingleProject/
```

6. Open Mod (Run Game)

Build will automatically deploy mods to the game catalog, and launch the game to enable the mod in the mod management interface or in-game.After activation, you can see the mod's activation information in the game log.
