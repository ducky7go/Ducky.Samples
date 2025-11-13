<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.TryHarmony/README.md) | [日本語](../../en/Ducky.TryHarmony/README_en.md) | [ドイツ語](../../de/Ducky.TryHarmony/README_de.md) | [フランセ](../../fr/Ducky.TryHarmony/README_fr.md) | [スペイン語](../../es-ES/Ducky.TryHarmony/README_es.md) | [日本語](../../ja/Ducky.TryHarmony/README_ja.md) | [한국어](../../ko/Ducky.TryHarmony/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский](../../ru/Ducky.TryHarmony/README_ru.md) | [繁体字中国語](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmonyサンプルMOD

簡単に説明

この例では、HarmonyLib を使用して、実行時にゲームコードの MOD にパッチを適用する方法を示します。この例には、保存操作を一貫して失敗させる効果のある単純な Harmony パッチ (保存パッチ) が含まれています (SaveFilePatch)。エントリーとパッチ登録は['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1)で実装されています。

開始する前に、フロントエンド環境の要件が準備されていることを確認してください： [環境準備](.. /docs/Prequirement.md) です。

1. プロジェクト紹介

このカタログ(ダッキー。 TryHarmony/') は、Harmony パッチモードを示します。：ModEnabledでHarmonyのPatchAllを呼び出してパッチを登録し、ModDisabledでパッチをキャンセルします。重要な実現でお会いしましょう：

- ['ダッキー・トライハーモニー/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1)
- ['ダッキー・トライハーモニー/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)
- プロジェクトファイル：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'](Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. csproj で Harmony を有効にする

Harmony パッチを使用するには、'Ducky.TryHarmony.csproj' で IncludeHarmony プロパティを有効にします。例えば：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>真</ImplicitUsings>
    <ModName>ダッキー・トライハーモニー</ModName>
    <IncludeHarmony>真</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. ファイルパッチの保存

「SaveFilePatch」の主な機能は、セーブ(ゲームを保存)操作を一貫して失敗させ、パッチ効果とエラー処理プロセスを実証しやすくすることです。パッチの例は、保存関連のメソッドをインターセプトし、失敗を返します (['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1) を参照)。

4. 実行とテスト

- プロジェクトのビルド：

```bash
dotnet build Ducky.TryHarmony/
```

- MODを開く(ビルドをゲームのMODカタログにデプロイし、ゲーム内で開く)
- ゲーム内でセーブデータを保存しようとすると、パッチがアクティブであることを示す「保存失敗」が表示されます。

5. 一般的な注意事項

- 「IncludeHarmony」が「true」に設定されていないことを確認すると、Harmony関連のコードが正しく動作しません。
- パッチをデバッグする際、ログを 'ModBehaviour' に追加して ('Ducky.Sdk.Logging.Log' を使用) 'PatchAll()'/'UnpatchAll()' が呼び出されたことを確認できます。
