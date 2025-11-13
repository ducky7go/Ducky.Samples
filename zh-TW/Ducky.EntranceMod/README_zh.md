<!-- LANG_HEADER_START -->

\| [簡體中文](README.md) | [English](../en/Ducky.EntranceMod/README_en.md) | [Deutsch](../de/Ducky.EntranceMod/README_de.md) | [Français](../fr/Ducky.EntranceMod/README_fr.md) | [Español](../es-ES/Ducky.EntranceMod/README_es.md) | [日本語](../ja/Ducky.EntranceMod/README_ja.md) | [한국어](../ko/Ducky.EntranceMod/README_ko.md) | [Português](../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский](../ru/Ducky.EntranceMod/README_ru.md) | [繁體中文](../zh-TW/Ducky.EntranceMod/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod 示例 Mod

簡要說明

本示例展示如何使用多層架構模式開發Mod，將共用代碼分離到獨立的庫專案中，實現代碼複用和模組化設計。適合大型Mod或需要在多個Mod之間共用代碼的場景。

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

## 1. 項目簡介

本示例由兩個項目組成：

- **主 Mod 專案** ['Ducky.EntranceMod/']（Ducky.EntranceMod/） - Mod 入口，包含資源檔
- **公共庫專案** ['Ducky.EntranceMod.Common/']（Ducky.EntranceMod.Common/） - 共用代碼庫

這種架構模式適用於：

- 大型Mod需要分層管理
- 多個Mod共用通用邏輯
- 團隊協作開發
- 需要獨立測試業務邏輯

## 2. 項目結構

```
Ducky.EntranceMod/ # 主 Mod 專案
├── Ducky.EntranceMod.csproj # 專案配置
├── ModBehaviour.cs # Mod 入口類
├── README.md
└── assets/ # 資源文件目錄
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Locales/
        ├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/ # 公共庫專案
├── Ducky.EntranceMod.Common.csproj # 庫專案配置
├── LK.cs # 共用本地化鍵
└── MyModBase.cs # 共用基類
```

## 3. 主 Mod 專案配置

[`Ducky.EntranceMod/Ducky.EntranceMod.csproj`](Ducky.EntranceMod/Ducky.EntranceMod.csproj:1） 的關鍵配置：

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

**核心配置說明：**

- \`<ExcludeSdkLib>true</ExcludeSdkLib>' - 避免將 SDK 庫重複打包到輸出目錄

## 4. 公共庫專案配置

[`Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj`](Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1） 的關鍵配置：

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

**核心配置說明：**

- \`<IsModLib>true</IsModLib>' - 標記此專案為Mod庫，SDK 會特殊處理
- \`<AssetsDir>' - 指向主專案的 assets 目錄，使當地語系化鍵能正確生成

## 5. 共用代碼示例

### 共用當地語系化鍵

[`Ducky.EntranceMod.Common/LK.cs`](Ducky.EntranceMod.Common/LK.cs:1):

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

### 共用基類

[`Ducky.EntranceMod.Common/MyModBase.cs`](Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
using Ducky.Sdk.ModBehaviours;

namespace Ducky.EntranceMod.Common;

public abstract class MyModBase : ModBehaviourBase
{
    可以在這裡添加所有Mod共用的通用方法
    protected virtual void LogModInfo(string message)
    {
        Log.Info($"[{GetType(). Name}] {message}");
    }
}
```

### 主Mod使用共享代碼

[`Ducky.EntranceMod/ModBehaviour.cs`](Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
using Ducky.Sdk.Logging;
using Ducky.EntranceMod.Common;

namespace Ducky.EntranceMod;

繼承共用基類
public class ModBehaviour : MyModBase
{
    protected override void ModEnabled()
    {
        Log.Info("Mod Enabled");
        使用共用的當地語系化鍵
        var message = LK. UI. NiceWelcomeMessage;
        LogModInfo($"Welcome message key: {message}");
    }

    protected override void ModDisabled()
    {
        Log.Info("Mod Disabled");
    }
}
```

## 6. 多層架構的優勢

### ✅ 代碼複用

- 多個Mod可以共用 'Ducky.EntranceMod.Common' 庫
- 避免代碼重複，提高維護性

### ✅ 模組化設計

- 業務邏輯與Mod入口分離
- 易於單元測試
- 清晰的依賴關係

### ✅ 團隊協作

- 不同開發者可以獨立開發不同層
- 減少代碼衝突
- 便於代碼審查

### ✅ 當地語系化共用

- 公共庫可以定義共用的當地語系化鍵
- 所有使用該庫的Mod自動獲得翻譯支援

## 7. 構建流程

SDK 會自動處理多項目依賴：

```bash
# 構建整個解決方案（推薦）
dotnet build Docky.Sdk.Sample.slnx

# 或單獨建構主專案（會自動建構相依的函式庫專案 ）
dotnet build Ducky.EntranceMod/
```

**構建產物：**

- 主Mod程式集 + 公共庫程式集會一起打包
- 資源文件從主專案的 'assets/' 目錄獲取
- SDK 庫不會重複包含（因為設定了 '<ExcludeSdkLib>true</ExcludeSdkLib>\`）

## 8. 啟用 Mod

構建成功后，Mod 會自動部署到遊戲目錄：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── assets/
    ├── info.ini
    ├── lkeys.json
    └── Locales/</游戏目录>
```

在遊戲的Mod管理介面啟用該Mod即可。

## 9. 擴展建議

### 創建更多公共庫

對於複雜專案，可以創建多個公共庫：

```
Ducky.EntranceMod/ # 主 Mod
Ducky.EntranceMod.Common/ # 通用代碼
Ducky.EntranceMod.Gameplay/ # 遊戲玩法邏輯
Ducky.EntranceMod.UI/ # UI 相關
```

## 10. 常見問題

### Q： 為什麼要設定 '<ExcludeSdkLib>true</ExcludeSdkLib>\`？

A： 避免將 Ducky.Sdk 的庫檔重複打包到 Mod 輸出目錄。SDK 庫已經存在於遊戲中，不需要再次包含。

### Q: \`<AssetsDir>' 必須設定嗎？

A： 對於公共庫專案，如果包含本地化鍵（LK.cs），則必須設置 '<AssetsDir>' 指向主專案的 assets 目錄，這樣 SDK 才能正確生成當地語系化元數據。

### Q： 可以有多個主 Mod 專案共用同一個公共庫嗎？

A： 可以！這正是多層架構的優勢。多個Mod可以引用同一個公共庫專案。

### Q： 公共庫的當地語系化鍵會生成到哪裡？

A： 會產生到 '<AssetsDir>' 指定的目錄，即主專案的 'assets/' 目錄下的 'lkeys.json' 檔案中。

## 11. 相關資源

- [Ducky.SingleProject](../Ducky.SingleProject/README.md） - 單專案模式參考
- [Ducky.Localization](../Ducky.Localization/README.md） - 當地語系化系統詳解
- [環境準備文檔](../docs/Prequirement.md)

## 12. 總結

多層架構模式適合：

- ✅ 大型Mod專案
- ✅ 需要代碼複用的場景
- ✅ 團隊協作開發
- ✅ 系列Mod開發

如果你的 Mod 相對簡單，建議先使用 [Ducky.SingleProject]（../Ducky.SingleProject/README.md） 單專案模式。
