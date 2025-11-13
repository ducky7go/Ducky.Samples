<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.TryHarmony/README.md) | [English](README_en.md) | [Deutsch](../../de/Ducky.TryHarmony/README_de.md) | [Français](../../fr/Ducky.TryHarmony/README_fr.md) | [Español](../../es-ES/Ducky.TryHarmony/README_es.md) | [日本語](../../ja/Ducky.TryHarmony/README_ja.md) | [한국어](../../ko/Ducky.TryHarmony/README_ko.md) | [Português](../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский](../../ru/Ducky.TryHarmony/README_ru.md) | [繁體中文](../../zh-TW/Ducky.TryHarmony/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.TryHarmony sample mod

Brief description

This example demonstrates a mod that uses HarmonyLib to patch game code at runtime.The example contains a simple Harmony patch (save patch) that has the effect of making the save operation fail consistently (SaveFilePatch).Entry and patch registration at ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1) is realized.

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

1. Project Introduction

This directory ('Ducky.TryHarmony/') demonstrates the Harmony patch mode：Register the patch by calling Harmony's PatchAll in ModEnabled, and cancel the patch in ModDisabled.See you in key realizations：

- [`Ducky.TryHarmony/ModBehaviour.cs`] (Ducky.TryHarmony/ModBehaviour.cs:1)
- [`Ducky.TryHarmony/SaveFilePatch.cs`] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Project documents：[`Ducky.TryHarmony/Ducky.TryHarmony.csproj`] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

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

The main function of 'SaveFilePatch' is to make the save operation fail consistently, making it easier to demonstrate the patch effect and error handling process.This patch example intercepts the saving related method and returns a failure (see ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. Operation and testing

- Build the project：

```bash
dotnet build Ducky.TryHarmony/
```

- Enable Mods (deploy builds to the game's mod catalog and enable them in-game)
- Attempting to save a save in-game results in a "save failed", indicating that the patch is in effect.

5. Common considerations

- Confirm that 'IncludeHarmony' is set to 'true', otherwise the Harmony-related code will not work.
- When debugging a patch, you can add a log (using Ducky.Sdk.Logging.Log) to 'ModBehaviour' to verify that 'PatchAll()'/'UnpatchAll()' is called.
