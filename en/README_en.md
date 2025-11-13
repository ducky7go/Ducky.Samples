<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](en/README_en.md) | [Deutsch](de/README_de.md) | [Français](fr/README_fr.md) | [Español](es-ES/README_es.md) | [日本語](ja/README_ja.md) | [한국어](ko/README_ko.md) | [Português](pt-PT/README_pt.md) | [Русский](ru/README_ru.md) | [繁體中文](zh-TW/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky SDK sample project collection

[! [Build] (https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.NET] (https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [NuGet] (https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [License] (https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [Platform] (https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [Language] (https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! [Target] (https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [Issues] (https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [Pull Requests] (https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [Last Commit] (https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

This repository contains several sample projects to demonstrate the development of the "Escape from Duckov" mod, using [Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk) frame.

## 📋 Prepared

Before you begin, make sure your development environment is ready：

👉 [View environment preparation documentation](docs/Prequirement.md)\*\*

Main requirements:：

- .NET SDK 10.x
- Global tool：`dotnet-script`、`dotnet-ilrepack`
- Supported operating systems：Windows / Linux / macOS

## 🎯 Get started quickly

```bash
# Clone the repository
git clone <repository-url>
cd Samples

# Build all examples
dotnet build Docky.Sdk.Sample.slnx

# or build a single example
dotnet build Ducky.SingleProject/
```

## 📚 Sample project tour

This repository organizes the examples in order from easy to difficult, and it is recommended to study in the following order：

### 1️⃣ Entry-level - basic concepts

#### [Ducky.SingleProject] (Ducky.SingleProject/- The simplest mod

**difficulty：⭐**

The most basic single-item mod example, suitable for complete novices.

- ✅ Single-item structure
- ✅ Mod lifecycle ('ModEnabled' / 'ModDisabled')
- ✅ Basic logging
- ✅ Project configuration and construction

Key points to learn：\*\*

- How to create a minimum workable mod
- [`ModBehaviour`] (Ducky.SingleProject/ModBehaviour.cs) ingress class
- The basic configuration of the '.csproj' file

**Suitable for people：** Developers new to the Ducky SDK

👉 [View detailed tutorial](Ducky.SingleProject/README.md)

---

#### [Ducky.InstantKill] (Ducky.InstantKill/- Game event handling

**difficulty：⭐⭐**

Demonstrates how to subscribe to game events and implement simple game logic modifications.

- ✅ Game Event Subscription ('Health.OnHurt')
- ✅ Event handler implementation
- ✅ Resource management throughout the lifecycle

Key points to learn：\*\*

- How to listen for in-game events
- How to securely subscribe to and unsubscribe from events
- [`DamageInfo`] (Ducky.InstantKill/ModBehaviour.cs) and other game APIs

**Suitable for people：** Developers who understand the basic mod structure and want to implement game logic

👉 [View detailed tutorial](Ducky.InstantKill/README.md)

---

### 2️⃣ Advanced Level - Core Features

#### [Ducky.Localization] (Ducky.Localization/- Multilingual localization

**difficulty：⭐⭐⭐**

A complete example of a localization system with multilingual support and file-based translation.

- ✅ Localized key definition(['LK.cs'](Ducky.Localization/LK.cs)）
- ✅ CSV translation file
- ✅ Document Translation (Markdown)
- ✅ Multilingual support (Simplified Chinese and English)

Key points to learn：\*\*

- How to organize localization keys
- Use of the '[LanguageSupport]' and '[TranslateFile]' features
- SDK auto-generated 'lkeys.json' and 'keys.hash.txt'
- Runtime access to translation strings

**Suitable for people：** Developers who need to develop multilingual mods

👉 [View detailed tutorial](Ducky.Localization/README.md)

---

#### [Ducky.BuffRegistration] (Ducky.BuffRegistration/) - Custom game entities

\*\*difficulty：⭐⭐⭐

Demonstrates how to register custom Buffs and integrate them with your game system.

- ✅ Use 'Contract.Buffs.RegisterBuff' to register the buff
- ✅ Scene Event Handling ('SceneLoader.onAfterSceneInitialize')
- ✅ Buff instance creation and addition
- ✅ Localize the Buff name and description

Key points to learn：\*\*

- How to extend the core system of the game
- Usage patterns of the Contract API
- Scenario lifecycle management
- Configuration and registration of game entities

**Suitable for people：** Developers who want to add custom game content

👉 [View detailed tutorial](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/- Third-party dependency management

**difficulty：⭐⭐⭐**

Demonstrates how to use NuGet packages in mods (using YamlDotNet as an example).

- ✅ Introducing third-party NuGet packages
- ✅ Read and parse resource files
- ✅ Dependent packaging and deployment

Key points to learn：\*\*

- How to use external libraries in mods
- The access path of the resource file
- SDK's dependency handling mechanism

**Suitable for people：** Developers who need to extend functionality with third-party libraries

---

### 3️⃣ Advanced - Complex mode

#### [Ducky.EntranceMod] (Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/- Multi-tiered architecture

**difficulty：⭐⭐⭐⭐**

Demonstrates how to split mods into multi-layer architectures for code reuse.

- ✅ The main mod project is separated from the public library
- ✅ \`<ExcludeSdkLib>' and '<IsModLib>' configuration
- ✅ Share localization keys across projects
- ✅ Project reference management

Key points to learn：\*\*

- Organization of multi-project solutions
- How to create a reusable mod library
- Cross-project sharing of resource files
- Architecture design for large mods

**Suitable for people：** Teams developing large or series mods

---

#### [Ducky.TryHarmony] (Ducky.TryHarmony/- Runtime code injection

**difficulty：⭐⭐⭐⭐⭐**

Use HarmonyLib to patch game code at runtime for the deepest game modifications.

- ✅ Harmony patching system
- ✅ method prefix/suffix/replace
- ✅ Patch registration and cleanup
- ✅ In-game API access

Key points to learn：\*\*

- Basic use of HarmonyLib
- How to write Prefix/Postfix patches
- Best practices for runtime code modification
- Lifecycle management of patches

**example：** [`SaveFilePatch`](Ducky.TryHarmony/SaveFilePatch.csDemonstrates how to intercept archive operations

**Suitable for people：** Advanced developers who need to modify game logic deeply

⚠️ **Note.：** Harmony patches are powerful but should be used with caution, and incorrect patches can cause the game to crash

👉 [View detailed tutorial](Ducky.TryHarmony/README.md)

---

## 🏗️ Project Architecture

All sample projects follow the following core conventions：

### Project configuration (required)

```xml
<PropertyGroup>
  <TargetFramework>netstandard2.1</TargetFramework>
  <Nullable>enable</Nullable>
  <LangVersion>preview</LangVersion>
  <ImplicitUsings>true</ImplicitUsings>
  <ModName>YourModName</ModName>
</PropertyGroup>
```

### Mod entry point

```csharp
public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Initialization logic when the mod is enabled
    }

    protected override void ModDisabled()
    {
        Cleanup logic when mod is disabled
    }
}
```

### Resource file structure

```
assets/
├── info.ini # Mod meta information
├── description.md # Detailed Description (Optional)
├── preview.png # Preview (optional)
├── lkeys.json # Localization Checklist (Auto-generated)
├── keys.hash.txt # Validation Hash (Automatically Generated)
└── Locales/
    ├── zh.csv # Chinese Simplified translation
    ├── en.csv # English translation
    └── en/ # Document-based translation
        └── *.md
```

## 📖 Learning path recommendations

### Beginner path

1. [Ducky.SingleProject] (Ducky.SingleProject/- Understand the infrastructure
2. [Ducky.InstantKill] (Ducky.InstantKill/- Learn incident handling
3. [Ducky.Localization] (Ducky.Localization/- Master localization
4. [Ducky.BuffRegistration] (Ducky.BuffRegistration/) - Expands game content

### Advanced path

1. [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/) - Use third-party libraries
2. [Ducky.EntranceMod] (Ducky.EntranceMod/- Multi-layer architecture design
3. [Ducky.TryHarmony] (Ducky.TryHarmony/- Runtime code injection

## 🛠️ Build and deploy

### Build commands

```bash
# Build all projects
dotnet build Docky.Sdk.Sample.slnx

# Build a single project
dotnet build Ducky.SingleProject/

# Clean up the build
dotnet clean
```

### Automated deployment

The SDK automatically deploys mods to the game directory at build time (requires configuring 'local.props' or setting '.csproj')<SteamFolder>`/`<DuckovFolder>\`）：

```xml
<PropertyGroup>
  <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 Project specifications

- **Solution Format**：Use the new '.slnx' XML format
- **Code Analysis**：The SDK built-in analyzer validates the project structure
- **Automatic Generation**：Localized metadata is automatically generated at compile time

## 🔗 Related resources

- [Ducky.Sdk NuGet Package] (https://www.nuget.org/packages/Ducky.Sdk)
- [Game Steam page] (https://store.steampowered.com/app/XXXXX(replaced with actual link)
- [Developer Documentation] (docs/)

## 🤝 Contribution Guidelines

Feel free to submit Issues and Pull Requests to improve the sample project!

## 📄 Permit.

This project uses [LICENSE(LICENSE).

---

**Happy development!🎮**
