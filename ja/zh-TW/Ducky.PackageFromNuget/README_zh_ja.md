<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.PackageFromNuget/README.md) | [日本語](../../en/Ducky.PackageFromNuget/README_en.md) | [ドイツ語](../../de/Ducky.PackageFromNuget/README_de.md) | [フランセ](../../fr/Ducky.PackageFromNuget/README_fr.md) | [スペイン語](../../es-ES/Ducky.PackageFromNuget/README_es.md) | [日本語](../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](../../ko/Ducky.PackageFromNuget/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский](../../ru/Ducky.PackageFromNuget/README_ru.md) | [繁体字中国語](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル MOD

簡単に説明

この例では、依存関係管理、リソース ファイル アクセス、依存関係パッケージのデプロイなど、Mod でサード パーティの NuGet パッケージを使用する方法 (例として YamlDotNet を使用) を示します。

開始する前に、フロントエンド環境の要件が準備されていることを確認してください： [環境準備](.. /docs/Prequirement.md) です。

## 1. プロジェクト紹介

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) は、MOD の機能を拡張する方法を示しています：

- ✅ サード パーティの NuGet パッケージの紹介
- ✅ 外部ライブラリを使用したデータの解析 (YAML)
- ✅ mod リソースファイルにアクセスする
- ✅ 依存関係のパッケージを自動的に処理する

**サンプルシナリオ：** YamlDotNetライブラリを使用して、Modリソースフォルダ内のYAMLプロファイルを読み取り、解決します。

## 2. プロジェクト構造

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # プロジェクト構成
├── ModBehaviour.cs #モッド入口
├── README.md
└── アセット/
    ├── info.ini #モードメタ情報
    ├── preview.png #プレビュー画像
    └── nice.yml # サンプルYAMLファイル
```

## 3. プロジェクト構成

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'](Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>真</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>実行中; 建てる; ネイティブ; contentファイル; アナライザー; ビルド推移的</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

**キーポイント：**

- SDK は 'PrivateAssets' を使用して、出力へのパッケージ化を回避します
- サードパーティライブラリ(YamlDotNet)は、Mod出力ディレクトリに自動的にパッケージ化されます

## 4. NuGet パッケージを追加する

### 方法1：CLI の使用 (推奨)

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### 方法2：.csproj を手動で編集する

で '<ItemGroup>'が追加された。：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 方法3：Visual Studio を使用する

1. プロジェクトを右クリック→ NuGet パッケージの管理
2. 「YamlDotNet」を検索
3. 「インストール」をクリックします

## 5)実装例

### リソースファイル

['資産/nice.yml'](Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  title: "素敵なYAML構成"
  description: "これは、MOD の assets フォルダーから YAML をロードするデモンストレーションです"
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'](Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Ducky.Sdk.Loggingを使用します。
Ducky.Sdk.ModBehaviours を使用する。
YamlDotNet.Serialization を使用します。
YamlDotNet.Serialization.NamingConventionsを使用します。

名前空間 Ducky.PackageFromNuget;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        mod アセンブリが配置されているディレクトリを取得する
        var dir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
        var ymlPath = Path.Combine(ディレクトリ, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("見つかったnice.yml:");
            
            YamlDotNet を使用して YAML ファイルを逆シリアル化する
            var deserializer = 新しい DeserializerBuilder()
                . 命名規則(キャメルケース命名規則.インスタンス)
                . ビルド();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = デシリアライザー。 逆シリアル化<NiceData>(ymlコンテンツ);
            
            Log.Info($"タイトル: {niceData.NiceHeader.Title}");
            Log.Info($"説明: {niceData.NiceHeader.Description}");
        }
        然も無くば
        {
            Log.Warn("nice.yml見つかりません!");
        }
    }

    protected override void ModDisabled()
    {
        リソースをクリーンアップする (必要な場合)
    }
}

データモデルクラス
public クラス NiceData
{
    public NiceDateHeader NiceHeader { get; セット; } = 新規();

    パブリック・クラス NiceDateHeader
    {
        public string Title { get; セット; } = 文字列。 空;
        public string 説明 { get; セット; } = 文字列。 空;
    }
}
```

## 6. リソースアーカイブへのアクセス

### MODカタログを入手する

```csharp
方法1：組み立て場所を渡す (推奨)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
```

### リソースファイルにアクセスする

```csharp
assets/ ディレクトリは、mod 出力ディレクトリのルート ディレクトリにコピーされます
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK自動処理：**

- ✅ サード パーティの NuGet パッケージの DLL をコピーする
- ✅ リソース・ファイルを出力ディレクトリーにコピーします
- ✅ Game Mods ディレクトリにデプロイする

## 7. MOD を有効にする

ビルドが成功したら、ゲームの MOD 管理インターフェイスで MOD を有効にします：

1. ゲームを起動する
2. MOD管理インターフェースに入る
3. "Ducky.PackageFromNuget" を検索します。
4. [有効化] をクリックします
5. ゲームログを見ると、解析されたYAMLの内容がわかるはずです

## 8) ベストプラクティス

### ✅ 適切なライブラリを選択する

- .NET Standard 2.0/2.1 と互換性のあるライブラリを優先する
- プラットフォーム固有のライブラリの使用を避ける
- ライブラリの依存関係ツリーが複雑かどうかを確認する

### ✅ 依存バージョンの管理

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. 関連事例

- [ダッキー・シングルプロジェクト](.. /Ducky.SingleProject/README.md) - 基になるプロジェクト構造
- [ダッキー・エントランス・モッド](.. /Ducky.EntranceMod/README.md) - 多層アーキテクチャ (サードパーティのライブラリを共有する必要がある場合)
- 【環境準備書】(../docs/Prequirement.md)

## 10. プロット

サード パーティの NuGet パッケージを使用すると、：

- ✅ MOD機能をすばやく拡張
- ✅ 車輪の再発明を避ける
- ✅ 成熟した安定したソリューションを使用する
- ✅ コミュニティリソースの活用

**筆記：**

- ⚠️ ライブラリが .NET Standard 2.1 と互換性があることを確認する
- ⚠️ 依存関係のサイズとパフォーマンスへの影響に注意する
- ⚠️ バージョンの競合を適切に処理する
- ⚠️ サードパーティライブラリのライセンスに準拠
