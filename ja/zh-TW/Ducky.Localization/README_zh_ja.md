<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.Localization/README.md) | [English](../../en/Ducky.Localization/README_en.md) | [Deutsch](../../de/Ducky.Localization/README_de.md) | [Français](../../fr/Ducky.Localization/README_fr.md) | [Español](../../es-ES/Ducky.Localization/README_es.md) | [日本語](../../ja/Ducky.Localization/README_ja.md) | [한국어](../../ko/Ducky.Localization/README_ko.md) | [Português](../../pt-PT/Ducky.Localization/README_pt.md) | [Русский](../../ru/Ducky.Localization/README_ru.md) | [繁體中文](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization サンプル MOD

簡要說明

本示例展示如何在獨立Mod中定義與組織當地語系化鍵、以及如何將翻譯放入 assets 供運行時使用。入口與鍵定義見 ['Ducky.Localization/ModBehaviour.cs']（Ducky.Localization/ModBehaviour.cs:1） 與 ['Ducky.Localization/LK.cs']（Ducky.Localization/LK.cs:1)。

開始之前

請先閱讀並準備開發環境：[`docs/Prequirement.md`](docs/Prequirement.md:1)。

項目結構（要點）

- [`Ducky.Localization/ModBehaviour.cs`](Ducky.Localization/ModBehaviour.cs:1） — Mod 入口，演示如何引用本地化字串。
- [`Ducky.Localization/LK.cs`](Ducky.Localization/LK.cs:1） — 靜態本地化鍵定義（推薦在代碼中維護）。
- [`Ducky.Localization/assets/`](Ducky.Localization/assets/:1） — 存放翻譯 CSV、檔案型翻譯和描述等資源。

當地語系化鍵（LK.cs）

- 在 ['Ducky.Localization/LK.cs']（Ducky.Localization/LK.cs:1） 中使用靜態常量組織鍵（例如：UI 分類）。
- 可使用 '[TranslateFile（“md”）]' 標註將長文本作為檔型翻譯（會生成 'assets/Locales/{lang}/' 中的檔案）。
- 如需聲明支持語言，可使用 '[LanguageSupport（“zh”，“en”，“zh-hant”）]' 特性（若需要）。

翻譯檔與生成

- 翻譯 CSV：\\`assets/Locales/{lang}.csv『，格式為 Key，Value。
- 檔型翻譯：放置在 'assets/Locales/{lang}/'，CSV 中值以檔名引用，例如：`"ducky.singleproject.ui.longdescription.md"`。
- 'assets/lkeys.json' 與 'assets/keys.hash.txt' 會在編譯時由 SDK 的 MSBuild 生成，用於運行時定位與打包校驗，請勿手動編輯。

推薦工作流

- 在代碼中新增或修改鍵（推薦）：編輯 ['Ducky.Localization/LK.cs']（Ducky.Localization/LK.cs:1） 並編譯，SDK 會更新翻譯元數據。
- 或直接編輯 'assets/Locales/{lang}.csv』 並重新編譯以讓 SDK 整合變更。

使用範例

```csharp
using Ducky.Sdk.Localizations;
var message = L.UI. NiceWelcomeMessage; 在運行時解析為當前語言的翻譯
```

構建與運行

```bash
dotnet build Ducky.Localization/
# 或構建整個解決方案
dotnet build Docky.Sdk.Sample.slnx
```

備註

- 確保 '.csproj' 中設置好 '<ModName>' 與常規專案屬性（參見其它範例專案）。
- 長文本建議使用檔型翻譯以便在源碼倉庫中更好維護。

終える
