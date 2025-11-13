<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (README.md) | [English] (../en/Ducky.BuffRegistration/README_en.md) | [Deutsch] (../de/Ducky.BuffRegistration/README_de.md) | [Français] (../fr/Ducky.BuffRegistration/README_fr.md) | [Español] (../es-ES/Ducky.BuffRegistration/README_es.md) | [Japanese] (../ja/Ducky.BuffRegistration/README_ja.md) | [한국어] (../ko/Ducky.BuffRegistration/README_ko.md) | [Português] (../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский] (../ru/Ducky.BuffRegistration/README_ru.md) | [Traditional Chinese] (../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.BuffRegistration sample mod

Brief description

This example shows how to use Ducky.Sdk to register a custom buff, including localized keys and asset layouts.Entry and implementation see ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

1. Project Introduction

This directory (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1Demonstrates the pattern of registering Buffs via Contract.Buffs in a single-project mod.This project also contains localization keys, see ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. Initialize the project

- Clone the repository and open 'Ducky.BuffRegistration/'.
- It is recommended to include at least .csproj：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.BuffRegistration</ModName>
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

4. Register a custom buff (example)

Use Contract.Buffs.RegisterBuff to register the Buff and set the display name, description, icon, and lifetime in the callback.example：

```csharp
using Ducky.Sdk;

public class ModBehaviour : ModBehaviourBase
{
    private int _buffId;

    protected override void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            buff. SetDisplayName(LK. UI. DoNothingBuffName)
                . SetDescription(LK. UI. DoNothingBuffDescription)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(true)
                . SetTotalLifeTime(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        Listen to the scene initialization：Automatically grants this buff to the protagonist when entering the base (see ModBehaviour for implementation)
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    protected override void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter;
            if (main != null)
            {
                Create and add a registered Buff instance when you enter the base scene
                main. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. localization

This example defines a string key at ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。The translation file is usually located at 'assets/locales/' (viewable in the source directory), but be careful：Translation CSVs, translation metadata ('assets/lkeys.json'), and validation files ('assets/keys.hash.txt') are automatically collected and written to the 'assets/' directory by the SDK's MSBuild analyzer/generator at compile time.Therefore, the recommended workflow is:：

- Define or modify keys in code (recommended)：Edit ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1) and compile, and the SDK generates/updates the corresponding translation metadata.
- Or edit 'assets/locales/ directly locally' locally{lang}.csv' and recompile to allow the SDK to integrate the changes.
- If you use file-based translation (e.g. writing long text to a Markdown file), you can use '[TranslateFile("md")]' in 'LK.cs'; The SDK will put the corresponding file into 'assets/locales/{lang}/' and reference it in CSV with the file name.

Example key：

- `LK. UI. DoNothingBuffName`
- `LK. UI. DoNothingBuffDescription`

remark：'assets/lkeys.json' and 'assets/keys.hash.txt' are used for runtime positioning and packaging verification, and manual modification is not recommended. To force a refresh, clean up and recompile the project.

6. Build and package

Common build commands：

```bash
dotnet build Ducky.BuffRegistration/
```

6. Enable Mod (Run the Game)

The build will automatically deploy the mod to the game catalog, enable the mod in the game's mod management interface, and launch the game to enter the base scene to see if the protagonist has received a custom buff.
