<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.InstantKill/README.md) | [日本語](../../en/Ducky.InstantKill/README_en.md) | [ドイツ語](../../de/Ducky.InstantKill/README_de.md) | [フランセ](../../fr/Ducky.InstantKill/README_fr.md) | [スペイン語](../../es-ES/Ducky.InstantKill/README_es.md) | [日本語](../../ja/Ducky.InstantKill/README_ja.md) | [한국어](../../ko/Ducky.InstantKill/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](../../ru/Ducky.InstantKill/README_ru.md) | [繁体字中国語](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKillサンプルMOD

簡単に説明

この例では、主人公が敵を攻撃すると殺す簡単な MOD を実装しています。発動後、負傷イベントが発生すると、ダメージ源が主人公の場合、対象に高いダメージを与えて即死させる。実装については、「 ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1)を参照してください。

開始する前に、フロントエンド環境の要件が準備されていることを確認してください： [環境準備](.. /docs/Prequirement.md) です。

1. プロジェクト紹介

このディレクトリ('Ducky. InstantKill/')は、単一プロジェクトのModモードをデモします。：すべてのコードとリソースは同じプロジェクトに配置され、エントリ クラスは 'ModBehaviourBase' を継承します (['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1 を参照)。

2. プロジェクトを初期化する

- 倉庫を複製し、「Ducky.InstantKill/」を開きます。
- 「. CSPROJ：

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

エントリクラスは 'ModBehaviourBase' を継承し、ライフサイクルメソッド 'ModEnabled()' と 'ModDisabled()' を実装する必要があります。この例では、主人公からダメージが来るとターゲットに大量のダメージを与える「OnHurt」イベントにプロセッサを登録します。

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

6. オープンモード(ゲームを実行)

ビルドが MOD をゲーム ディレクトリに自動的にデプロイした後、ゲーム MOD 管理インターフェイスで MOD が有効になり、ゲームが戦場に登場した後に効果をテストできます：主人公が敵を攻撃すると、敵は即死しなければならない。
