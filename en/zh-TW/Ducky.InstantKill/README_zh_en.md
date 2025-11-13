<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (../../Ducky.InstantKill/README.md) | [English] (../../en/Ducky.InstantKill/README_en.md) | [Deutsch] (../../de/Ducky.InstantKill/README_de.md) | [Français] (../../fr/Ducky.InstantKill/README_fr.md) | [Español] (../../es-ES/Ducky.InstantKill/README_es.md) | [Japanese] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Português] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Traditional Chinese] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill sample mod

Briefly explained

This example implements a simple mod that kills the protagonist when he attacks an enemy.After activation, when an injury event occurs, if the source of damage is the protagonist, it will inflict high damage to the target and kill it instantly.For implementation, see ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Before you begin, make sure that the front-end environment requirements are ready： [Environmental Preparation](.. /docs/Prequirement.md)

1. Project Introduction

This directory ('Ducky. InstantKill/') demos the single-project Mod mode：All code and resources are placed in the same project, and the entry class inherits 'ModBehaviourBase', see ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Initialize the project

- Clone the warehouse and open 'Ducky.InstantKill/'.
- Recommended in ". CSPROJ：

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

Adding an SDK via NuGet is recommended：

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

The entry class needs to inherit 'ModBehaviourBase' and implement the lifecycle methods 'ModEnabled()' and 'ModDisabled()'.This example registers the processor on the "OnHurt" event, which deals large amount of damage to the target when the damage comes from the main character.

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

6. Open Mod (Run Game)

After the build automatically deploys the mod to the game directory, the mod is enabled in the game mod management interface, and the effect can be tested after the game enters the battlefield scene：When the protagonist attacks the enemy, the enemy should die instantly.
