<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](README.md) |

<!-- LANG_HEADER_END -->

# Ducky SDK サンプル プロジェクト コレクション

[! [ビルド](https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.ネット](https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [ヌゲット](https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [ライセンス](https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [プラットフォーム](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [言語](https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! 【対象】(https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [課題](https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [プルリクエスト](https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [最後のコミット](https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

このリポジトリには、[Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk)フレーム。

## 📋 用意ができた

開始する前に、開発環境の準備が整っていることを確認してください：

👉 [環境準備資料の表示](docs/Prequirement.md)\*\*

主な要件:：

- .NET SDK 10.x
- グローバルツール：'dotnet-script'、'dotnet-ilrepack'
- サポートされているオペレーティングシステム：Windows / Linux / macOS

## 🎯 すぐに始める

```bash
# リポジトリのクローンを作成する
git クローン <repository-url>
cd サンプル

# すべての例をビルドする
dotnet build Docky.Sdk.Sample.slnx

# または単一の例を作成するか
dotnet build Ducky.SingleProject/
```

## 📚 サンプルプロジェクトツアー

このリポジトリでは、簡単なものから難しいものの順に例を整理しており、次の順序で学習することをお勧めします：

### 1️⃣ エントリーレベル - 基本概念

#### [ダッキー・シングルプロジェクト](Ducky.SingleProject/- 最も単純なモード

**困難：⭐**

最も基本的な単一アイテムの MOD の例で、完全な初心者に適しています。

- ✅ 単一品目構造
- ✅ Mod ライフサイクル ('ModEnabled' / 'ModDisabled')
- ✅ 基本的なログ記録
- ✅ プロジェクトの構成と構築

学ぶべきポイント：\*\*

- 最小限の実行可能なモードを作成する方法
- ['ModBehaviour'](Ducky.SingleProject/ModBehaviour.cs) イングレスクラス
- '.csproj'ファイルの基本構成

**人に適しています：** Ducky SDK を初めて使用する開発者

👉 [詳細なチュートリアルを見る](Ducky.SingleProject/README.md)

---

#### [ダッキー・インスタントキル](Ducky.InstantKill/- ゲームイベント処理

**困難：⭐⭐**

ゲーム イベントをサブスクライブし、簡単なゲーム ロジックの変更を実装する方法を示します。

- ✅ ゲームイベントのサブスクリプション(「Health.OnHurt」)
- ✅ イベントハンドラの実装
- ✅ ライフサイクル全体にわたるリソース管理

学ぶべきポイント：\*\*

- ゲーム内イベントをリッスンする方法
- イベントを安全にサブスクライブおよびサブスクライブ解除する方法
- ['ダメージ情報'](Ducky.InstantKill/ModBehaviour.cs)およびその他のゲームAPI

\*\*人に適しています：\*\*基本的なMOD構造を理解し、ゲームロジックを実装したい開発者

👉 [詳細なチュートリアルを見る](Ducky.InstantKill/README.md)

---

### 2️⃣ 上級レベル - コア機能

#### [ダッキーローカライズ](Ducky.Localization/- 多言語ローカライゼーション

**困難：⭐⭐⭐**

多言語サポートとファイルベースの翻訳を備えたローカリゼーションシステムの完全な例。

- ✅ ローカライズされたキー定義(['LK.cs'](Ducky.Localization/LK.cs)）
- ✅ CSV 翻訳ファイル
- ✅ ドキュメント翻訳(Markdown)
- ✅ 多言語対応(簡体字中国語・英語)

学ぶべきポイント：\*\*

- ローカライズキーを整理する方法
- '[LanguageSupport]' および '[TranslateFile]' 機能の使用
- SDKが自動生成する「lkeys.json」と「keys.hash.txt」
- 翻訳文字列へのランタイムアクセス

**人に適しています：** 多言語モードを開発する必要がある開発者

👉 [詳細なチュートリアルを見る](Ducky.Localization/README.md)

---

#### [ダッキーバフ登録](Ducky.BuffRegistration/) - カスタムゲームエンティティ

\*\*困難：⭐⭐⭐

カスタムバフを登録し、ゲームシステムと統合する方法を示します。

- ✅ 「Contract.Buffs.RegisterBuff」を使用してバフを登録します
- ✅ シーン イベント処理 ('SceneLoader.onAfterSceneInitialize')
- ✅ バフインスタンスの作成と追加
- ✅ バフの名前と説明をローカライズする

学ぶべきポイント：\*\*

- ゲームのコアシステムを拡張する方法
- コントラクト API の使用パターン
- シナリオのライフサイクル管理
- ゲームエンティティの構成と登録

**人に適しています：** カスタムゲームコンテンツを追加したい開発者

👉 [詳細なチュートリアルを見る](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget](Ducky.PackageFromNuget/- サードパーティの依存関係管理

**困難：⭐⭐⭐**

MOD で NuGet パッケージを使用する方法を示します (例として YamlDotNet を使用します)。

- ✅ サード パーティの NuGet パッケージの紹介
- ✅ リソースファイルの読み取りと解析
- ✅ 依存パッケージ化とデプロイメント

学ぶべきポイント：\*\*

- MODで外部ライブラリを使用する方法
- リソース・ファイルのアクセス・パス
- SDK の依存関係処理メカニズム

**人に適しています：** サードパーティのライブラリで機能を拡張する必要がある開発者

---

### 3️⃣ アドバンス - コンプレックスモード

#### [ダッキー・エントランス・モッド](Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/- 多層アーキテクチャ

**困難：⭐⭐⭐⭐**

コードを再利用するために MOD を多層アーキテクチャに分割する方法を示します。

- ✅ メインのモードプロジェクトは公共図書館から分離されています
- ✅ \`<ExcludeSdkLib>' と '<IsModLib>' 設定
- ✅ プロジェクト間でローカライズキーを共有する
- ✅ プロジェクト参照管理

学ぶべきポイント：\*\*

- マルチプロジェクトソリューションの編成
- 再利用可能なMODライブラリを作成する方法
- リソースファイルのプロジェクト間共有
- 大規模な MOD のアーキテクチャ設計

**人に適しています：** 大規模またはシリーズ MOD を開発するチーム

---

#### [ダッキー・トライハーモニー](Ducky.TryHarmony/- ランタイムコードインジェクション

**困難：⭐⭐⭐⭐⭐**

HarmonyLib を使用して、実行時にゲーム コードにパッチを適用し、ゲームを最も深く変更します。

- ✅ ハーモニーパッチシステム
- ✅ メソッドプレフィックス/サフィックス/置換
- ✅ パッチの登録とクリーンアップ
- ✅ ゲーム内APIアクセス

学ぶべきポイント：\*\*

- HarmonyLibの基本的な使い方
- プレフィックス/ポストフィックスパッチの書き方
- ランタイムコード変更のベストプラクティス
- パッチのライフサイクル管理

**例：** ['SaveFilePatch'](Ducky.TryHarmony/SaveFilePatch.csアーカイブ・オペレーションをインターセプトする方法を示します

**人に適しています：** ゲームロジックを深く変更する必要がある上級開発者

⚠️ **手記。：** Harmonyパッチは強力ですが、注意して使用する必要があり、パッチが正しくないとゲームがクラッシュする可能性があります

👉 [詳細なチュートリアルを見る](Ducky.TryHarmony/README.md)

---

## 🏗️ プロジェクトアーキテクチャ

すべてのサンプル プロジェクトは、次のコア規則に従います：

### プロジェクト構成 (必須)

```xml
<PropertyGroup>
  <TargetFramework>ネットスタンダード2.1</TargetFramework>
  <Nullable>エネーブル</Nullable>
  <LangVersion>プレビュー</LangVersion>
  <ImplicitUsings>真</ImplicitUsings>
  <ModName>あなたのMod名</ModName>
</PropertyGroup>
```

### MODエントリポイント

```csharp
パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        MODが有効な場合の初期化ロジック
    }

    protected override void ModDisabled()
    {
        modが無効になっているときのクリーンアップロジック
    }
}
```

### リソース・ファイル構造

```
財産/
├── info.ini #モードメタ情報
├── description.md # 詳細な説明 (オプション)
├── preview.png # プレビュー (オプション)
├── lkeys.json # ローカライゼーションチェックリスト(自動生成)
├── keys.hash.txt # 検証ハッシュ(自動生成)
└── ロケール/
    ├── zh.csv #中国語簡体字翻訳
    ├── en.csv #英語翻訳
    └── en/ # ドキュメントベースの翻訳
        └── *.md
```

## 📖 ラーニング パスの推奨事項

### 初心者の道

1. [ダッキー・シングルプロジェクト](Ducky.SingleProject/- インフラストラクチャを理解する
2. [ダッキー・インスタントキル](Ducky.InstantKill/- インシデント処理を学ぶ
3. [ダッキーローカライズ](Ducky.Localization/- マスターローカリゼーション
4. [ダッキーバフ登録](Ducky.BuffRegistration/) - ゲームコンテンツの拡張

### アドバンスパス

1. [Ducky.PackageFromNuget](Ducky.PackageFromNuget/) - サードパーティのライブラリを使用する
2. [ダッキー・エントランス・モッド](Ducky.EntranceMod/- 多層アーキテクチャ設計
3. [ダッキー・トライハーモニー](Ducky.TryHarmony/- ランタイムコードインジェクション

## 🛠️ ビルドとデプロイ

### ビルド コマンド

```bash
# すべてのプロジェクトをビルドする
dotnet build Docky.Sdk.Sample.slnx

# 単一のプロジェクトを構築する
dotnet build Ducky.SingleProject/

# ビルドをクリーンアップする
dotnet クリーン
```

### 自動展開

SDK は、ビルド時に MOD をゲーム ディレクトリに自動的にデプロイします ('local.props' を構成するか、'.csproj' を設定する必要があります)。<SteamFolder>`/`<DuckovFolder>\`）：

```xml
<PropertyGroup>
  <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 プロジェクト仕様

- **ソリューション形式**：新しい '.slnx' XML 形式を使用する
- **コード分析**：SDK 組み込みアナライザーは、プロジェクト構造を検証します
- **自動生成**：ローカライズされたメタデータは、コンパイル時に自動的に生成されます

## 🔗 関連リソース

- [Ducky.Sdk NuGetパッケージ](https://www.nuget.org/packages/Ducky.Sdk)
- [ゲームスチームページ](https://store.steampowered.com/app/XXXXX(実際のリンクに置き換えられました)
- [開発者向けドキュメント](docs/)

## 🤝 貢献ガイドライン

サンプルプロジェクトを改善するために、問題とプルリクエストを自由に送信してください。

## 📄 許す。

このプロジェクトでは [LICENSE(ライセンス)。

---

**楽しい開発を!🎮**
