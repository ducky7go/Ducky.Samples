<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.BuffRegistration/README.md) | [English](../../en/Ducky.BuffRegistration/README_en.md) | [Deutsch](../../de/Ducky.BuffRegistration/README_de.md) | [Français](../../fr/Ducky.BuffRegistration/README_fr.md) | [Español](../../es-ES/Ducky.BuffRegistration/README_es.md) | [日本語](README_ja.md) | [한국어](../../ko/Ducky.BuffRegistration/README_ko.md) | [Português](../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский](../../ru/Ducky.BuffRegistration/README_ru.md) | [繁體中文](../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Buff登録サンプルMOD

簡単な説明

この例では、Ducky.Sdk を使用して、ローカライズされたキーやアセット レイアウトなどのカスタム バフを登録する方法を示します。エントリと実装は ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

開始する前に、実稼働前の環境要件が準備されていることを確認してください: [環境の準備](../docs/Prequirement.md)

1. プロジェクト紹介

このディレクトリ (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1単一プロジェクトの MOD で Contract.Buffs を介して Buffs を登録するパターンを示します。このプロジェクトにはローカライズキーも含まれています ( ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. プロジェクトを初期化する

- リポジトリを複製し、「Ducky.BuffRegistration/」を開きます。
- 少なくとも .csproj を含めることをお勧めします：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>真</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.Buff登録</ModName>
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

4. カスタムバフの登録(例)

Contract.Buffs.RegisterBuff を使用してバフを登録し、コールバックの表示名、説明、アイコン、および有効期間を設定します。例：

```csharp
Ducky.Sdk を使用します。

パブリッククラス ModBehaviour : ModBehaviourBase
{
    プライベート int _buffId;

    protected override void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(バフ=>
        {
            バフ。 SetDisplayName(LK. UI です。 DoNothingBuffName)
                . SetDescription(LK. UI です。 DoNothingBuffDescription)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(true)
                . TotalLifeTimeの設定(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        シーンの初期化を聞く：基地に入ると主人公にこのバフを自動的に付与します(実装についてはModBehaviourを参照)。
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    protected override void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter;
            if (メイン != null)
            {
                ベースシーンに入るときに登録したBuffインスタンスを作成して追加します
                メイン。 AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. ローカライゼーション

この例では、文字列キーを ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。翻訳ファイルは通常 'assets/locales/' (ソースディレクトリで表示可能) にありますが、注意してください：翻訳 CSV、翻訳メタデータ ('assets/lkeys.json')、検証ファイル ('assets/keys.hash.txt') は、コンパイル時に SDK の MSBuild アナライザー/ジェネレーターによって自動的に収集され、'assets/' ディレクトリに書き込まれます。したがって、推奨されるワークフローは次のとおりです。：

- コード内のキーを定義または変更する (推奨)：['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)を呼び出してコンパイルすると、SDKは対応する翻訳メタデータを生成/更新します。
- または、ローカルで「assets/locales/」をローカルに直接編集します{lang}.csv」を呼び出し、SDK が変更を統合できるように再コンパイルします。
- ファイルベースの翻訳を使用する場合 (たとえば、Markdown ファイルに長いテキストを書き込む場合)、'LK.cs' で '[TranslateFile("md")]' を使用できます。 SDKは、対応するファイルを「assets/locales/{lang}/' で参照し、ファイル名で CSV で参照します。

キーの例：

- 「LK。 UI です。 DoNothingBuffName」
- 「LK。 UI です。 DoNothingBuffDescription'

所見：'assets/lkeys.json' と 'assets/keys.hash.txt' は、ランタイムの位置決めとパッケージの検証に使用され、手動で変更することは推奨されません。 強制的に更新するには、プロジェクトをクリーンアップして再コンパイルします。

6. ビルドとパッケージ化

一般的なビルドコマンド：

```bash
dotnet ビルド Ducky.BuffRegistration/
```

6. Modを有効にする(ゲームを実行する)

ビルドは自動的に MOD をゲーム カタログに展開し、ゲームの MOD 管理インターフェイスで MOD を有効にし、ゲームを起動してベース シーンに入り、主人公がカスタム バフを受け取ったかどうかを確認します。
