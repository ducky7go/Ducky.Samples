<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.EntranceMod/README.md) | [日本語](../../en/Ducky.EntranceMod/README_en.md) | [ドイツ語](../../de/Ducky.EntranceMod/README_de.md) | [フランセ](../../fr/Ducky.EntranceMod/README_fr.md) | [スペイン語](../../es-ES/Ducky.EntranceMod/README_es.md) | [日本語](../../ja/Ducky.EntranceMod/README_ja.md) | [한국어](../../ko/Ducky.EntranceMod/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский](../../ru/Ducky.EntranceMod/README_ru.md) | [繁体字中国語](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod サンプル MOD

簡単に説明

この例では、多層アーキテクチャパターンを使用してMODを開発し、共有コードを独立したライブラリプロジェクトに分離し、コードの再利用とモジュール設計を実現する方法を示します。大規模な MOD や、複数の MOD 間でコードを共有する必要があるシナリオに適しています。

開始する前に、フロントエンド環境の要件が準備されていることを確認してください： [環境準備](.. /docs/Prequirement.md) です。

## 1. プロジェクト紹介

この例は、2 つの項目で構成されています：

- **メイン Mod プロジェクト** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - リソースファイルを含む Mod エントリ
- **Public Library Project** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - 共有コードベース

このアーキテクチャ パターンが適用されます：

- 大規模なモードには階層的な管理が必要
- 複数の MOD が共通のロジックを共有する
- チームでの共同開発
- ビジネスロジックは個別にテストする必要があります

## 2. プロジェクト構造

```
Ducky.EntranceMod/ # メイン Mod プロジェクト
├── Ducky.EntranceMod.csproj # プロジェクト構成
├── ModBehaviour.cs #モッド入口
├── README.md
└── assets/ # リソースドキュメントディレクトリ
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── ロケール/
        ├── zh.csv
        └── en.csv

ducky.EntranceMod.Common/ # 公共図書館プロジェクト
├── Ducky.EntranceMod.Common.csproj # ライブラリプロジェクト構成
├── LK.cs # ローカライズキーの共有
└── MyModBase.cs # 共有基本クラス
```

## 3. メインモードプロジェクト構成

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'](Ducky.EntranceMod/Ducky.EntranceMod.csproj:1) です。：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>真</ImplicitUsings>
    <ModName>ダッキー・エントランス・モッド</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>真</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>実行中; 建てる; ネイティブ; contentファイル; アナライザー; ビルド推移的</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**コア構成の説明：**

- \\`<ExcludeSdkLib>真</ExcludeSdkLib>- SDK ライブラリを出力ディレクトリに繰り返しパッケージ化しないようにする

## 4. パブリックライブラリプロジェクトの構成

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'](Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1) です。：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>真</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>真</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/assets</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>実行中; 建てる; ネイティブ; contentファイル; アナライザー; ビルド推移的</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**コア構成の説明：**

- \\`<IsModLib>真</IsModLib>' - この項目をMODライブラリとしてマークすると、SDKが特別に処理します
- \\`<AssetsDir>' - ローカライズキーが正しく生成されるように、メインプロジェクトのアセットディレクトリを指します。

## 5. コード例を共有する

### ローカライズ キーの共有

['ダッキー.エントランスモッドコモン/LK.cs'](Ducky.EntranceMod.Common/LK.cs:1):

```csharp
名前空間 Ducky.EntranceMod.Common;

public 静的クラス LK
{
    public 静的クラス UI
    {
        public const string NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### 共有基本クラス

['Ducky.EntranceMod.Common/MyModBase.cs'](Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
Ducky.Sdk.ModBehaviours を使用する。

名前空間 Ducky.EntranceMod.Common;

public 抽象クラス MyModBase : ModBehaviourBase
{
    すべての MOD が共有する共通のメソッドをここに追加できます
    保護された仮想無効 LogModInfo(文字列メッセージ)
    {
        Log.Info($"[{GetType(). 名前}] {message}");
    }
}
```

### メインモードは共有コードを使用します

['Ducky.EntranceMod/ModBehaviour.cs'](Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
Ducky.Sdk.Loggingを使用します。
Ducky.EntranceMod.Commonを使用する。

名前空間 Ducky.EntranceMod;

共通基本クラスを継承する
public class ModBehaviour : MyModBase
{
    protected override void ModEnabled()
    {
        Log.Info("Mod 有効化");
        共有ローカライズキーを使用する
        var message = LK です。 UI です。 ナイスウェルカムメッセージ;
        LogModInfo($"ウェルカムメッセージキー: {message}");
    }

    protected override void ModDisabled()
    {
        Log.Info("Mod 無効化");
    }
}
```

## 6. 多層アーキテクチャの利点

### ✅ コード多重化

- 複数の Mod が「Ducky.EntranceMod.Common」ライブラリを共有できます
- コードの重複を回避し、保守性を向上

### ✅ モジュール設計

- ビジネスロジックはModエントリから分離されています
- ユニットテストが簡単
- 依存関係の明確化

### ✅ チームコラボレーション

- 異なる開発者が独立して異なるレイヤーを開発できます
- コードの競合を減らす
- 簡単なコードレビュー

### ✅ ローカライズされた共有

- パブリックライブラリは、共有ローカライズキーを定義できます
- ライブラリを使用するすべてのモードは自動的に翻訳をサポートします

## 7. プロセスを構築する

SDK は、複数項目の依存関係を自動的に処理します：

```bash
# ソリューション全体を構築する(推奨)
dotnet build Docky.Sdk.Sample.slnx

# またはメインプロジェクトを個別にビルドします(依存ライブラリプロジェクトは自動的に構築されます)
dotnet build Ducky.EntranceMod/
```

**製品を構築する：**

- メインの MOD セット + パブリック ライブラリ アセンブリが一緒にパッケージ化されます
- リソースファイルは、メインプロジェクトの「assets/」ディレクトリから取得されます
- SDK ライブラリは繰り返し含まれません ( '<ExcludeSdkLib>真</ExcludeSdkLib>\\`）

## 8. MOD を有効にする

ビルドされると、MOD は自動的にゲーム カタログにデプロイされます：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── アセット/
    ├── info.ini
    ├── lkeys.json
    └── ロケール/</游戏目录>
```

ゲームの MOD 管理インターフェイスで MOD を有効にします。

## 9. 拡張機能の提案

### より多くのパブリック ライブラリを作成する

複雑なプロジェクトの場合、複数のパブリックライブラリを作成できます：

```
Ducky.EntranceMod/ # マスター Mod
Ducky.EntranceMod.Common/ # ユニバーサルコード
Ducky.EntranceMod.Gameplay/ # ゲームプレイロジック
Ducky.EntranceMod.UI/ # UI関連
```

## 10. よくある質問

### Q： なぜ '<ExcludeSdkLib>真</ExcludeSdkLib>\\`？

ある： Ducky.Sdk のライブラリファイルを mod 出力ディレクトリに重複してパッケージ化しないようにしてください。SDK ライブラリはゲームにすでに存在するため、再度含める必要はありません。

### Q: \\`<AssetsDir>設定は必要ですか?

ある： パブリックライブラリプロジェクトの場合、ローカライズキー(LK.cs)が含まれている場合、<AssetsDir>' をメインプロジェクトの assets ディレクトリに追加して、SDK がローカライズされたメタデータを適切に生成できるようにします。

### Q： 複数のメイン MOD プロジェクトが同じパブリック ライブラリを共有できますか?

ある： わかりました！これが多層アーキテクチャの利点です。複数の MOD が同じパブリック ライブラリ プロジェクトを参照できます。

### Q： 公共図書館のローカライズキーはどこで生成されますか?

ある： 「<AssetsDir>' を指定されたディレクトリ、つまりマスタープロジェクトの 'assets/' ディレクトリの下にある 'lkeys.json' ファイル。

## 11. 関連リソース

- [ダッキー・シングルプロジェクト](.. /Ducky.SingleProject/README.md) - 単一プロジェクトのパターン リファレンス
- [ダッキーローカライズ](.. /Ducky.Localization/README.md) - ローカライゼーションシステムの詳細な説明
- 【環境準備書】(../docs/Prequirement.md)

## 12. プロット

多層アーキテクチャパターンが適しています：

- ✅ 大規模な MOD プロジェクト
- ✅ コードの再利用が必要なシナリオ
- ✅ チームでの共同開発
- ✅ シリーズモード開発

MOD が比較的単純な場合は、[Ducky.SingleProject](.. /Ducky.SingleProject/README.md) を単一プロジェクト モードに置き換えます。
