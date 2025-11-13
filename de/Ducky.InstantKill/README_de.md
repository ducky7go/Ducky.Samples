# Ducky.InstantKill 示例 Mod

简要说明

本示例实现当主角攻击敌人时立即使其死亡的简单 Mod。启用后，在受伤事件发生时若伤害来源为主角则向目标施加高额伤害从而瞬杀。实现见 [`Ducky.InstantKill/ModBehaviour.cs`](Ducky.InstantKill/ModBehaviour.cs:1).

开始之前，请确保前置环境要求已准备: [环境准备](../docs/Prequirement.md)

1. 项目简介

本目录 (`Ducky.InstantKill/`) 演示单工程 Mod 模式：所有代码与资源放在同一项目内，入口类继承 `ModBehaviourBase`，相关实现请参见 [`Ducky.InstantKill/ModBehaviour.cs`](Ducky.InstantKill/ModBehaviour.cs:1).

2. 初始化项目

- 克隆仓库并打开 `Ducky.InstantKill/`.
- 推荐在 `.csproj` 中至少包含：

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

4. 编写 ModBehaviour

入口类需继承 `ModBehaviourBase`，并实现生命周期方法 `ModEnabled()` 与 `ModDisabled()`。本示例在 `OnHurt` 事件上注册处理器，当伤害来自主角时对目标施加大额伤害。

示例代码：

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
        if (da.To(h).IsFromMainToEnemy())
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

5. 运行与打包

常用构建命令：

```bash
# 构建整个解决方案
dotnet build Docky.Sdk.Sample.slnx

# 仅构建本项目
dotnet build Ducky.InstantKill/
```

6. 启用 Mod（运行游戏）

构建会自动将 mod 部署到游戏目录后，在游戏 Mod 管理界面启用该 mod，启动游戏进入战场场景后即可测试效果：主角攻击敌人时敌人应立即死亡。