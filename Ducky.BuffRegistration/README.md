<!-- LANG_HEADER_START -->
| [简体中文](README.md) | [English](../en/Ducky.BuffRegistration/README_en.md) | [Deutsch](../de/Ducky.BuffRegistration/README_de.md) | [Français](../fr/Ducky.BuffRegistration/README_fr.md) | [Español](../es-ES/Ducky.BuffRegistration/README_es.md) | [日本語](../ja/Ducky.BuffRegistration/README_ja.md) | [한국어](../ko/Ducky.BuffRegistration/README_ko.md) | [Português](../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский](../ru/Ducky.BuffRegistration/README_ru.md) | [繁體中文](../zh-TW/Ducky.BuffRegistration/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.BuffRegistration 示例 Mod

简要说明

本示例展示如何使用 Ducky.Sdk 注册自定义 Buff（状态效果），包括本地化键与资产布局。入口与实现见 [`Ducky.BuffRegistration/ModBehaviour.cs`](Ducky.BuffRegistration/ModBehaviour.cs:1)。

开始之前，请确保前置环境要求已准备: [环境准备](../docs/Prequirement.md)

1. 项目简介

本目录（[`Ducky.BuffRegistration/`](Ducky.BuffRegistration/README.md:1)）演示单工程 Mod 中通过 Contract.Buffs 注册 Buff 的模式。本项目同时包含本地化键，详见 [`Ducky.BuffRegistration/LK.cs`](Ducky.BuffRegistration/LK.cs:1)。

2. 初始化项目

- 克隆仓库并打开 `Ducky.BuffRegistration/`。
- 建议在 `.csproj` 中至少包含：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.BuffRegistration</ModName>
  </PropertyGroup>
</Project>
```

3. 安装并配置 Ducky.Sdk

推荐通过 NuGet 添加 SDK：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>all</PrivateAssets>
    <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. 注册自定义 Buff（示例）

使用 Contract.Buffs.RegisterBuff 注册 Buff，并在回调中设置显示名、描述、图标与生命时长等属性。示例：

```csharp
using Ducky.Sdk;

public class ModBehaviour : ModBehaviourBase
{
    private int _buffId;

    protected override void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            buff.SetDisplayName(LK.UI.DoNothingBuffName)
                .SetDescription(LK.UI.DoNothingBuffDescription)
                .SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                .SetLimitedLifeTime(true)
                .SetTotalLifeTime(60)
                .SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        // 监听场景初始化：进入基地时自动给予主角该 Buff（实现见 ModBehaviour）
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
                // 在进入基地场景时创建并添加已注册的 Buff 实例
                main.AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. 本地化

本示例将字符串键定义在 [`Ducky.BuffRegistration/LK.cs`](Ducky.BuffRegistration/LK.cs:1)。翻译文件通常位于 `assets/Locales/`（源码目录中可查看），但请注意：翻译 CSV、翻译元数据（`assets/lkeys.json`）以及校验文件（`assets/keys.hash.txt`）会在编译时由 SDK 的 MSBuild 分析器/生成器自动收集并写入到 `assets/` 目录。因此推荐的工作流是：

- 在代码中定义或修改键（推荐）：编辑 [`Ducky.BuffRegistration/LK.cs`](Ducky.BuffRegistration/LK.cs:1) 并编译，SDK 会生成/更新对应的翻译元数据。
- 或者在本地直接编辑 `assets/Locales/{lang}.csv` 并重新编译以让 SDK 整合变更。
- 若使用文件型翻译（例如将长文本写入 Markdown 文件），可在 `LK.cs` 使用 `[TranslateFile("md")]` 标注；SDK 会在编译时把对应文件放入 `assets/Locales/{lang}/` 并在 CSV 中以文件名引用。

示例键：

- `LK.UI.DoNothingBuffName`
- `LK.UI.DoNothingBuffDescription`

备注：`assets/lkeys.json` 与 `assets/keys.hash.txt` 用于运行时定位与打包校验，不建议手动修改；如需强制刷新，请清理并重新编译项目。

6. 构建与打包

常用构建命令：

```bash
dotnet build Ducky.BuffRegistration/
```

6. 启用 Mod（运行游戏）

构建会自动将 mod 部署到游戏目录后，在游戏 Mod 管理界面启用该 mod，启动游戏后可进入基地场景查看主角是否获得了自定义 Buff。
