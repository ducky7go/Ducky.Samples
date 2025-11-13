<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.PackageFromNuget/README.md) | [English](README_en.md) | [Deutsch](../../de/Ducky.PackageFromNuget/README_de.md) | [Français](../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español](../../es-ES/Ducky.PackageFromNuget/README_es.md) | [日本語](../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português](../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский](../../ru/Ducky.PackageFromNuget/README_ru.md) | [繁體中文](../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget sample mod

Brief description

This example shows how to use third-party NuGet packages in mods, using YamlDotNet as an example, including dependency management, resource file access, and dependency package deployment.

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

## 1. Project introduction

This directory (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) demonstrates how to extend the functionality of mods：

- ✅ Introducing third-party NuGet packages
- ✅ Parsing Data Using External Libraries (YAML)
- ✅ Access the Mod resource file
- ✅ Automatically handle dependency packaging

**Example scenario：** Use the YamlDotNet library to read and parse the YAML configuration file in the Mod Resources folder.

## 2. Project structure

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Project configuration
├── ModBehaviour.cs # Mod entry class
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
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>todo</PrivateAssets>
      <IncludeAssets>Ejecución; construir; nativo; archivos de contenido; Analizadores; buildtransitive</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

Key Points：\*\*

- The SDK uses 'PrivateAssets' to avoid packaging to output
- Third-party libraries (YamlDotNet) are automatically packaged into the mod output directory

## 4. Add the NuGet package

### Method 1：Use CLI (recommended)

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

1. Right-click on the project → manage NuGet packages
2. Search for "YamlDotNet"
3. Click "Install"

## 5) Implementation examples

### Resource file

[`assets/nice.yml`] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  title: "Buena configuración de YAML"
  description: "Esta es una demostración de la carga de YAML desde la carpeta de activos de un mod"
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
        Get the directory where the Mod Assembly is located
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

## 6. Resource file access

### Get the mod catalog

```csharp
Method 1：By assembly location (recommended)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
```

### Access the resource file

```csharp
assets/ directory will be copied to the root directory of the Mod output directory
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK automatically：**

- ✅ Copy the DLL of a third-party NuGet package
- ✅ Copy the resource file to the output directory
- ✅ Deploy to the game mods directory

## 7. Enable mods

Once the build is successful, enable the mod in the game's mod management interface：

1. Launch the game
2. Go to the Mod Management Interface
3. Find "Ducky.PackageFromNuget"
4. Click Enable
5. Check the game logs and you should see the parsed YAML contents

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

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Basic project structure
- [Ducky.EntranceMod] (../Ducky.EntranceMod/README.md- Multi-tier architecture (if you need to share third-party libraries)
- [Environment Preparation Documentation] (../docs/Prequirement.md)

## 10. Summary

Using a third-party NuGet package can：

- ✅ Quickly expand mod features
- ✅ Avoid reinventing the wheel
- ✅ Use a proven and stable solution
- ✅ Leverage community resources

**Notes：**

- ⚠️ Make sure the library is compatible with .NET Standard 2.1
- ⚠️ Be aware of dependency size and performance impact
- ⚠️ Handle version conflicts well
- ⚠️ Comply with the license of the third-party library
