# 开发环境准备（.NET / Ducky.Sdk 项目）

本文档说明为本仓库搭建 .NET 开发环境所需的最小要求与推荐配置。

## 概览

- 目标 .NET SDK：.NET 10（SDK 10.x）
- 必要全局工具：
  - 用于动态执行 C# 脚本：`dotnet-script`
  - 用于程序集合并/打包：`dotnet-ilrepack`

## 系统要求

- 支持的操作系统：Linux / macOS / Windows（请使用发行版包管理或官方安装脚本安装 .NET SDK）
- 推荐磁盘空间与内存：至少 2 GB 可用磁盘和 4 GB 内存

## 安装 .NET SDK 10

使用官方安装方式或包管理器安装 .NET 10 SDK，示例：

```bash
# Linux (使用 Microsoft 脚本)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel 10.0
```

```bash
# macOS (Homebrew 示例)
brew install --cask dotnet-sdk    # 然后通过 brew info 查看可用版本或使用 dotnet-install 脚本
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Channel 10.0
```

安装后将 SDK 的路径加入 PATH，或在终端使用完整路径运行。验证安装：

```bash
dotnet --info
```

输出应包含 SDK 版本以 "10." 开头，例如 10.0.x。

## 全局工具（必须）

- 动态执行 C# 脚本（REPL/脚本化构建/小工具）

```bash
dotnet tool install -g dotnet-script
```

- 程序集合并 / 打包（用于生成单一程序集或合并第三方依赖）

```bash
dotnet tool install -g dotnet-ilrepack
```

安装完成后，确认工具可用：

```bash
dotnet-script --version
ilrepack /?
```
