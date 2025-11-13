<!-- LANG_HEADER_START -->

\| [简体中文](Prequirement.md) | [English](../en/docs/Prequirement_en.md) | [Deutsch](../de/docs/Prequirement_de.md) | [Français](../fr/docs/Prequirement_fr.md) | [Español](../es-ES/docs/Prequirement_es.md) | [日本語](../ja/docs/Prequirement_ja.md) | [한국어](../ko/docs/Prequirement_ko.md) | [Português](../pt-PT/docs/Prequirement_pt.md) | [Русский](../ru/docs/Prequirement_ru.md) | [繁體中文](../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Development environment preparation (.NET / Ducky.Sdk project)

This document describes the minimum requirements and recommended configurations required to set up a .NET development environment for this repository.

## Overview

- Target .NET SDK：.NET 10（SDK 10.x）
- Necessary global tools：
  - Used to dynamically execute C# scripts：`dotnet-script`
  - Used for program collections and/or packaging：`dotnet-ilrepack`

## System requirements:

- Supported operating systems：Linux / macOS / Windows (please install the .NET SDK using the distribution package management or official installation script)
- Disk space and memory are recommended：At least 2 GB of free disk and 4 GB of memory

## Install .NET SDK 10

Install the .NET 10 SDK using the official installation method or the package manager, example：

```bash
# Linux (using Microsoft scripts)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel 10.0
```

```bash
# macOS (Homebrew example)
brew install --cask dotnet-sdk # Then check the available versions via brew info or use the dotnet-install script
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Channel 10.0
```

After installation, add the path of the SDK to the PATH, or run it with the full path in the terminal.Verify the installation：

```bash
dotnet --info
```

The output should contain the SDK version starting with "10." , for example, 10.0.x.

## Global Tools (Required)

- Dynamically execute C# scripts (REPL/scripted builds/widgets)

```bash
dotnet tool install -g dotnet-script
```

- Program collections and/packages (for generating a single assembly or merging third-party dependencies)

```bash
dotnet tool install -g dotnet-ilrepack
```

Once the installation is complete, confirm that the tool is available：

```bash
dotnet-script --version
ilrepack /?
```
