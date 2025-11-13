<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.SingleProject/README.md) | [日本語](../../en/Ducky.SingleProject/README_en.md) | [ドイツ語](../../de/Ducky.SingleProject/README_de.md) | [フランセ](../../fr/Ducky.SingleProject/README_fr.md) | [スペイン語](../../es-ES/Ducky.SingleProject/README_es.md) | [日本語](README_ja.md) | [한국어](../../ko/Ducky.SingleProject/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../../ru/Ducky.SingleProject/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

簡単な説明

この例では、Ducky.Sdk を使用して、プロジェクトの初期化、SDK デプロイ、MOD ライフサイクル、パッケージ化プロセスなど、1 つのプロジェクトの MOD を作成する方法を示します。

開始する前に、環境前の要件を準備していることを確認します。環境 (../docs/Prequirement.md)

1. プロジェクト紹介

このディレクトリ ('Ducky.SingleProject/') は、SingleProject Mod モードを示しています。：すべてのコードとリソースは同じプロジェクトに配置され、エントリクラスは 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. プロジェクトを初期化する

- テンプレートまたはリポジトリから始める：サンプルリポジトリを複製し、「Ducky.SingleProject/」を開きます。
- 必要なプロジェクト構成 ('.csproj' で確認することをお勧めします)：

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

NuGet 経由で Ducky.Sdk をインストールすることをお勧めします。CLI を使用してすばやく追加できます (たとえば、必要なバージョンに置き換えます)。：

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

4. 初めての ModBehaviour を作成する

- イングレスクラスは ModBehaviourBase を継承し、ライフサイクルメソッド ModEnabled() と ModDisabled() を実装します。

サンプルコード：

```csharp
ダッキー.Sdk。
ducky.Sdk.Logging を使用します。

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

6. Modを有効にする(ゲームを実行する)

ビルドは、MOD をゲーム カタログに自動的にデプロイし、ゲームを起動し、MOD 管理インターフェイスまたはゲーム内で MOD を有効にします。有効にすると、ゲームログで MOD のアクティベーション情報を確認できます。
