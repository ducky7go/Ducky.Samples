<!-- LANG_HEADER_START -->

\| [简体中文](../README.md) | [English](../en/README_en.md) | [Deutsch](../de/README_de.md) | [Français](../fr/README_fr.md) | [Español](../es-ES/README_es.md) | [日本語](../ja/README_ja.md) | [한국어](../ko/README_ko.md) | [Português](../pt-PT/README_pt.md) | [Русский](../ru/README_ru.md) | [繁體中文](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky SDK 示例專案集合

[! [Build](https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.NET](https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [NuGet](https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [License](https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [Language](https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! [Target](https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [Issues](https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [Pull Requests](https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [Last Commit](https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

本倉庫包含多個用於演示 「Escape from Duckov」 Mod 開發的範例專案，使用 [Ducky.Sdk]（https://www.nuget.org/packages/Ducky.Sdk） 框架。

## 📋 前置準備

開始之前，請確保您的開發環境已準備就緒：

👉 **[查看環境準備文檔]（docs/Prequirement.md)**

Requisitos principales:：

- SDK de .NET 10.x
- 全域工具：`dotnet-script`、`dotnet-ilrepack`
- 支援的作業系統：Windows / Linux / macOS

## 🎯 快速開始

```bash
# 克隆倉庫
git clone <repository-url>
cd Samples

# 構建所有範例
dotnet build Docky.Sdk.Sample.slnx

# 或構建單個範例
dotnet build Ducky.SingleProject/
```

## 📚 範例項目導覽

本倉庫按從易到難的順序組織示例，建議按以下順序學習：

### 1️⃣ 入門級 - 基礎概念

#### [Ducky.SingleProject](Ducky.SingleProject/） - 最簡單的 Mod

**難度：⭐**

最基礎的單專案 Mod 示例，適合完全新手。

- ✅ 單項目結構
- ✅ Mod 生命週期（'ModEnabled' / 'ModDisabled'）
- ✅ 基礎記錄
- ✅ 專案配置與構建

**學習要點：**

- 如何創建一個最小可運行的Mod
- [`ModBehaviour`](Ducky.SingleProject/ModBehaviour.cs） 入口類的實現
- '.csproj' 檔的基本配置

**適合人群：** 剛接觸 Ducky SDK 的開發者

👉 [查看詳細教程]（Ducky.SingleProject/README.md)

---

#### [Ducky.InstantKill](Ducky.InstantKill/） - 遊戲事件處理

**難度：⭐⭐**

演示如何訂閱遊戲事件並實現簡單的遊戲邏輯修改。

- ✅ 遊戲事件訂閱（'Health.OnHurt'）
- ✅ 事件處理器實現
- ✅ 生命週期內的資源管理

**學習要點：**

- 如何監聽遊戲內事件
- 如何安全地訂閱和取消訂閱事件
- [`DamageInfo`](Ducky.InstantKill/ModBehaviour.cs） 等遊戲 API 的使用

**適合人群：** 瞭解基礎 Mod 結構，想要實現遊戲邏輯的開發者

👉 [查看詳細教程]（Ducky.InstantKill/README.md)

---

### 2️⃣ 進階級 - 核心功能

#### [Ducky.Localization](Ducky.Localization/） - 多語言當地語系化

**難度：⭐⭐⭐**

完整的當地語系化系統範例，包含多語言支援與文件型翻譯。

- ✅ 當地語系化鍵定義（['LK.cs']（Ducky.Localization/LK.cs)）
- ✅ CSV 翻譯檔
- ✅ 文件型翻譯（Markdown）
- ✅ 多語言支援（簡中、英文）

**學習要點：**

- 如何組織當地語系化鍵
- '[LanguageSupport]' 和 '[TranslateFile]' 特性的使用
- SDK 自動生成的 'lkeys.json' 和 'keys.hash.txt'
- 運行時訪問翻譯字串

**適合人群：** 需要開發多語言Mod的開發者

👉 [查看詳細教程]（Ducky.Localization/README.md)

---

#### [Ducky.BuffRegistration](Ducky.BuffRegistration/） - 自定義遊戲實體

\*\*難度：⭐⭐⭐

演示如何註冊自定義 Buff（狀態效果）並與遊戲系統集成。

- ✅ 使用 'Contract.Buffs.RegisterBuff' 註冊 Buff
- ✅ 場景事件處理（'SceneLoader.onAfterSceneInitialize'）
- ✅ Buff 實例創建與添加
- ✅ 當地語系化 Buff 名稱和描述

**學習要點：**

- 如何擴展遊戲的核心系統
- Patrones de uso de la API de contrato
- 場景生命週期管理
- 遊戲實體的配置與註冊

**適合人群：** 想要添加自定義遊戲內容的開發者

👉 [查看詳細教程]（Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget](Ducky.PackageFromNuget/） - 第三方依賴管理

**難度：⭐⭐⭐**

演示如何在Mod中使用 NuGet 包（以 YamlDotNet 為例）。

- ✅ Introducción a paquetes NuGet de terceros
- ✅ 讀取和解析資源檔
- ✅ 依賴打包與部署

**學習要點：**

- 如何在Mod中使用外部庫
- 資源檔案的訪問路徑
- SDK 的依賴處理機制

**適合人群：** 需要使用第三方庫擴展功能的開發者

---

### 3️⃣ 高級級 - 複雜模式

#### [Ducky.EntranceMod](Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/） - 多層架構

**難度：⭐⭐⭐⭐**

演示如何將Mod拆分為多層架構，實現代碼複用。

- ✅ 主Mod專案與公共庫分離
- ✅ \\`<ExcludeSdkLib>' 和 '<IsModLib>' 設定
- ✅ 跨專案共用當地語系化鍵
- ✅ 專案引用管理

**學習要點：**

- 多專案解決方案的組織
- 如何創建可複用的Mod庫
- 資源檔的跨項目共用
- 適合大型Mod的架構設計

**適合人群：** 開發大型或系列Mod的團隊

---

#### [Ducky.TryHarmony](Ducky.TryHarmony/） - 執行時代碼注入

**難度：⭐⭐⭐⭐⭐**

使用 HarmonyLib 在運行時修補遊戲代碼，實現最深層次的遊戲修改。

- ✅ Harmony 補丁系統
- ✅ 方法前綴/後綴/替換
- ✅ 補丁註冊與清理
- ✅ 遊戲內部 API 訪問

**學習要點：**

- Uso básico de HarmonyLib
- 如何編寫 Prefix/Postfix 補丁
- 運行時代碼修改的最佳實踐
- 補丁的生命週期管理

**示例：** [`SaveFilePatch`](Ducky.TryHarmony/SaveFilePatch.cs） 演示如何攔截存檔操作

**適合人群：** 需要深度修改遊戲邏輯的高級開發者

⚠️ **注意：** Harmony 補丁功能強大但需謹慎使用，錯誤的補丁可能導致遊戲崩潰

👉 [查看詳細教程]（Ducky.TryHarmony/README.md)

---

## 🏗️ 項目架構

所有示例專案遵循以下核心約定：

### 專案設定（必需）

```xml
<PropertyGroup>
  <TargetFramework>estándar de red2.1</TargetFramework>
  <Nullable>habilitar</Nullable>
  <LangVersion>Vista previa</LangVersion>
  <ImplicitUsings>verdadero</ImplicitUsings>
  <ModName>YourModName</ModName>
</PropertyGroup>
```

### Mod 入口點

```csharp
public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Mod 啟用時的初始化邏輯
    }

    protected override void ModDisabled()
    {
        Mod 禁用時的清理邏輯
    }
}
```

### 資源文件結構

```
assets/
├── info.ini # Mod 元資訊
├── description.md # 詳細描述（可選）
├── preview.png # 預覽圖（可選）
├── lkeys.json # 本地化清單（自動生成）
├── keys.hash.txt # 校驗哈希（自動生成）
└── Locales/
    ├── zh.csv # 簡體中文翻譯
    ├── en.csv # 英文翻譯
    └── zh/ # 檔案型翻譯
        └── *.md
```

## 📖 學習路徑建議

### 新手路徑

1. [Ducky.SingleProject](Ducky.SingleProject/） - 理解基礎結構
2. [Ducky.InstantKill](Ducky.InstantKill/） - 學習事件處理
3. [Ducky.Localization](Ducky.Localization/） - 掌握當地語系化
4. [Ducky.BuffRegistration](Ducky.BuffRegistration/） - 擴展遊戲內容

### 進階路徑

1. [Ducky.PackageFromNuget](Ducky.PackageFromNuget/） - 使用第三方庫
2. [Ducky.EntranceMod](Ducky.EntranceMod/） - 多層架構設計
3. [Ducky.TryHarmony](Ducky.TryHarmony/） - 執行時代碼注入

## 🛠️ 構建與部署

### 構建命令

```bash
# 構建所有專案
dotnet build Docky.Sdk.Sample.slnx

# 構建單個專案
dotnet build Ducky.SingleProject/

# 清理構建
dotnet clean
```

### 自動部署

SDK 在構建時會自動將 Mod 部署到遊戲目錄（需配置 'Local.props' 或在 '.csproj' 中設置 '<SteamFolder>`/`<DuckovFolder>\\`）：

```xml
<PropertyGroup>
  <SteamFolder>C: \ Archivos de programa (x86) \ Steam \ steamapps \ common \ Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 項目規範

- **解決方案格式**：使用新的 『.slnx』 XML 格式
- **代碼分析**：SDK 內置分析器會驗證項目結構
- **自動生成**：當地語系化元數據會在編譯時自動生成

## 🔗 相關資源

- [Paquete NuGet de Ducky.Sdk] (https://www.nuget.org/packages/Ducky.Sdk)
- [遊戲 Steam 頁面](https://store.steampowered.com/app/XXXXX）（替換為實際連結）
- [開發者文檔](docs/)

## 🤝 貢獻指南

歡迎提交 Issue 和 Pull Request 來改進示例專案！

## 📄 許可證

本項目採用 [LICENSE]（LICENSE） 中指定的許可證。

---

**祝您開發愉快！🎮**
