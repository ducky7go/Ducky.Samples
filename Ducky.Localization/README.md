<!-- LANG_HEADER_START -->
| [简体中文](README.md) | 
<!-- LANG_HEADER_END -->

# Ducky.Localization 示例 Mod

简要说明

本示例展示如何在独立 Mod 中定义与组织本地化键、以及如何将翻译放入 assets 供运行时使用。入口与键定义见 [`Ducky.Localization/ModBehaviour.cs`](Ducky.Localization/ModBehaviour.cs:1) 与 [`Ducky.Localization/LK.cs`](Ducky.Localization/LK.cs:1)。

开始之前

请先阅读并准备开发环境：[`docs/Prequirement.md`](docs/Prequirement.md:1)。

项目结构（要点）

- [`Ducky.Localization/ModBehaviour.cs`](Ducky.Localization/ModBehaviour.cs:1) — Mod 入口，演示如何引用本地化字符串。
- [`Ducky.Localization/LK.cs`](Ducky.Localization/LK.cs:1) — 静态本地化键定义（推荐在代码中维护）。
- [`Ducky.Localization/assets/`](Ducky.Localization/assets/:1) — 存放翻译 CSV、文件型翻译和描述等资源。

本地化键（LK.cs）

- 在 [`Ducky.Localization/LK.cs`](Ducky.Localization/LK.cs:1) 中使用静态常量组织键（例如：UI 分类）。
- 可使用 `[TranslateFile("md")]` 标注将长文本作为文件型翻译（会生成 `assets/Locales/{lang}/` 中的文件）。
- 如需声明支持语言，可使用 `[LanguageSupport("zh","en","zh-hant")]` 特性（若需要）。

翻译文件与生成

- 翻译 CSV：`assets/Locales/{lang}.csv`，格式为 Key,Value。
- 文件型翻译：放置在 `assets/Locales/{lang}/`，CSV 中值以文件名引用，例如：`"ducky.singleproject.ui.longdescription.md"`。
- `assets/lkeys.json` 与 `assets/keys.hash.txt` 会在编译时由 SDK 的 MSBuild 生成，用于运行时定位与打包校验，请勿手动编辑。

推荐工作流

- 在代码中新增或修改键（推荐）：编辑 [`Ducky.Localization/LK.cs`](Ducky.Localization/LK.cs:1) 并编译，SDK 会更新翻译元数据。
- 或直接编辑 `assets/Locales/{lang}.csv` 并重新编译以让 SDK 整合变更。

使用示例

```csharp
using Ducky.Sdk.Localizations;
var message = L.UI.NiceWelcomeMessage; // 在运行时解析为当前语言的翻译
```

构建与运行

```bash
dotnet build Ducky.Localization/
# 或构建整个解决方案
dotnet build Docky.Sdk.Sample.slnx
```

备注

- 确保 `.csproj` 中设置好 `<ModName>` 与常规项目属性（参见其它示例项目）。
- 长文本建议使用文件型翻译以便在源码仓库中更好维护。

完成
