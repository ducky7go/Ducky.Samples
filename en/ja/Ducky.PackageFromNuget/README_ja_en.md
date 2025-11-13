<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (../../Ducky.PackageFromNuget/README.md) | [English] (../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch] (../../de/Ducky.PackageFromNuget/README_de.md) | [Français] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japanese] (README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Traditional Chinese] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル MOD

Short description

This example shows how to use third-party NuGet packages in mods, using YamlDotNet as an example, such as dependency management, resource file access, and dependency package deployment.

Before you begin, make sure that you have prepared your pre-production environment requirements: Prepare your environment (../docs/Prequirement.md)

## 1. Project introduction

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) shows how to extend the functionality of mods：

- ✅ Introducing third-party NuGet packages
- ✅ Parsing Data Using External Libraries (YAML)
- ✅ Mod リソース ファイルにアクセスする
- ✅ Automatically handle dependency packages

Example scenario：\*\* Use the YamlDotNet library to read and parse the YAML configuration file in the Mod Resources folder.

## 2. Project structure

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Project Configuration
├── ModBehaviour.cs #モードエントリークラス
├── README.md
└── アセット/
    ├── info.ini #モードメタ情報
    ├── preview.png #プレビュー画像
    └── nice.yml # サンプルYAMLファイル
```

## 3. Project Structure

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>running; Build; ネイティブ; contentファイル; アナライザー; Build Transitional</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

キーポイント：\*\*

- The SDK uses 'PrivateAssets' to avoid packaging into output
- Third-party libraries (YamlDotNet) are automatically packaged in the mod output directory

## 4. Add a NuGet package

### Method 1：Use the CLI (recommended)

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### Method 2：Manually edit the .csproj

で '<ItemGroup>' was added.：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Method 3：Use Visual Studio

1. Right-click on the project → manage NuGet packages
2. Search for "YamlDotNet"
3. 「インストール」をクリックします

## 5) Implementation examples

### リソースファイル

['asset/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  title: "Nice YAML Configuration"
  description: "これは、MOD の assets フォルダーから YAML をロードするデモンストレーションです"
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Use ducky.Sdk.Logging.
Ducky.Sdk.ModBehaviours.
YamlDotNet.Serialization.
Use YamlDotNet.Serialization.NamingConventions.

namespace Ducky.PackageFromNuget;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Get the directory where the mod assembly is located
        var dir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
        var ymlPath = Path.Combine(ディレクトリ, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Found nice.yml:");
            
            Use YamlDotNet to deserialize YAML files
            var deserializer = new DeserializerBuilder()
                . Naming conventions (Camel case naming conventions.
                . ビルド();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = デシリアライザー。 Deserialization<NiceData>(ymlコンテンツ);
            
            Log.Info($"タイトル: {niceData.NiceHeader.Title}");
            Log.Info($" Description: {niceData.NiceHeader.Description}");
        }
        If not
        {
            Log.Warn("nice.yml not found!");
        }
    }

    protected override void ModDisabled()
    {
        Clean up resources (if needed)
    }
}

データモデルクラス
public クラス NiceData
{
    public NiceDateHeader NiceHeader { get; セット; } = new();

    パブリック・クラス NiceDateHeader
    {
        public string Title { get; セット; } = string. Empty;
        public string explained { get; } セット; } = string. Empty;
    }
}
```

## 6. リソースファイルへのアクセス

### Get the mod catalog

```csharp
Method 1：By Assembly Location (Recommended)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
```

### リソースファイルにアクセスする

```csharp
The assets/ directory is copied to the root directory of the Mod output directory
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK Automatic：**

- ✅ サード パーティの NuGet パッケージの DLL をコピーする
- ✅ Copy the resource file to the output directory
- ✅ ゲーム mods ディレクトリにデプロイする

## 7. Enable mods

Once the build is successful, enable the mod in the game's mod management interface：

1. Launch the game
2. Go to the mod management interface
3. Search for "Ducky.PackageFromNuget".
4. Click Enable
5. If you check the game logs, you will see the contents of the parsed YAML

## 8) ベストプラクティス

### ✅ Choose the right library

- Prioritize libraries that are compatible with .NET Standard 2.0/2.1
- Avoid using platform-specific libraries
- Check if the library's dependency tree is complex

### ✅ Dependent version management

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. related case

- [ダッキー・シングルプロジェクト] (../Ducky.SingleProject/README.md) - basic project structure
- [ダッキー・エントランス・モッド] (.. /Ducky.EntranceMod/README.md - Multi-tiered architecture (if you need to share third-party libraries)
- Environment Readiness Documentation (../docs/Prequirement.md)

## 10. プロット

When using a third-party NuGet package,：

- ✅ Quickly expand mod functionality
- ✅ Avoid reinventing the wheel
- ✅ Use proven and stable solutions
- ✅ Leveraging Community Resources

**Note：**

- ⚠️ Make sure your library is compatible with .NET Standard 2.1
- ⚠️ Be aware of the size of dependencies and their impact on performance
- ⚠️ Handle version conflicts appropriately
- ⚠️ Comply with third-party library licenses
