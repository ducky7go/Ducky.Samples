<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (../../Ducky.TryHarmony/README.md) | [English] (../../en/Ducky.TryHarmony/README_en.md) | [Deutsch] (../../de/Ducky.TryHarmony/README_de.md) | [Français] (../../fr/Ducky.TryHarmony/README_fr.md) | [Español] (../../es-ES/Ducky.TryHarmony/README_es.md) | [Japanese] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Português] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Traditional Chinese] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony sample mod

Briefly explained

This example demonstrates using HarmonyLib to patch a mod for game code at runtime.The example contains a simple Harmony patch (save patch) with the effect of making the save operation consistently fail (SaveFilePatch).Entry and patch registration is implemented in ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1).

Before you begin, make sure that the front-end environment requirements are ready： [Environmental Preparation](.. /docs/Prequirement.md)

1. Project Introduction

This catalog ('Ducky. TryHarmony/') demonstrates the Harmony patch mode：Register the patch by calling Harmony's PatchAll in ModEnabled and cancel the patch in ModDisabled.See you in key realizations：

- [`Ducky.TryHarmony/ModBehaviour.cs`] (Ducky.TryHarmony/ModBehaviour.cs:1)
- [`Ducky.TryHarmony/SaveFilePatch.cs`] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Project file：[`Ducky.TryHarmony/Ducky.TryHarmony.csproj`] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Enable Harmony in csproj

To use the Harmony patch, enable the IncludeHarmony property in 'Ducky.TryHarmony.csproj'.For example：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>true</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. SaveFilePatch

The main function of 'SaveFilePatch' is to make save (save game) operations fail consistently, making it easier to demonstrate the patch effect and error handling process.The patch example intercepts the save-related method and returns a failure (see ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)).

4. Running and testing

- Build projects：

```bash
dotnet build Ducky.TryHarmony/
```

- Open mods (deploy builds to the game's mod catalog and open them in-game)
- Attempting to save a save in-game results in a "Save Failed" indicating that the patch is active.

5. Common precautions

- Confirm that 'IncludeHarmony' is set to 'true', otherwise the Harmony-related code will not work properly.
- When debugging patches, log can be added to 'ModBehaviour' (using 'Ducky.Sdk.Logging.Log') to verify that 'PatchAll()'/'UnpatchAll()' is called.
