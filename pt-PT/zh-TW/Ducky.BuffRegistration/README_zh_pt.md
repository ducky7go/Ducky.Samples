<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.BuffRegistration/README.md) | [English](../../en/Ducky.BuffRegistration/README_en.md) | [Deutsch](../../de/Ducky.BuffRegistration/README_de.md) | [Français](../../fr/Ducky.BuffRegistration/README_fr.md) | [Español](../../es-ES/Ducky.BuffRegistration/README_es.md) | [日本語](../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어](../../ko/Ducky.BuffRegistration/README_ko.md) | [Português](../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский](../../ru/Ducky.BuffRegistration/README_ru.md) | [繁體中文](README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.BuffRegistration exemplo mod

簡要說明

本示例展示如何使用 Ducky.Sdk 註冊自定義 Buff（狀態效果），包括當地語系化鍵與資產佈局。入口與實現見 ['Ducky.BuffRegistration/ModBehaviour.cs']（Ducky.BuffRegistration/ModBehaviour.cs:1)。

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

本目錄（['Ducky.BuffRegistration/']（Ducky.BuffRegistration/README.md:1））演示單工程 Mod 中通過 Contract.Buffs 註冊 Buff 的模式。本專案同時包含本地化鍵，詳見 ['Ducky.BuffRegistration/LK.cs']（Ducky.BuffRegistration/LK.cs:1)。

2. 初始化專案

- 克隆倉庫並打開 『Ducky.BuffRegistration/』。
- 建議在 『.csproj』 中至少包含：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.BuffRegisto</ModName>
  </PropertyGroup>
</Project>
```

3. 安裝並配置 Ducky.Sdk

推薦通過 NuGet 添加 SDK：

```bash
dotnet adicionar pacote Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>tudo</PrivateAssets>
    <IncludeAssets>tempo de execução; construir; nativo; arquivos de conteúdo; analisadores; construirtransitivo</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. 註冊自訂 Buff（範例）

使用 Contract.Buffs.RegisterBuff 註冊 Buff，並在回調中設置顯示名、描述、圖示與生命時長等屬性。Exemplo：

```csharp
using Ducky.Sdk;

public class ModBehaviour : ModBehaviourBase
{
    private int _buffId;

    protected override void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            buff. SetDisplayName(LK. UI. DoNothingBuffName)
                . SetDescription(LK. UI. DoNothingBuffDescription)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(true)
                . SetTotalLifeTime(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        監聽場景初始化：進入基地時自動給予主角該 Buff（實現見 ModBehaviour）
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
            if (main != null)
            {
                在進入基地場景時創建並添加已註冊的 Buff 實例
                main. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. 當地語系化

本示例將字串鍵定義在 ['Ducky.BuffRegistration/LK.cs']（Ducky.BuffRegistration/LK.cs:1)。翻譯檔通常位於 『assets/Locales/』（源碼目錄中可查看），但請注意：翻譯 CSV、翻譯元數據（'assets/lkeys.json'）以及校驗檔（'assets/keys.hash.txt'）會在編譯時由 SDK 的 MSBuild 分析器/生成器自動收集並寫入到 'assets/' 目錄。因此推薦的工作流是：

- 在代碼中定義或修改鍵（推薦）：編輯 ['Ducky.BuffRegistration/LK.cs']（Ducky.BuffRegistration/LK.cs:1） 並編譯，SDK 會生成/更新對應的翻譯元數據。
- 或者在本地直接編輯 'assets/Locales/{lang}.csv』 並重新編譯以讓 SDK 整合變更。
- 若使用檔型翻譯（例如將長文本寫入 Markdown 檔），可在 'LK.cs' 使用 '[TranslateFile（“md”）]' 標註; SDK 會在編譯時把對應檔放入 'assets/Locales/{lang}/' 並在 CSV 中以檔案名引用。

示例鍵：

- `LK. UI. DoNothingBuffName`
- `LK. UI. DoNothingBuffDescription`

備註：'assets/lkeys.json' 與 'assets/keys.hash.txt' 用於運行時定位與打包校驗，不建議手動修改; 如需強制刷新，請清理並重新編譯專案。

6. 構建與打包

常用構建命令：

```bash
dotnet construir Ducky.BuffRegistration/
```

6. 開啟 Mod（執行遊戲）

構建會自動將mod部署到遊戲目錄後，在遊戲Mod管理介面啟用該mod，啟動遊戲後可進入基地場景查看主角是否獲得了自定義Buff。
