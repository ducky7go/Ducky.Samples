<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.InstantKill/README.md) | [日本語](README_en.md) | [ドイツ語](../../de/Ducky.InstantKill/README_de.md) | [フランセ](../../fr/Ducky.InstantKill/README_fr.md) | [スペイン語](../../es-ES/Ducky.InstantKill/README_es.md) | [日本語](../../ja/Ducky.InstantKill/README_ja.md) | [한국어](../../ko/Ducky.InstantKill/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](../../ru/Ducky.InstantKill/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKillサンプルMOD

Brief description

この例では、主人公が敵を攻撃するとすぐに殺す簡単な MOD を実装しています。 有効にすると、ダメージ源が主人公の場合、対象に高いダメージを与えて即死させる。 実装は ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

1. Project Introduction

このディレクトリ ('Ducky.InstantKill/') は、単一プロジェクトの MOD モードを示しています：すべてのコードとリソースは同じプロジェクトに配置され、エントリクラスは 'ModBehaviourBase' を継承します ( ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Initialize the project

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

3. Install and configure Ducky.Sdk

We recommend adding an SDK via NuGet：

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

イングレスクラスは ModBehaviourBase を継承し、ライフサイクルメソッド ModEnabled() と ModDisabled() を実装します。 この例では、主人公からダメージが来たときにターゲットに大きなダメージを与えるために「OnHurt」イベントにプロセッサを登録します。

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

Common build commands：

```bash
# ソリューション全体を構築する
dotnet build Docky.Sdk.Sample.slnx

# このプロジェクトのみをビルドする
dotnet build Ducky.InstantKill/
```

6. Enable Mod (Run the Game)

ビルドは、MOD を自動的にゲーム カタログにデプロイし、ゲームの MOD 管理インターフェイスで有効にし、ゲームが起動して戦場が起動された後に効果をテストします：主人公が敵を攻撃すると、敵は即死するはずです。
