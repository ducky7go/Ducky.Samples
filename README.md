<!-- LANG_HEADER_START -->
| [简体中文](README.md) | 
<!-- LANG_HEADER_END -->

# Ducky SDK 示例项目集合

[![Build](https://github.com/ducky7go/Ducky.Samples/actions/workflows/build.yml/badge.svg)](https://github.com/ducky7go/Ducky.Samples/actions/workflows/build.yml)
[![.NET](https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[![NuGet](https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[![License](https://img.shields.io/github/license/ducky7go/Ducky.Samples?label=License)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[![Language](https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[![Target](https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[![Issues](https://img.shields.io/github/issues/ducky7go/Ducky.Samples)](https://github.com/ducky7go/Ducky.Samples/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/ducky7go/Ducky.Samples)](https://github.com/ducky7go/Ducky.Samples/pulls)
[![Last Commit](https://img.shields.io/github/last-commit/ducky7go/Ducky.Samples)](https://github.com/ducky7go/Ducky.Samples/commits)

本仓库包含多个用于演示 "Escape from Duckov" Mod 开发的示例项目，使用 [Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk) 框架。

## 📋 前置准备

开始之前，请确保您的开发环境已准备就绪：

👉 **[查看环境准备文档](docs/Prequirement.md)**

主要要求：
- .NET SDK 10.x
- 全局工具：`dotnet-script`、`dotnet-ilrepack`
- 支持的操作系统：Windows / Linux / macOS

## 🎯 快速开始

```bash
# 克隆仓库
git clone <repository-url>
cd Samples

# 构建所有示例
dotnet build Docky.Sdk.Sample.slnx

# 或构建单个示例
dotnet build Ducky.SingleProject/
```

## 📚 示例项目导览

本仓库按从易到难的顺序组织示例，建议按以下顺序学习：

### 1️⃣ 入门级 - 基础概念

#### [Ducky.SingleProject](Ducky.SingleProject/) - 最简单的 Mod
**难度：⭐**

最基础的单项目 Mod 示例，适合完全新手。

- ✅ 单项目结构
- ✅ Mod 生命周期（`ModEnabled` / `ModDisabled`）
- ✅ 基础日志记录
- ✅ 项目配置与构建

**学习要点：**
- 如何创建一个最小可运行的 Mod
- [`ModBehaviour`](Ducky.SingleProject/ModBehaviour.cs) 入口类的实现
- `.csproj` 文件的基本配置

**适合人群：** 刚接触 Ducky SDK 的开发者

👉 [查看详细教程](Ducky.SingleProject/README.md)

---

#### [Ducky.InstantKill](Ducky.InstantKill/) - 游戏事件处理
**难度：⭐⭐**

演示如何订阅游戏事件并实现简单的游戏逻辑修改。

- ✅ 游戏事件订阅（`Health.OnHurt`）
- ✅ 事件处理器实现
- ✅ 生命周期内的资源管理

**学习要点：**
- 如何监听游戏内事件
- 如何安全地订阅和取消订阅事件
- [`DamageInfo`](Ducky.InstantKill/ModBehaviour.cs) 等游戏 API 的使用

**适合人群：** 了解基础 Mod 结构，想要实现游戏逻辑的开发者

👉 [查看详细教程](Ducky.InstantKill/README.md)

---

### 2️⃣ 进阶级 - 核心功能

#### [Ducky.Localization](Ducky.Localization/) - 多语言本地化
**难度：⭐⭐⭐**

完整的本地化系统示例，包含多语言支持与文件型翻译。

- ✅ 本地化键定义（[`LK.cs`](Ducky.Localization/LK.cs)）
- ✅ CSV 翻译文件
- ✅ 文件型翻译（Markdown）
- ✅ 多语言支持（简中、英文）

**学习要点：**
- 如何组织本地化键
- `[LanguageSupport]` 和 `[TranslateFile]` 特性的使用
- SDK 自动生成的 `lkeys.json` 和 `keys.hash.txt`
- 运行时访问翻译字符串

**适合人群：** 需要开发多语言 Mod 的开发者

👉 [查看详细教程](Ducky.Localization/README.md)

---

#### [Ducky.BuffRegistration](Ducky.BuffRegistration/) - 自定义游戏实体
**难度：⭐⭐⭐

演示如何注册自定义 Buff（状态效果）并与游戏系统集成。

- ✅ 使用 `Contract.Buffs.RegisterBuff` 注册 Buff
- ✅ 场景事件处理（`SceneLoader.onAfterSceneInitialize`）
- ✅ Buff 实例创建与添加
- ✅ 本地化 Buff 名称和描述

**学习要点：**
- 如何扩展游戏的核心系统
- Contract API 的使用模式
- 场景生命周期管理
- 游戏实体的配置与注册

**适合人群：** 想要添加自定义游戏内容的开发者

👉 [查看详细教程](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget](Ducky.PackageFromNuget/) - 第三方依赖管理
**难度：⭐⭐⭐**

演示如何在 Mod 中使用 NuGet 包（以 YamlDotNet 为例）。

- ✅ 引入第三方 NuGet 包
- ✅ 读取和解析资源文件
- ✅ 依赖打包与部署

**学习要点：**
- 如何在 Mod 中使用外部库
- 资源文件的访问路径
- SDK 的依赖处理机制

**适合人群：** 需要使用第三方库扩展功能的开发者

---

### 3️⃣ 高级级 - 复杂模式

#### [Ducky.EntranceMod](Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/) - 多层架构
**难度：⭐⭐⭐⭐**

演示如何将 Mod 拆分为多层架构，实现代码复用。

- ✅ 主 Mod 项目与公共库分离
- ✅ `<ExcludeSdkLib>` 和 `<IsModLib>` 配置
- ✅ 跨项目共享本地化键
- ✅ 项目引用管理

**学习要点：**
- 多项目解决方案的组织
- 如何创建可复用的 Mod 库
- 资源文件的跨项目共享
- 适合大型 Mod 的架构设计

**适合人群：** 开发大型或系列 Mod 的团队

---

#### [Ducky.TryHarmony](Ducky.TryHarmony/) - 运行时代码注入
**难度：⭐⭐⭐⭐⭐**

使用 HarmonyLib 在运行时修补游戏代码，实现最深层次的游戏修改。

- ✅ Harmony 补丁系统
- ✅ 方法前缀/后缀/替换
- ✅ 补丁注册与清理
- ✅ 游戏内部 API 访问

**学习要点：**
- HarmonyLib 的基本使用
- 如何编写 Prefix/Postfix 补丁
- 运行时代码修改的最佳实践
- 补丁的生命周期管理

**示例：** [`SaveFilePatch`](Ducky.TryHarmony/SaveFilePatch.cs) 演示如何拦截存档操作

**适合人群：** 需要深度修改游戏逻辑的高级开发者

⚠️ **注意：** Harmony 补丁功能强大但需谨慎使用，错误的补丁可能导致游戏崩溃

👉 [查看详细教程](Ducky.TryHarmony/README.md)

---

## 🏗️ 项目架构

所有示例项目遵循以下核心约定：

### 项目配置（必需）

```xml
<PropertyGroup>
  <TargetFramework>netstandard2.1</TargetFramework>
  <Nullable>enable</Nullable>
  <LangVersion>preview</LangVersion>
  <ImplicitUsings>true</ImplicitUsings>
  <ModName>YourModName</ModName>
</PropertyGroup>
```

### Mod 入口点

```csharp
public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        // Mod 启用时的初始化逻辑
    }

    protected override void ModDisabled()
    {
        // Mod 禁用时的清理逻辑
    }
}
```

### 资源文件结构

```
assets/
├── info.ini              # Mod 元信息
├── description.md        # 详细描述（可选）
├── preview.png           # 预览图（可选）
├── lkeys.json            # 本地化清单（自动生成）
├── keys.hash.txt         # 校验哈希（自动生成）
└── Locales/
    ├── zh.csv            # 简体中文翻译
    ├── en.csv            # 英文翻译
    └── zh/               # 文件型翻译
        └── *.md
```
## 📖 学习路径建议

### 新手路径
1. [Ducky.SingleProject](Ducky.SingleProject/) - 理解基础结构
2. [Ducky.InstantKill](Ducky.InstantKill/) - 学习事件处理
3. [Ducky.Localization](Ducky.Localization/) - 掌握本地化
4. [Ducky.BuffRegistration](Ducky.BuffRegistration/) - 扩展游戏内容

### 进阶路径
1. [Ducky.PackageFromNuget](Ducky.PackageFromNuget/) - 使用第三方库
2. [Ducky.EntranceMod](Ducky.EntranceMod/) - 多层架构设计
3. [Ducky.TryHarmony](Ducky.TryHarmony/) - 运行时代码注入

## 🛠️ 构建与部署

### 构建命令

```bash
# 构建所有项目
dotnet build Docky.Sdk.Sample.slnx

# 构建单个项目
dotnet build Ducky.SingleProject/

# 清理构建
dotnet clean
```

### 自动部署

SDK 在构建时会自动将 Mod 部署到游戏目录（需配置 `Local.props` 或在 `.csproj` 中设置 `<SteamFolder>` / `<DuckovFolder>`）：

```xml
<PropertyGroup>
  <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 项目规范

- **解决方案格式**：使用新的 `.slnx` XML 格式
- **代码分析**：SDK 内置分析器会验证项目结构
- **自动生成**：本地化元数据会在编译时自动生成

## 🔗 相关资源

- [Ducky.Sdk NuGet 包](https://www.nuget.org/packages/Ducky.Sdk)
- [游戏 Steam 页面](https://store.steampowered.com/app/XXXXX)（替换为实际链接）
- [开发者文档](docs/)

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来改进示例项目！

## 📄 许可证

本项目采用 [LICENSE](LICENSE) 中指定的许可证。

---

**祝您开发愉快！🎮**
