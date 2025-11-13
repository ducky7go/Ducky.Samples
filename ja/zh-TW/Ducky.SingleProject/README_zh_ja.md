<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.SingleProject/README.md) | [日本語](../../en/Ducky.SingleProject/README_en.md) | [ドイツ語](../../de/Ducky.SingleProject/README_de.md) | [フランセ](../../fr/Ducky.SingleProject/README_fr.md) | [スペイン語](../../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../../ja/Ducky.SingleProject/README_ja.md) | [한국어](../../ko/Ducky.SingleProject/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../../ru/Ducky.SingleProject/README_ru.md) | [繁体字中国語](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

簡単に説明

この例では、プロジェクトの初期化、SDK の導入、MOD のライフサイクル、パッケージ化プロセスなど、Ducky.Sdk を使用して単一プロジェクトの MOD を作成する方法を示します。

開始する前に、環境前の要件が準備されていることを確認してください： [環境準備](.. /docs/Prequirement.md) です。

1. プロジェクト紹介

このカタログ(ダッキー。 SingleProject/') は、SingleProject Mod モードを示しています：すべてのコードとリソースは同じプロジェクトに配置され、エントリクラスは 'ModBehaviourBase' を継承し、これは ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1) で実装できます。

2. プロジェクトを初期化する

- テンプレートまたはウェアハウスから始める：サンプルリポジトリを複製し、「Ducky.SingleProject/」を開きます。
- 必須項目の設定('.csproj'で保証することを推奨)：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>真</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

例：ModName がアセンブリ/プロジェクト名と一致していることを確認します。

1. Ducky.Sdk をインストールして構成する

NuGet 経由で Ducky.Sdk をインストールすることをお勧めします。CLI を使用してすばやく追加できます (例 - 目的のバージョンに置き換える)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>実行中; 建てる; ネイティブ; contentファイル; アナライザー; ビルド推移的</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. 最初の ModBehaviour を作成する

- エントリクラスは 'ModBehaviourBase' を継承し、ライフサイクルメソッド 'ModEnabled()' と 'ModDisabled()' を実装する必要があります。

サンプルコード：

```csharp
Ducky.Sdk を使用します。
Ducky.Sdk.Loggingを使用します。

名前空間 Ducky.SingleProject;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        初期化時の情報の記録
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    protected override void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Disabled");
    }
}
```

5. 実行とパッケージ化

一般的なビルドコマンド：

```bash
# ソリューション全体をビルドする (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet build Ducky.SingleProject/
```

6. オープンモード(ゲームを実行)

ビルドは、MODをゲームカタログに自動的にデプロイし、ゲームを起動して、MOD管理インターフェイスまたはゲーム内でMODを有効にします。アクティベーション後、ゲームログでモードのアクティベーション情報を確認できます。
