<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (../../Ducky.PackageFromNuget/README.md) | [English] (../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch] (../../de/Ducky.PackageFromNuget/README_de.md) | [Français] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japanese] (../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Traditional Chinese] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget sample mod

Briefly explained

This example shows how to use third-party NuGet packages in Mod (using YamlDotNet as an example), including dependency management, resource file access, and dependency packaging deployment.

Before you begin, make sure that the front-end environment requirements are ready： [Environmental Preparation](.. /docs/Prequirement.md)

## 1. Project Introduction

This directory (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) demonstrates how to extend the functionality of mods：

- ✅ Introducing third-party NuGet packages
- ✅ Parsing Data Using External Libraries (YAML)
- ✅ Access the mod resource file
- ✅ Automatically handle dependency packaging

**Sample scenarios：** Use the YamlDotNet library to read and resolve YAML profiles in the Mod resource folder.

## 2. Project structure

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Project configuration
├── ModBehaviour.cs # Mod entrance
├── README.md
└── assets/
    ├── info.ini # Mod meta information
    ├── preview.png # Preview image
    └── nice.yml # Sample YAML file
```

## 3. Project configuration

[`Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj`] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

**Key Points：**

- The SDK uses 'PrivateAssets' to avoid packaging to the output
- The third-party library (YamlDotNet) will be automatically packaged into the Mod output directory

## 4. Add the NuGet package

### Method 1：Using CLI (recommended)

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### Method 2：Manually edit .csproj

In '<ItemGroup>' added：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Method 3：Use Visual Studio

1. Right-click on the project → Manage NuGet packages
2. Search for "YamlDotNet"
3. Click "Install"

## 5) Implementation examples

### resource file

[`assets/nice.yml`] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  title: "Nice YAML Configuration"
  description: "This is a demonstration of loading YAML from a mod's assets folder"
```

### Mod entry class

[`Ducky.PackageFromNuget/ModBehaviour.cs`] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
using Ducky.Sdk.Logging;
using Ducky.Sdk.ModBehaviours;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Ducky.PackageFromNuget;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Get the directory where the mod assembly is located
        var dir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
        var ymlPath = Path.Combine(dir, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Found nice.yml:");
            
            Use YamlDotNet to deserialize YAML files
            var deserializer = new DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . Build();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = deserializer. Deserialize<NiceData>(ymlContent);
            
            Log.Info($"Title: {niceData.NiceHeader.Title}");
            Log.Info($"Description: {niceData.NiceHeader.Description}");
        }
        else
        {
            Log.Warn("nice.yml not found!");
        }
    }

    protected override void ModDisabled()
    {
        Clean up resources (if needed)
    }
}

Data model class
public class NiceData
{
    public NiceDateHeader NiceHeader { get; set; } = new();

    public class NiceDateHeader
    {
        public string Title { get; set; } = string. Empty;
        public string Description { get; set; } = string. Empty;
    }
}
```

## 6. Resource Archive Access

### Get the mod catalog

```csharp
Method 1：Pass the assembly location (recommended)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
```

### Access the resource file

```csharp
assets/ directory will be copied to the root directory of the mod output directory
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK automatic processing：**

- ✅ Copy the DLL of a third-party NuGet package
- ✅ Copy the resource file to the output directory
- ✅ Deploy to the Game Mods directory

## 7. Enable mods

Once the build is successful, enable the mod in the game's mod management interface：

1. Launch the game
2. Enter the mod management interface
3. Find "Ducky.PackageFromNuget"
4. Click Enable
5. Looking at the game logs, you should be able to see the parsed YAML contents

## 8) Best practices

### ✅ Choose the right library

- Prefer libraries that are compatible with .NET Standard 2.0/2.1
- Avoid using platform-specific libraries
- Check if the library's dependency tree is complex

### ✅ Manage dependent versions

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Relevant examples

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - The underlying project structure
- [Ducky.EntranceMod] (.. /Ducky.EntranceMod/README.md) - Multi-tier architecture (if you need to share third-party libraries)
- [Environmental Preparation Document] (../docs/Prequirement.md)

## 10. Summary

Using a third-party NuGet package can：

- ✅ Quickly expand mod functions
- ✅ Avoid reinventing the wheel
- ✅ Use a mature and stable solution
- ✅ Leverage community resources

**Notes：**

- ⚠️ Ensure that the library is compatible with .NET Standard 2.1
- ⚠️ Be aware of dependency size and performance impact
- ⚠️ Handle version conflicts well
- ⚠️ Comply with licenses from third-party libraries
