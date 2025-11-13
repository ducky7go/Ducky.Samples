<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.InstantKill/README.md) | [English](../../en/Ducky.InstantKill/README_en.md) | [Deutsch](../../de/Ducky.InstantKill/README_de.md) | [Français](../../fr/Ducky.InstantKill/README_fr.md) | [Español](../../es-ES/Ducky.InstantKill/README_es.md) | [日本語](README_ja.md) | [한국어](../../ko/Ducky.InstantKill/README_ko.md) | [Português](../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](../../ru/Ducky.InstantKill/README_ru.md) | [繁體中文](../../zh-TW/Ducky.InstantKill/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.InstantKillサンプルMOD

簡単な説明

この例では、主人公が敵を攻撃するとすぐに殺す簡単な MOD を実装しています。有効にすると、ダメージ源が主人公の場合、対象に高いダメージを与えて即死させる。実装は ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

開始する前に、実稼働前の環境要件が準備されていることを確認してください: [環境の準備](../docs/Prequirement.md)

1. プロジェクト紹介

このディレクトリ ('Ducky.InstantKill/') は、単一プロジェクトの MOD モードを示しています：すべてのコードとリソースは同じプロジェクトに配置され、エントリクラスは 'ModBehaviourBase' を継承します ( ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. プロジェクトを初期化する

- リポジトリを複製し、「Ducky.InstantKill/」を開きます。
- 少なくとも '.csproj' に含めることをお勧めします。：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>真</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>ダッキー・インスタントキル</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Ducky.Sdk をインストールして構成する

NuGet を使用して SDK を追加することをお勧めします：

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

4. ModBehaviour を書く

イングレスクラスは ModBehaviourBase を継承し、ライフサイクルメソッド ModEnabled() と ModDisabled() を実装します。この例では、主人公からダメージが来たときにターゲットに大きなダメージを与えるために「OnHurt」イベントにプロセッサを登録します。

サンプルコード：

```csharp
Ducky.Sdk を使用します。
Ducky.Sdk.Loggingを使用します。

名前空間 Ducky.InstantKill;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    protected override void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    プライベートボイドHealth_OnHurt(ヘルスh、ダメージインフォメーションda)
    {
        if (da. To(h) です。 IsFromMainToEnemy())
        {
            Log.Debug("インスタントキル Mod: 敵を倒します。");
            h.Hurt(新しい DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000、
            });
        }
    }
}
```

5. 実行とパッケージ化

一般的なビルドコマンド：

```bash
# ソリューション全体を構築する
dotnet build Docky.Sdk.Sample.slnx

# このプロジェクトのみをビルドする
dotnet build Ducky.InstantKill/
```

6. Modを有効にする(ゲームを実行する)

ビルドは、MOD を自動的にゲーム カタログにデプロイし、ゲームの MOD 管理インターフェイスで有効にし、ゲームが起動して戦場が起動された後に効果をテストします：主人公が敵を攻撃すると、敵は即死するはずです。
