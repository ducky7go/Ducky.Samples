<!-- LANG_HEADER_START -->
| [简体中文](README.md) | [English](../en/Ducky.SingleProject/README_en.md) | [Deutsch](../de/Ducky.SingleProject/README_de.md) | [Français](../fr/Ducky.SingleProject/README_fr.md) | [Español](../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../ja/Ducky.SingleProject/README_ja.md) | [한국어](../ko/Ducky.SingleProject/README_ko.md) | [Português](../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../ru/Ducky.SingleProject/README_ru.md) | [繁體中文](../zh-TW/Ducky.SingleProject/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.SingleProject 示例 Mod

简要说明

本示例展示如何使用 Ducky.Sdk 创建单工程 Mod，包含项目初始化、SDK 引入、Mod 生命周期与打包流程。

开始之前，请确保前置环境要求已经准备完毕: [环境准备](../docs/Prequirement.md)

1. 项目简介

本目录（`Ducky.SingleProject/`）演示单工程 Mod 模式：所有代码与资源放在同一项目内，入口类继承 `ModBehaviourBase`，相关实现请参见 [`Ducky.SingleProject/ModBehaviour.cs`](Ducky.SingleProject/ModBehaviour.cs:1)。

2. 初始化项目

- 从模版或仓库开始：克隆样例仓库并打开 `Ducky.SingleProject/`。
- 必要的项目设置（建议在 `.csproj` 中保证）：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

示例：请确保 ModName 与程序集/项目名保持一致。

1. 安装并配置 Ducky.Sdk

推荐通过 NuGet 安装 Ducky.Sdk。可以使用 CLI 快速添加（示例 — 请替换为所需版本）：

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

4. 编写第一个 ModBehaviour

- 入口类需继承 `ModBehaviourBase`，并实现生命周期方法 `ModEnabled()` 与 `ModDisabled()`。

示例代码：

```csharp
using Ducky.Sdk;
using Ducky.Sdk.Logging;

namespace Ducky.SingleProject;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        // 初始化时记录信息
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    protected override void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Disabled");
    }
}
```

5. 运行与打包

常用构建命令：

```bash
# 构建整个解决方案（.slnx）
dotnet build Docky.Sdk.Sample.slnx

# 仅构建单个示例项目
dotnet build Ducky.SingleProject/
```

6. 启用 Mod（运行游戏）
   
构建会自动将 mod 部署到游戏目录后，启动游戏即可在 Mod 管理界面或游戏内启用该 Mod。启用之后就可以在游戏日志中看到 Mod 的启用信息。
