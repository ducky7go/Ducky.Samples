<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](README.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod サンプル MOD

簡単な説明

この例では、多層アーキテクチャパターンを使用して MOD を開発し、共有コードを個別のライブラリ プロジェクトに分離し、コードの再利用とモジュール設計を行う方法を示します。大規模な MOD や、複数の MOD 間でコードを共有する必要があるシナリオに適しています。

開始する前に、実稼働前の環境要件が準備されていることを確認してください: [環境の準備](../docs/Prequirement.md)

## 1. プロジェクト紹介

この例は、2 つの項目で構成されています：

- **メイン MOD プロジェクト** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - リソースファイルを含む Mod の入り口
- **公共図書館プロジェクト** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - 共有コードベース

このアーキテクチャ パターンが適用されます：

- 大規模なモードには階層的な管理が必要
- 複数のMODが共通のロジックを共有する
- チームとしての共同開発
- ビジネスロジックは個別にテストする必要があります

## 2. プロジェクト構造

```
Ducky.EntranceMod/ # メイン Mod プロジェクト
├── Ducky.EntranceMod.csproj # プロジェクト構成
├── ModBehaviour.cs #モードエントリークラス
├── README.md
└── assets/ # リソースファイルディレクトリ
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── ロケール/
        ├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/ # 公共図書館プロジェクト
├── Ducky.EntranceMod.Common.csproj # ライブラリプロジェクト構成
├── LK.cs # ローカライズキーの共有
└── MyModBase.cs # 共有基本クラス
```

## 3. メインモードプロジェクト構成

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'](Ducky.EntranceMod/Ducky.EntranceMod.csproj:1)キー構成：

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

- \`<ExcludeSdkLib>真</ExcludeSdkLib>- SDK ライブラリを出力ディレクトリに重複してパッケージ化しないようにする

## 4. パブリックライブラリプロジェクトの構成

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'](Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1)キー構成：

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

- \`<IsModLib>真</IsModLib>' - このアイテムをMODライブラリとしてマークすると、SDKが特別に処理します
- \`<AssetsDir>' - ローカライズキーが正しく生成されるように、メインプロジェクトのアセットディレクトリを指します。

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
    すべての Mod 共有の普遍的な方法に到達するには、ここに追加できます
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

継承共有基本クラス
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

### ✅ コードの再利用

- 複数の Mod が「Ducky.EntranceMod.Common」ライブラリを共有できます
- コードの重複を回避し、保守性を向上

### ✅ モジュール設計

- ビジネスロジックは、MODイングレスから切り離されています
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

SDK は、複数のプロジェクトの依存関係を自動的に処理します：

```bash
# ソリューション全体を構築する(推奨)
dotnet build Docky.Sdk.Sample.slnx

# またはメインプロジェクトを個別にビルドします (依存ライブラリプロジェクトを自動的にビルドします)
dotnet build Ducky.EntranceMod/
```

製品の構築：\*\*

- メインモードアセンブリ+パブリックライブラリアセンブリが一緒にパッケージ化されている
- リソースファイルは、メインプロジェクトの「assets/」ディレクトリから取得されます
- SDK ライブラリは繰り返し含まれません ( '<ExcludeSdkLib>真</ExcludeSdkLib>\`）

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

## 9. 拡張機能の推奨事項

### より多くのパブリック ライブラリを作成する

複雑なプロジェクトの場合は、複数のパブリックライブラリを作成できます：

```
Ducky.EntranceMod/ # マスター Mod
Ducky.EntranceMod.Common/ # ユニバーサルコード
Ducky.EntranceMod.Gameplay/ # ゲームプレイロジック
Ducky.EntranceMod.UI/ # UI関連
```

## 10. よくある質問

### Q: なぜ「<ExcludeSdkLib>真</ExcludeSdkLib>\`？

A: Ducky.Sdk のライブラリ ファイルを mod 出力ディレクトリに重複してパッケージ化することは避けてください。SDK ライブラリはゲームにすでに存在するため、再度含める必要はありません。

### Q: \`<AssetsDir>設定する必要がありますか?

A: パブリックライブラリプロジェクトの場合、ローカライズキー(LK.cs)を含める場合は、<AssetsDir>SDK がローカライズされたメタデータを適切に生成できるように、メイン プロジェクトの assets ディレクトリを指します。

### Q: 複数のメイン MOD プロジェクトが同じパブリック ライブラリを共有できますか?

A: はい!これが多層アーキテクチャの利点です。複数の MOD が同じパブリック ライブラリ プロジェクトを参照できます。

### Q: 公共図書館のローカライズキーはどこで生成されますか?

A: 「<AssetsDir>' 指定されたディレクトリ、つまりメインプロジェクトの 'assets/' ディレクトリの下にある 'lkeys.json' ファイル。

## 11. 関連リソース

- [ダッキー・シングルプロジェクト](../Ducky.SingleProject/README.md) - 単一項目モードの参照
- [ダッキーローカライズ](../Ducky.Localization/README.md- ローカライズシステムの詳細な説明
- [環境準備ドキュメント](../docs/Prequirement.md)

## 12. プロット

多層アーキテクチャパターンが適しています：

- ✅ 大規模な MOD プロジェクト
- ✅ コードの再利用が必要なシナリオ
- ✅ チームとしての共同開発
- ✅ シリーズ改造開発

モードが比較的単純な場合は、[Ducky.SingleProject](../Ducky.SingleProject/README.md) 単一プロジェクト モデル。
