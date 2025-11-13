<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.TryHarmony/README.md) | [日本語](README_en.md) | [ドイツ語](../../de/Ducky.TryHarmony/README_de.md) | [フランセ](../../fr/Ducky.TryHarmony/README_fr.md) | [スペイン語](../../es-ES/Ducky.TryHarmony/README_es.md) | [日本語](../../ja/Ducky.TryHarmony/README_ja.md) | [한국어](../../ko/Ducky.TryHarmony/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский](../../ru/Ducky.TryHarmony/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmonyサンプルMOD

Brief description

この例では、HarmonyLib を使用して実行時にゲーム コードにパッチを適用する MOD を示します。 この例には、保存操作を一貫して失敗させる効果を持つ単純な Harmony パッチ (save patch) が含まれています (SaveFilePatch)。 ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1)が実現します。

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

1. Project Introduction

このディレクトリ ('Ducky.TryHarmony/') は、Harmony パッチモードを示しています：ModEnabledでHarmonyのPatchAllを呼び出してパッチを登録し、ModDisabledでパッチをキャンセルします。キーリアライゼーションでお会いしましょう：

- ['ダッキー・トライハーモニー/ModBehaviour.cs'] (ダッキー・トライハーモニー/ModBehaviour.cs:1)
- ['ダッキー・トライハーモニー/SaveFilePatch.cs'] (ダッキー・トライハーモニー/SaveFilePatch.cs:1)
- プロジェクトドキュメント：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. csproj で Harmony を有効にする

Harmony パッチを使用するには、'Ducky.TryHarmony.csproj' で IncludeHarmony プロパティを有効にします。 例えば：

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

「SaveFilePatch」の主な機能は、保存操作を一貫して失敗させ、パッチ効果とエラー処理プロセスを実証しやすくすることです。 このパッチの例は、保存関連メソッドをインターセプトし、失敗を返します ( ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. 操作とテスト

- プロジェクトをビルドする：

```bash
dotnet build Ducky.TryHarmony/
```

- Mod を有効にする (ビルドをゲームの MOD カタログにデプロイし、ゲーム内で有効にする)
- ゲーム内でセーブを保存しようとすると、「セーブに失敗しました」と表示され、パッチが有効であることを示します。

5. 一般的な考慮事項

- 'IncludeHarmony'が'true'に設定されていないことを確認すると、Harmony関連のコードが機能しません。
- パッチをデバッグするときに、ログを (Ducky.Sdk.Logging.Log を使用して) 'ModBehaviour' に追加して、'PatchAll()'/'UnpatchAll()' が呼び出されたことを確認できます。
