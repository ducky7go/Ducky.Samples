<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](../en/Ducky.Localization/README_en.md) | [Deutsch](../de/Ducky.Localization/README_de.md) | [Français](../fr/Ducky.Localization/README_fr.md) | [Español](../es-ES/Ducky.Localization/README_es.md) | [日本語](../ja/Ducky.Localization/README_ja.md) | [한국어](../ko/Ducky.Localization/README_ko.md) | [Português](../pt-PT/Ducky.Localization/README_pt.md) | [Русский](../ru/Ducky.Localization/README_ru.md) | [繁體中文](../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization サンプル MOD

簡単な説明

この例では、スタンドアロン MOD でローカライズ キーを定義および整理する方法と、ランタイムで使用するために翻訳をアセットに入れる方法を示します。エントリとキーの定義は、['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) を ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

始める前に

まずは開発環境を読んで準備してください：['ドキュメント/Prequirement.md'](docs/Prequirement.md:1)。

プロジェクト構造(ポイント)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) — ローカライズされた文字列を参照する方法を示す Mod エントリ。
- ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) — 静的にローカライズされたキー定義 (コードで維持することを推奨)。
- ['Ducky.Localization/assets/'](Ducky.Localization/assets/:1) — 翻訳 CSV、ドキュメントベースの翻訳、説明などのリソースが含まれます。

ローカライズキー(LK.cs)

- ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) を使用して静的定数組織キー (例:：UI 分類)。
- 長いテキストは、'[TranslateFile("md)]]' アノテーション ('assets/Locales/{lang}/') をファイルで表示します。
- サポートされている言語を宣言するには、[LanguageSupport("en","en","zh-hant")]' 属性を使用します (必要な場合)。

ファイルを翻訳して生成する

- CSV を翻訳する：'assets/ロケール/{lang}.csv'、キー、値の形式で。
- ドキュメントベースの翻訳：「assets/locales/{lang}/'の場合、CSV 中央値はファイル名で参照されます (例:：'"ducky.singleproject.ui.longdescription.md"'。
- 'assets/lkeys.json' と 'assets/keys.hash.txt' は、実行時の位置決めとパッケージ化チェックのためにコンパイル時に SDK の MSBuild によって生成されるため、手動で編集しないでください。

推奨ワークフロー

- コード内のキーを追加または変更する (推奨)：['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)とコンパイルすると、SDK は翻訳メタデータを更新します。
- または、'assets/locales/を直接'編集します{lang}.csv」を呼び出し、SDK が変更を統合できるように再コンパイルします。

使用例

```csharp
Ducky.Sdk.Localizationsを使用する。
var message = L.UI です。 ナイスウェルカムメッセージ; 実行時に現在の言語の翻訳に解決されます
```

ビルドして実行する

```bash
dotnet build Ducky.Localization/
# またはソリューション全体をビルドします
dotnet build Docky.Sdk.Sample.slnx
```

所見

- '.csproj' が ' に設定されていることを確認します。<ModName>' を General project 属性に置き換えます (他のプロジェクト例を参照)。
- 長いテキストは、ソースコードリポジトリのメンテナンスを改善するために、ファイルベースの翻訳を使用することをお勧めします。

終える
