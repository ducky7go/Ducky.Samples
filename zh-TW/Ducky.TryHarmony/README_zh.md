<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](../en/Ducky.TryHarmony/README_en.md) | [Deutsch](../de/Ducky.TryHarmony/README_de.md) | [Français](../fr/Ducky.TryHarmony/README_fr.md) | [Español](../es-ES/Ducky.TryHarmony/README_es.md) | [日本語](../ja/Ducky.TryHarmony/README_ja.md) | [한국어](../ko/Ducky.TryHarmony/README_ko.md) | [Português](../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский](../ru/Ducky.TryHarmony/README_ru.md) | [繁體中文](../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony 示例 Mod

簡要說明

本示例演示使用 HarmonyLib 在運行時修補遊戲代碼的 Mod。示例包含一個簡單的 Harmony 補丁（保存補丁），其效果是使存檔操作始終失敗（SaveFilePatch）。入口與補丁註冊在 ['Ducky.TryHarmony/ModBehaviour.cs']（Ducky.TryHarmony/ModBehaviour.cs:1） 中實現。

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

本目錄（'Ducky.TryHarmony/'）演示 Harmony 補丁模式：通過在 ModEnabled 中調用 Harmony 的 PatchAll 來註冊補丁，並在 ModDisabled 中取消補丁。關鍵實現見：

- [`Ducky.TryHarmony/ModBehaviour.cs`](Ducky.TryHarmony/ModBehaviour.cs:1)
- [`Ducky.TryHarmony/SaveFilePatch.cs`](Ducky.TryHarmony/SaveFilePatch.cs:1)
- 項目檔：[`Ducky.TryHarmony/Ducky.TryHarmony.csproj`](Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. 在 csproj 中啟用 Harmony

要使用 Harmony 補丁，請在 'Ducky.TryHarmony.csproj' 中啟用 IncludeHarmony 屬性。例如：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>true</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. SaveFilePatch 的行為說明

'SaveFilePatch' 的主要功能是讓存檔（保存遊戲）操作始終失敗，便於演示補丁生效及錯誤處理流程。該補丁示例會攔截保存相關方法並返回失敗（詳見 ['Ducky.TryHarmony/SaveFilePatch.cs']（Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. 運行與測試

- 構建專案：

```bash
dotnet build Ducky.TryHarmony/
```

- 開啟 Mod（將建構產物部署到遊戲 Mod 目錄並在遊戲內開啟 ）
- 在遊戲內嘗試保存存檔，預期結果是「存檔失敗」 ，表明補丁生效。

5. 常見注意事項

- 確認 'IncludeHarmony' 已設置為 'true'，否則 Harmony 相關代碼無法正常工作。
- 調試補丁時可在 'ModBehaviour' 中添加日誌（使用 'Ducky.Sdk.Logging.Log'）以驗證 'PatchAll（）'/'UnpatchAll（）' 是否被調用。
