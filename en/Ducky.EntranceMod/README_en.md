<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (README.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod sample mod

Brief description

This example shows how to develop mods using a multi-layer architecture pattern to separate shared code into separate library projects for code reuse and modular design.Suitable for large mods or scenarios where code needs to be shared between multiple mods.

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

## 1. Project introduction

This example consists of two items：

- **Main Mod Project** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Mod entrance containing resource files
- **Public Library Project** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Shared codebase

This architectural pattern applies：

- Large mods require hierarchical management
- Multiple mods share common logic
- Collaborative development as a team
- Business logic needs to be tested independently

## 2. Project structure

```
Ducky.EntranceMod/ # Main Mod Project
├── Ducky.EntranceMod.csproj # Project configuration
├── ModBehaviour.cs # Mod entry class
├── README.md
└── assets/ # Resource file directory
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Locales/
        ├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/ # Public Library Project
├── Ducky.EntranceMod.Common.csproj # Library Project Configuration
├── LK.cs # Share localization key
└── MyModBase.cs # Shared base class
```

## 3. Main Mod Project Configuration

[`Ducky.EntranceMod/Ducky.EntranceMod.csproj`] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1) key configuration：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>true</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**Core configuration description：**

- \`<ExcludeSdkLib>true</ExcludeSdkLib>- Avoid duplicate packaging of SDK libraries into the output directory

## 4. Public library project configuration

[`Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj`] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1) key configuration：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>true</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/assets</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**Core configuration description：**

- \`<IsModLib>true</IsModLib>' - Mark this item as a mod library, the SDK will handle it specially
- \`<AssetsDir>' - Points to the assets directory of the main project so that the localization key is generated correctly

## 5. Share code examples

### Share localization keys

[`Ducky.EntranceMod.Common/LK.cs`] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
namespace Ducky.EntranceMod.Common;

public static class LK
{
    public static class UI
    {
        public const string NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### Shared base classes

[`Ducky.EntranceMod.Common/MyModBase.cs`] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
using Ducky.Sdk.ModBehaviours;

namespace Ducky.EntranceMod.Common;

public abstract class MyModBase : ModBehaviourBase
{
    A universal method for all Mod sharing is reachable to add here
    protected virtual void LogModInfo(string message)
    {
        Log.Info($"[{GetType(). Name}] {message}");
    }
}
```

### The main mod uses a shared code

[`Ducky.EntranceMod/ModBehaviour.cs`] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
using Ducky.Sdk.Logging;
using Ducky.EntranceMod.Common;

namespace Ducky.EntranceMod;

Inheritance shared base class
public class ModBehaviour : MyModBase
{
    protected override void ModEnabled()
    {
        Log.Info("Mod Enabled");
        Use a shared localization key
        var message = LK. UI. NiceWelcomeMessage;
        LogModInfo($"Welcome message key: {message}");
    }

    protected override void ModDisabled()
    {
        Log.Info("Mod Disabled");
    }
}
```

## 6. Advantages of multi-layer architecture

### ✅ Code reuse

- Multiple Mods can share the 'Ducky.EntranceMod.Common' library
- Avoid code duplication and improve maintainability

### ✅ Modular design

- The business logic is decoupled from the mod ingress
- Easy to unit test
- Clear dependencies

### ✅ Team collaboration

- Different developers can develop different layers independently
- Reduce code conflicts
- Easy code review

### ✅ Localized sharing

- Public libraries can define shared localization keys
- All mods that use the library are automatically supported for translation

## 7. Build the process

The SDK automatically handles multi-project dependencies：

```bash
# Build the entire solution (recommended)
dotnet build Docky.Sdk.Sample.slnx

# or build the main project separately (which automatically builds the dependent library project)
dotnet build Ducky.EntranceMod/
```

Build products：\*\*

- The main mod assembly + public library assembly is packaged together
- The resource file is obtained from the 'assets/' directory of the main project
- SDK libraries are not included repeatedly (because '<ExcludeSdkLib>true</ExcludeSdkLib>\`）

## 8. Enable mods

Once built, mods are automatically deployed to the game catalog：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── assets/
    ├── info.ini
    ├── lkeys.json
    └── Locales/</游戏目录>
```

Enable the mod in the game's mod management interface.

## 9. Extension Recommendations

### Create more public libraries

For complex projects, you can create multiple public libraries：

```
Ducky.EntranceMod/ # Master Mod
Ducky.EntranceMod.Common/ # Universal Code
Ducky.EntranceMod.Gameplay/ # Gameplay logic
Ducky.EntranceMod.UI/ # UI related
```

## 10. FAQs

### Q: Why set '<ExcludeSdkLib>true</ExcludeSdkLib>\`？

A: Avoid duplicate packaging of Ducky.Sdk's library files into the mod output directory.The SDK library already exists in the game and does not need to be included again.

### Q: \`<AssetsDir>Do you have to set it?

A: For public library projects, if you include a localization key (LK.cs), you must set '<AssetsDir>Points to the assets directory of the main project so that the SDK can properly generate localized metadata.

### Q: Can multiple main mod projects share the same public library?

A: Yes!This is the advantage of multi-tiered architectures.Multiple mods can reference the same public library project.

### Q: Where will the localization key for public libraries be generated?

A: It will generate to '<AssetsDir>' specified directory, i.e. the 'lkeys.json' file under the 'assets/' directory of the main project.

## 11. Related Resources

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Single-item mode reference
- [Ducky.Localization] (../Ducky.Localization/README.md- Detailed explanation of the localization system
- [Environment Preparation Documentation] (../docs/Prequirement.md)

## 12. Summary

The multi-layer architecture pattern is suitable：

- ✅ Large mod projects
- ✅ Scenarios where code reuse is required
- ✅ Collaborative development as a team
- ✅ Series Mod Development

If your mod is relatively simple, it is recommended to start with [Ducky.SingleProject](../Ducky.SingleProject/README.md) single-project model.
