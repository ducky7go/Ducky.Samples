<!-- LANG_HEADER_START -->

\| [Chinese Simplified] (../../docs/Prequirement.md) | [English] (../../en/docs/Prequirement_en.md) | [Deutsch] (../../de/docs/Prequirement_de.md) | [Français] (../../fr/docs/Prequirement_fr.md) | [Español] (../../es-ES/docs/Prequirement_es.md) | [Japanese] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [Português] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [Traditional Chinese] (Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Development Environment Preparation (.NET / Ducky.Sdk Project)

This document describes the minimum requirements and recommended configurations required to set up a .NET development environment for this repository.

## Overview

- Target .NET SDK：.NET 10（SDK 10.x）
- Required global tools：
  - Used to dynamically execute C# documents：`dotnet-script`
  - Used for program collections and/or packaging：`dotnet-ilrepack`

## System requirements

- Supported operating systems：Linux / macOS / Windows (please use the distribution package management or official installation script to install the .NET SDK)
- Recommended disk space and memory：At least 2 GB of free disk and 4 GB of memory

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

The output should include an SDK version that starts with "10.", such as 10.0.x.

## Global Tools (Required)

- Dynamically execute C# scripts (REPL/Documented Build/Widgets)

```bash
dotnet tool install -g dotnet-script
```

- Program collection and/package (used to generate a single assembly or merge third-party dependencies)

```bash
dotnet tool install -g dotnet-ilrepack
```

Once the installation is complete, confirm that the tool is available：

```bash
dotnet-script --version
ilrepack /?
```
