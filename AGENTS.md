# Ducky SDK Sample Projects

## Project Overview
This is a sample repository demonstrating mod development for "Escape from Duckov" using the Ducky.Sdk framework（建议使用最新稳定版或通过集中管理的版本属性，不建议在文档中硬编码具体小版本号）。Contains three example patterns: single-project mods, multi-layer mods, and Harmony-based runtime patching.

## Architecture Patterns

### 1. Single-Project Mod (`Ducky.SingleProject/`)
Simplest pattern - all code and assets in one project.
- Entry point: `ModBehaviour : ModBehaviourBase`
- Set `<ModName>` in `.csproj` to define mod identity
- Assets in `assets/` folder (info.ini, localization CSVs, description.md)

### 2. Multi-Layer Mod (`Ducky.EntranceMod/` + `Ducky.EntranceMod.Common/`)
Separates shared code into reusable library layer.
- **Main project**: Set `<ExcludeSdkLib>true</ExcludeSdkLib>` to exclude SDK from output
- **Common library**: Set `<IsModLib>true</IsModLib>` and configure `<AssetsDir>` to point to main project's assets folder
- Use `<ProjectReference>` to link main mod to common library
- This pattern allows sharing localization keys (`LK.cs`) and base classes across mods

### 3. Harmony Patching Mod (`Ducky.TryHarmony/`)
Runtime game code modification using HarmonyLib.
- Enable with `<IncludeHarmony>true</IncludeHarmony>` in `.csproj`
- Initialize Harmony in `ModEnabled()`: `new HarmonyLib.Harmony(modName).PatchAll()`
- Access game APIs via `Contract.*`, `GameplayDataSettings.*`, `LevelManager`, `SceneLoader`
- Register custom game entities (buffs, etc.) using contract registration pattern
- Always unpatch in `ModDisabled()`: `_harmony.UnpatchAll()`

## Critical Conventions

### Project Configuration
All projects require:
```xml
<TargetFramework>netstandard2.1</TargetFramework>
<Nullable>enable</Nullable>
<LangVersion>preview</LangVersion>
<ImplicitUsings>true</ImplicitUsings>
```

### Ducky.Sdk Package Reference Pattern
不要在主文档中硬编码具体小版本号；推荐使用“最新稳定版”或通过集中管理的 MSBuild 属性来维护包版本，从而便于统一升级与回滚。下面给出两种示例用法（示例仅供参考）：

- 直接引用具体版本（示例，不建议在主分支中长期写死）：
```xml
<!-- 示例：直接引用具体版本（仅作示例） -->
<PackageReference Include="Ducky.Sdk" Version="x.y.z">
  <PrivateAssets>all</PrivateAssets>
  <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
</PackageReference>
```

- 推荐：通过 MSBuild 属性集中管理版本（可在 Directory.Build.props 或 Local.props 中设置）：
```xml
<!-- 在 Directory.Build.props 或 Local.props 中定义版本号 -->
<Project>
  <PropertyGroup>
    <DuckySdkVersion>0.1.4</DuckySdkVersion> <!-- 将此处替换为需要的版本号，或在 CI 中注入 -->
  </PropertyGroup>
</Project>

<!-- 在各 .csproj 中引用 -->
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="$(DuckySdkVersion)">
    <PrivateAssets>all</PrivateAssets>
    <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

简短说明：若确实需要为回归测试或发布固定某个版本，可在 CI 配置或特定维护分支中将版本写死；但在主文档与日常开发中应尽量使用集中管理或引用最新稳定版以便统一升级与修复。

### Local.props for Game Path
Create `Local.props` at solution root (gitignored) to configure game installation path:
```xml
<Project>
  <PropertyGroup>
    <DuckyGamePath>C:\Path\To\Game</DuckyGamePath>
  </PropertyGroup>
</Project>
```
This enables SDK build targets to deploy mods automatically to game folder.

## Localization System

### Localization Keys (`LK.cs`)
- Static class with nested categories (UI, Messages, etc.)
- String constants map to lowercase dot-separated keys: `"ducky.singleproject.ui.title"`
- Use `[LanguageSupport("zh", "en", "zh-hant")]` attribute to declare supported languages
- Use `[TranslateFile("md")]` attribute for file-based translations (creates `Locales/{lang}/filename.md`)

### Translation Files
- `assets/Locales/{lang}.csv` - CSV files with Key,Value columns
- `assets/Locales/{lang}/` - Folder for file-based translations (markdown, etc.)
- `assets/lkeys.json` - Auto-generated manifest (namespace, hash, keyCount, keys array)
- `assets/keys.hash.txt` - Build verification hash (4-byte hex)
- CSV format: `Key,Value` with keys from LK.cs, values are translations or file references

### Translation File References
For file-based translations, CSV value points to filename:
```csv
ducky.singleproject.ui.longdescription,"ducky.singleproject.ui.longdescription.md"
```

## Mod Lifecycle

### ModBehaviour Entry Point
Every mod must have a class inheriting `ModBehaviourBase`:
```csharp
public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled() { }   // Initialization, event subscriptions
    protected override void ModDisabled() { }  // Cleanup, event unsubscriptions
}
```

### Logging
Use `Ducky.Sdk.Logging.Log` for structured logging:
```csharp
Log.Info("Message with {Parameter}", value);
```
For advanced scenarios, can integrate Serilog for file-based logging (see `Ducky.TryHarmony`).

## Building & Testing

### Build Commands
```bash
dotnet build Docky.Sdk.Sample.slnx      # Build all projects
dotnet build Ducky.SingleProject/       # Build single project
```

### Asset Files Required
Each mod needs in `assets/` folder:
- `info.ini` - name, displayName, description
- `description.md` - Detailed mod description (optional)
- `lkeys.json` - Localization manifest (auto-generated by SDK)
- `keys.hash.txt` - Hash for verification (auto-generated)
- `Locales/{lang}.csv` - Translation files for each supported language

## Common Patterns

### Accessing Localized Strings
```csharp
using Ducky.Sdk.Localizations;
var message = L.UI.NiceWelcomeMessage;  // Resolves to translated string at runtime
```

### Registering Custom Buffs
```csharp
_buffId = Contract.Buffs.RegisterBuff<CustomBuff>(buff =>
{
    buff.SetDisplayName(LK.UI.BuffName)
        .SetDescription(LK.UI.BuffDesc)
        .SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
        .SetLimitedLifeTime(true)
        .SetTotalLifeTime(60);
});
```

### Scene Event Handling
```csharp
SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
// Always unsubscribe in ModDisabled()
```

## Notes
- Solution uses `.slnx` format (new XML-based solution file)
- All projects output to `bin/Debug/netstandard2.1/`
- SDK includes analyzers that validate project structure and generate localization artifacts
- The SDK build system handles mod packaging and deployment automatically when `Local.props` is configured
