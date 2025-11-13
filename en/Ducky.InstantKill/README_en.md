<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.InstantKill/README.md) | [English](README_en.md) | [Deutsch](../../de/Ducky.InstantKill/README_de.md) | [Français](../../fr/Ducky.InstantKill/README_fr.md) | [Español](../../es-ES/Ducky.InstantKill/README_es.md) | [日本語](../../ja/Ducky.InstantKill/README_ja.md) | [한국어](../../ko/Ducky.InstantKill/README_ko.md) | [Português](../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](../../ru/Ducky.InstantKill/README_ru.md) | [繁體中文](../../zh-TW/Ducky.InstantKill/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.InstantKill sample mod

Brief description

This example implements a simple mod that kills the protagonist as soon as he attacks an enemy.When enabled, if the source of damage is the main character, it will inflict high damage to the target and kill it instantly.Implementation see ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

1. Project Introduction

This directory ('Ducky.InstantKill/') demonstrates the single-project mod mode：All code and resources are placed in the same project, and the entry class inherits 'ModBehaviourBase', as shown in ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Initialize the project

- Clone the repository and open 'Ducky.InstantKill/'.
- It is recommended to include at least in '.csproj'：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.InstantKill</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Install and configure Ducky.Sdk

We recommend adding an SDK via NuGet：

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

4. Write ModBehaviour

The ingress class inherits the ModBehaviourBase and implements the lifecycle methods ModEnabled() and ModDisabled().This example registers the processor on the 'OnHurt' event to inflict large damage on the target when the damage comes from the main character.

Sample code：

```csharp
using Ducky.Sdk;
using Ducky.Sdk.Logging;

namespace Ducky.InstantKill;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    protected override void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    private void Health_OnHurt(Health h, DamageInfo da)
    {
        if (da. To(h). IsFromMainToEnemy())
        {
            Log.Debug("Instant Kill Mod: Killing enemy.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000,
            });
        }
    }
}
```

5. Run and package

Common build commands：

```bash
# Build the entire solution
dotnet build Docky.Sdk.Sample.slnx

# Build this project only
dotnet build Ducky.InstantKill/
```

6. Enable Mod (Run the Game)

Build will automatically deploy the mod to the game catalog, enable it in the game's mod management interface, and test the effect once the game is launched and the battlefield is launched：When the protagonist attacks an enemy, the enemy should die instantly.
