<!-- LANG_HEADER_START -->

\| [簡體中文](../../Ducky.PackageFromNuget/README.md) | [English](../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch](../../de/Ducky.PackageFromNuget/README_de.md) | [Français](../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español](../../es-ES/Ducky.PackageFromNuget/README_es.md) | [日本語](../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português](../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский](../../ru/Ducky.PackageFromNuget/README_ru.md) | [繁體中文](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget 示例 Mod

簡要說明

本示例展示如何在Mod中使用第三方 NuGet 包（以 YamlDotNet 為例），包括依賴管理、資源文件訪問和依賴打包部署。

開始之前，請確保前置環境要求已準備： [環境準備]（.. /docs/Prequirement.md)

## 1. 項目簡介

本目錄（['Ducky.PackageFromNuget/']（Ducky.PackageFromNuget/））演示如何擴展 Mod 的功能：

- ✅ 引入第三方 NuGet 包
- ✅ 使用外部庫解析資料（YAML）
- ✅ 訪問Mod資源檔
- ✅ 自動處理依賴打包

**示例場景：** 使用 YamlDotNet 庫讀取並解析 Mod 資源資料夾中的 YAML 設定檔。

## 2. 項目結構

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # 專案配置
├── ModBehaviour.cs # Mod 入口類
├── README.md
└── assets/
    ├── info.ini # Mod 元資訊
    ├── preview.png # 預覽圖
    └── nice.yml # 示例 YAML 檔
```

## 3. 專案配置

[`Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj`](Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

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

**關鍵點：**

- SDK 使用 'PrivateAssets' 避免打包到輸出
- 第三方庫（YamlDotNet）會自動打包到Mod輸出目錄

## 4. 添加 NuGet 包

### 方法一：使用 CLI（推薦）

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### 方法二：手動編輯 .csproj

在 '<ItemGroup>' 中添加：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 方法三：使用 Visual Studio

1. 右鍵專案 → 管理 NuGet 程式包
2. 搜索 “YamlDotNet”
3. 點擊“安裝”

## 5） 實現範例

### 資源檔

[`assets/nice.yml`](Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  title: "Nice YAML Configuration"
  description: "This is a demonstration of loading YAML from a mod's assets folder"
```

### Mod 入口類

[`Ducky.PackageFromNuget/ModBehaviour.cs`](Ducky.PackageFromNuget/ModBehaviour.cs:1):

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
        獲取Mod程式集所在目錄
        var dir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
        var ymlPath = Path.Combine(dir, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Found nice.yml:");
            
            使用 YamlDotNet 反序列化 YAML 檔
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
        清理資源（如果需要）
    }
}

數據模型類
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

## 6. 資源檔案訪問

### 獲取 Mod 目錄

```csharp
方法一：通過程式集位置（推薦）
var modDir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
```

### 訪問資源檔

```csharp
assets/ 目錄下的檔會被複製到 Mod 輸出目錄的根目錄
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK 自動處理：**

- ✅ 複製第三方 NuGet 包的 DLL
- ✅ 複製資源檔案到輸出目錄
- ✅ 部署到遊戲Mods目錄

## 7. 啟用 Mod

構建成功后，在遊戲的Mod管理介面啟用該Mod：

1. 啟動遊戲
2. 進入Mod管理介面
3. 找到 “Ducky.PackageFromNuget”
4. 點擊啟用
5. 查看遊戲日誌，應該能看到解析的 YAML 內容

## 8） 最佳實踐

### ✅ 選擇合適的庫

- 優先選擇 .NET Standard 2.0/2.1 相容的庫
- 避免使用平臺特定的庫
- 檢查庫的依賴樹是否複雜

### ✅ 管理依賴版本

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. 相關示例

- [Ducky.SingleProject](.. /Ducky.SingleProject/README.md） - 基礎項目結構
- [Ducky.EntranceMod](.. /Ducky.EntranceMod/README.md） - 多層架構（如需共用第三方庫）
- [環境準備文檔](../docs/Prequirement.md)

## 10. 總結

使用第三方 NuGet 包可以：

- ✅ 快速擴展Mod功能
- ✅ 避免重複造輪子
- ✅ 使用成熟穩定的解決方案
- ✅ 利用社區資源

**注意事項：**

- ⚠️ 確保庫與 .NET Standard 2.1 相容
- ⚠️ 注意依賴大小和性能影響
- ⚠️ 處理好版本衝突問題
- ⚠️ 遵守第三方庫的許可證
