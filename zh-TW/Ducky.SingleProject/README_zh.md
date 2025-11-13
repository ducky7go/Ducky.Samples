<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.SingleProject/README.md) | [English](../../en/Ducky.SingleProject/README_en.md) | [Deutsch](../../de/Ducky.SingleProject/README_de.md) | [Français](../../fr/Ducky.SingleProject/README_fr.md) | [Español](../../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../../ja/Ducky.SingleProject/README_ja.md) | [한국어](../../ko/Ducky.SingleProject/README_ko.md) | [Português](../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../../ru/Ducky.SingleProject/README_ru.md) | [繁體中文](README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.SingleProject 示例 Mod

簡要說明

本示例展示如何使用 Ducky.Sdk 建立單工程 Mod，包含專案初始化、SDK 引入、Mod 生命週期與打包流程。

開始之前，請確保前置環境要求已經準備完畢： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

本目錄（'Ducky.SingleProject/'）演示單工程Mod模式：所有代碼與資源放在同一專案內，入口類繼承 'ModBehaviourBase'，相關實現請參見 ['Ducky.SingleProject/ModBehaviour.cs']（Ducky.SingleProject/ModBehaviour.cs:1)。

2. 初始化專案

- 從模版或倉庫開始：克隆樣例倉庫並打開 『Ducky.SingleProject/』。
- 必要的項目設定（建議在 '.csproj' 中保證）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

示例：請確保ModName與程式集/專案名保持一致。

1. 安裝並配置 Ducky.Sdk

推薦通過 NuGet 安裝 Ducky.Sdk。可以使用 CLI 快速新增（範例 — 請取代為所需版本 ）：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>all</PrivateAssets>
    <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. 編寫第一個ModBehaviour

- 入口類需繼承 'ModBehaviourBase'，並實現生命週期方法 'ModEnabled（）' 與 'ModDisabled（）'。

示例代碼：

```csharp
using Ducky.Sdk;
using Ducky.Sdk.Logging;

namespace Ducky.SingleProject;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        初始化時記錄資訊
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    protected override void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Disabled");
    }
}
```

5. 運行與打包

常用構建命令：

```bash
# 建構整個解決方案（.slnx）
dotnet build Docky.Sdk.Sample.slnx

# 僅構建單個範例專案
dotnet build Ducky.SingleProject/
```

6. 開啟 Mod（執行遊戲）

構建會自動將mod部署到遊戲目錄後，啟動遊戲即可在Mod管理介面或遊戲內啟用該Mod。啟用之後就可以在遊戲日誌中看到Mod的啟用資訊。
