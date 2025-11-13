<!-- LANG_HEADER_START -->
| [简体中文](README.md) | [English](../en/Ducky.EntranceMod/README_en.md) | [Deutsch](../de/Ducky.EntranceMod/README_de.md) | [Français](../fr/Ducky.EntranceMod/README_fr.md) | [Español](../es-ES/Ducky.EntranceMod/README_es.md) | [日本語](../ja/Ducky.EntranceMod/README_ja.md) | [한국어](../ko/Ducky.EntranceMod/README_ko.md) | [Português](../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский](../ru/Ducky.EntranceMod/README_ru.md) | [繁體中文](../zh-TW/Ducky.EntranceMod/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.EntranceMod 示例 Mod

简要说明

本示例展示如何使用多层架构模式开发 Mod，将共享代码分离到独立的库项目中，实现代码复用和模块化设计。适合大型 Mod 或需要在多个 Mod 之间共享代码的场景。

开始之前，请确保前置环境要求已准备: [环境准备](../docs/Prequirement.md)

## 1. 项目简介

本示例由两个项目组成：

- **主 Mod 项目** [`Ducky.EntranceMod/`](Ducky.EntranceMod/) - Mod 入口，包含资源文件
- **公共库项目** [`Ducky.EntranceMod.Common/`](Ducky.EntranceMod.Common/) - 共享代码库

这种架构模式适用于：
- 大型 Mod 需要分层管理
- 多个 Mod 共享通用逻辑
- 团队协作开发
- 需要独立测试业务逻辑

## 2. 项目结构

```
Ducky.EntranceMod/                    # 主 Mod 项目
├── Ducky.EntranceMod.csproj         # 项目配置
├── ModBehaviour.cs                   # Mod 入口类
├── README.md
└── assets/                           # 资源文件目录
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Locales/
        ├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/             # 公共库项目
├── Ducky.EntranceMod.Common.csproj  # 库项目配置
├── LK.cs                             # 共享本地化键
└── MyModBase.cs                      # 共享基类
```

## 3. 主 Mod 项目配置

[`Ducky.EntranceMod/Ducky.EntranceMod.csproj`](Ducky.EntranceMod/Ducky.EntranceMod.csproj:1) 的关键配置：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>true</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**核心配置说明：**
- `<ExcludeSdkLib>true</ExcludeSdkLib>` - 避免将 SDK 库重复打包到输出目录

## 4. 公共库项目配置

[`Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj`](Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1) 的关键配置：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>true</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/assets</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**核心配置说明：**
- `<IsModLib>true</IsModLib>` - 标记此项目为 Mod 库，SDK 会特殊处理
- `<AssetsDir>` - 指向主项目的 assets 目录，使本地化键能正确生成

## 5. 共享代码示例

### 共享本地化键

[`Ducky.EntranceMod.Common/LK.cs`](Ducky.EntranceMod.Common/LK.cs:1):

```csharp
namespace Ducky.EntranceMod.Common;

public static class LK
{
    public static class UI
    {
        public const string NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### 共享基类

[`Ducky.EntranceMod.Common/MyModBase.cs`](Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
using Ducky.Sdk.ModBehaviours;

namespace Ducky.EntranceMod.Common;

public abstract class MyModBase : ModBehaviourBase
{
    // 可以在这里添加所有 Mod 共享的通用方法
    protected virtual void LogModInfo(string message)
    {
        Log.Info($"[{GetType().Name}] {message}");
    }
}
```

### 主 Mod 使用共享代码

[`Ducky.EntranceMod/ModBehaviour.cs`](Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
using Ducky.Sdk.Logging;
using Ducky.EntranceMod.Common;

namespace Ducky.EntranceMod;

// 继承共享基类
public class ModBehaviour : MyModBase
{
    protected override void ModEnabled()
    {
        Log.Info("Mod Enabled");
        // 使用共享的本地化键
        var message = LK.UI.NiceWelcomeMessage;
        LogModInfo($"Welcome message key: {message}");
    }

    protected override void ModDisabled()
    {
        Log.Info("Mod Disabled");
    }
}
```

## 6. 多层架构的优势

### ✅ 代码复用
- 多个 Mod 可以共享 `Ducky.EntranceMod.Common` 库
- 避免代码重复，提高维护性

### ✅ 模块化设计
- 业务逻辑与 Mod 入口分离
- 易于单元测试
- 清晰的依赖关系

### ✅ 团队协作
- 不同开发者可以独立开发不同层
- 减少代码冲突
- 便于代码审查

### ✅ 本地化共享
- 公共库可以定义共享的本地化键
- 所有使用该库的 Mod 自动获得翻译支持

## 7. 构建流程

SDK 会自动处理多项目依赖：

```bash
# 构建整个解决方案（推荐）
dotnet build Docky.Sdk.Sample.slnx

# 或单独构建主项目（会自动构建依赖的库项目）
dotnet build Ducky.EntranceMod/
```

**构建产物：**
- 主 Mod 程序集 + 公共库程序集会一起打包
- 资源文件从主项目的 `assets/` 目录获取
- SDK 库不会重复包含（因为设置了 `<ExcludeSdkLib>true</ExcludeSdkLib>`）

## 8. 启用 Mod

构建成功后，Mod 会自动部署到游戏目录：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── assets/
    ├── info.ini
    ├── lkeys.json
    └── Locales/
```

在游戏的 Mod 管理界面启用该 Mod 即可。

## 9. 扩展建议

### 创建更多公共库

对于复杂项目，可以创建多个公共库：

```
Ducky.EntranceMod/              # 主 Mod
Ducky.EntranceMod.Common/       # 通用代码
Ducky.EntranceMod.Gameplay/     # 游戏玩法逻辑
Ducky.EntranceMod.UI/           # UI 相关
```

## 10. 常见问题

### Q: 为什么要设置 `<ExcludeSdkLib>true</ExcludeSdkLib>`？

A: 避免将 Ducky.Sdk 的库文件重复打包到 Mod 输出目录。SDK 库已经存在于游戏中，不需要再次包含。

### Q: `<AssetsDir>` 必须设置吗？

A: 对于公共库项目，如果包含本地化键（LK.cs），则必须设置 `<AssetsDir>` 指向主项目的 assets 目录，这样 SDK 才能正确生成本地化元数据。

### Q: 可以有多个主 Mod 项目共享同一个公共库吗？

A: 可以！这正是多层架构的优势。多个 Mod 可以引用同一个公共库项目。

### Q: 公共库的本地化键会生成到哪里？

A: 会生成到 `<AssetsDir>` 指定的目录，即主项目的 `assets/` 目录下的 `lkeys.json` 文件中。

## 11. 相关资源

- [Ducky.SingleProject](../Ducky.SingleProject/README.md) - 单项目模式参考
- [Ducky.Localization](../Ducky.Localization/README.md) - 本地化系统详解
- [环境准备文档](../docs/Prequirement.md)

## 12. 总结

多层架构模式适合：
- ✅ 大型 Mod 项目
- ✅ 需要代码复用的场景
- ✅ 团队协作开发
- ✅ 系列 Mod 开发

如果你的 Mod 相对简单，建议先使用 [Ducky.SingleProject](../Ducky.SingleProject/README.md) 单项目模式。
