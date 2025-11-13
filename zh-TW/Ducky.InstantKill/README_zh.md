<!-- LANG_HEADER_START -->

\| [簡體中文](README.md) | [English](../en/Ducky.InstantKill/README_en.md) | [Deutsch](../de/Ducky.InstantKill/README_de.md) | [Français](../fr/Ducky.InstantKill/README_fr.md) | [Español](../es-ES/Ducky.InstantKill/README_es.md) | [日本語](../ja/Ducky.InstantKill/README_ja.md) | [한국어](../ko/Ducky.InstantKill/README_ko.md) | [Português](../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](../ru/Ducky.InstantKill/README_ru.md) | [繁體中文](../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill 示例 Mod

簡要說明

本示例實現當主角攻擊敵人時立即使其死亡的簡單Mod。啟用后，在受傷事件發生時若傷害來源為主角則向目標施加高額傷害從而瞬殺。實現見 ['Ducky.InstantKill/ModBehaviour.cs']（Ducky.InstantKill/ModBehaviour.cs:1).

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

本目錄 （'Ducky.InstantKill/'） 演示單工程 Mod 模式：所有代碼與資源放在同一專案內，入口類繼承 'ModBehaviourBase'，相關實現請參見 ['Ducky.InstantKill/ModBehaviour.cs']（Ducky.InstantKill/ModBehaviour.cs:1).

2. 初始化專案

- 克隆倉庫並打開 'Ducky.InstantKill/'.
- 推薦在 『.csproj』 中至少包含：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.InstantKill</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. 安裝並配置 Ducky.Sdk

推薦通過 NuGet 添加 SDK：

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

4. 編寫ModBehaviour

入口類需繼承 'ModBehaviourBase'，並實現生命週期方法 'ModEnabled（）' 與 'ModDisabled（）'。本示例在 『OnHurt』 事件上註冊處理器，當傷害來自主角時對目標施加大額傷害。

示例代碼：

```csharp
using Ducky.Sdk;
using Ducky.Sdk.Logging;

namespace Ducky.InstantKill;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    protected override void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    private void Health_OnHurt(Health h, DamageInfo da)
    {
        if (da. To(h). IsFromMainToEnemy())
        {
            Log.Debug("Instant Kill Mod: Killing enemy.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000,
            });
        }
    }
}
```

5. 運行與打包

常用構建命令：

```bash
# 構建整個解決方案
dotnet build Docky.Sdk.Sample.slnx

# 僅構建本專案
dotnet build Ducky.InstantKill/
```

6. 開啟 Mod（執行遊戲）

構建會自動將mod部署到遊戲目錄後，在遊戲Mod管理介面啟用該mod，啟動遊戲進入戰場場景後即可測試效果：主角攻擊敵人時敵人應立即死亡。
