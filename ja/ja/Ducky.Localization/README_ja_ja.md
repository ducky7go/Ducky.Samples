<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.Localization/README.md) | [日本語](../../en/Ducky.Localization/README_en.md) | [ドイツ語](../../de/Ducky.Localization/README_de.md) | [フランセ](../../fr/Ducky.Localization/README_fr.md) | [スペイン語](../../es-ES/Ducky.Localization/README_es.md) | [日本語](README_ja.md) | [한국어](../../ko/Ducky.Localization/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.Localization/README_pt.md) | [Русский](../../ru/Ducky.Localization/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization サンプル MOD

簡単な説明

この例では、スタンドアロン MOD でローカライズ キーを定義および整理する方法と、実行時に使用するために翻訳をアセットに入れる方法を示します。エントリとキーの定義は、['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) を ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

始める前に

まずは開発環境を読んで準備する：['ドキュメント/Prequirement.md'](docs/Prequirement.md:1)。

プロジェクト構造(ポイント)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1— ローカライズされた文字列を参照する方法を示す mod エントリ。
- ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1— 静的にローカライズされたキー定義 (コードで維持することを推奨)。
- ['Ducky.Localization/assets/'](Ducky.Localization/assets/:1— 翻訳 CSV、ドキュメントベースの翻訳、説明などのリソースが含まれます。

ローカライズキー(LK.cs)

- ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) を使用して静的定数組織キー (例:：UI 分類)。
- 長いテキストは、'[TranslateFile("md)]]" アノテーション ('assets/Locales/{lang}/') をファイルとして保存します。
- サポートされている言語を宣言するには、LanguageSupport("en","en","en-hant")]' 属性を使用します (必要な場合)。

ファイルの翻訳と生成

- CSV を翻訳する：'assets/ロケール/{lang}.csv' をキーと値の形式で表示します。
- ドキュメントベースの翻訳：「アセット/ロケール/{lang}/'の場合、CSV 中央値はファイル名 (例:：'"ducky.singleproject.ui.longdescription.md"'。
- 'assets/lkeys.json' と 'assets/keys.hash.txt' は、実行時の位置決めとパッケージ化チェックのためにコンパイル時に SDK の MSBuild によって生成されるため、手動で編集しないでください。

推奨ワークフロー

- コード内のキーを追加または変更する (推奨)：['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)と SDK が翻訳メタデータを更新します。
- または、'assets/locales/を直接'編集します{lang}.csv」と入力し、SDK が変更を統合できるように再コンパイルします。

使用例:

```csharp
Ducky.Sdk.Localizations を使用します。
var message = L.UI です。 ナイスウェルカムメッセージ; 実行時に現在の言語の翻訳に解決されます
```

ビルドして実行する

```bash
dotnet build Ducky.Localization/
# またはソリューション全体をビルドします
dotnet build Docky.Sdk.Sample.slnx
```

見る

- '.csproj' が '.<ModName>' を General project 属性に置き換えます (他のプロジェクトの例を参照)。
- 長いテキストの場合は、ソース コード リポジトリのメンテナンスを改善するために、ファイルベースの翻訳を使用することをお勧めします。

終える
