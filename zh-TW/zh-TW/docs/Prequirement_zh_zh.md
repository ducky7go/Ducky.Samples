<!-- LANG_HEADER_START -->

\| [簡體中文](../../docs/Prequirement.md) | [English](../../en/docs/Prequirement_en.md) | [Deutsch](../../de/docs/Prequirement_de.md) | [Français](../../fr/docs/Prequirement_fr.md) | [Español](../../es-ES/docs/Prequirement_es.md) | [日本語](../../ja/docs/Prequirement_ja.md) | [한국어](../../ko/docs/Prequirement_ko.md) | [Português](../../pt-PT/docs/Prequirement_pt.md) | [Русский](../../ru/docs/Prequirement_ru.md) | [繁體中文](Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# 開發環境準備（.NET / Ducky.Sdk 專案）

本文檔說明為本倉庫搭建 .NET 開發環境所需的最小要求與推薦配置。

## 概覽

- 目標 .NET SDK：.NET 10（SDK 10.x）
- 必要全域工具：
  - 用於動態執行 C# 文稿：`dotnet-script`
  - 用於程式集合並/打包：`dotnet-ilrepack`

## 系統要求

- 支援的作業系統：Linux / macOS / Windows（請使用發行版包管理或官方安裝腳本安裝 .NET SDK）
- 推薦磁碟空間與記憶體：至少 2 GB 可用磁碟和 4 GB 記憶體

## 安裝 .NET SDK 10

使用官方安裝方式或包管理器安裝 .NET 10 SDK，示例：

```bash
# Linux （使用 Microsoft 腳本）
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --channel 10.0
```

```bash
# macOS （Homebrew 示例）
brew install --cask dotnet-sdk # 然後通過 brew info 查看可用版本或使用 dotnet-install 腳本
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Channel 10.0
```

安裝後將 SDK 的路徑加入 PATH，或在終端使用完整路徑運行。驗證安裝：

```bash
dotnet --info
```

輸出應包含 SDK 版本以 「10.」 開頭，例如 10.0.x。

## 全域工具（必須）

- 動態執行 C# 文稿（REPL/文稿化構建/小工具）

```bash
dotnet tool install -g dotnet-script
```

- 程式集合並 / 打包（用於產生單一程式集或合併第三方依賴）

```bash
dotnet tool install -g dotnet-ilrepack
```

安裝完成後，確認工具可用：

```bash
dotnet-script --version
ilrepack /?
```
