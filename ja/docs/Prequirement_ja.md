<!-- LANG_HEADER_START -->
| [简体中文](../../docs/Prequirement.md) | [English](../../en/docs/Prequirement_en.md) | [Deutsch](../../de/docs/Prequirement_de.md) | [Français](../../fr/docs/Prequirement_fr.md) | [Español](../../es-ES/docs/Prequirement_es.md) | [日本語](Prequirement_ja.md) | [한국어](../../ko/docs/Prequirement_ko.md) | [Português](../../pt-PT/docs/Prequirement_pt.md) | [Русский](../../ru/docs/Prequirement_ru.md) | [繁體中文](../../zh-TW/docs/Prequirement_zh.md) | 
<!-- LANG_HEADER_END -->

# 開発環境の準備(.NET / Ducky.Sdkプロジェクト)

このドキュメントでは、このリポジトリの .NET 開発環境をセットアップするために必要な最小要件と推奨構成について説明します。

## 概要

- ターゲット .NET SDK：.NET 10(SDK 10.x)
- 必要なグローバルツール：
  - C# スクリプトを動的に実行するために使用：'dotnet-script'
  - プログラムの収集やパッケージ化に使用：'dotnet-ilrepack'

## システム要件:

- サポートされているオペレーティングシステム：Linux / macOS / Windows (配布パッケージ管理または公式インストールスクリプトを使用して .NET SDK をインストールしてください)
- ディスク容量とメモリを推奨します：少なくとも 2 GB の空きディスクと 4 GB のメモリ

## .NET SDK 10 をインストールする

公式のインストール方法またはパッケージ マネージャーを使用して .NET 10 SDK をインストールする (例)：

```bash
# Linux (Microsoft スクリプトを使用)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --チャンネル10.0
```

```bash
# macOS (自作の例)
brew install --cask dotnet-sdk # 次に、brew info を介して利用可能なバージョンを確認するか、dotnet-install スクリプトを使用します
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -チャネル 10.0
```

インストール後、SDKのパスをPATHに追加するか、ターミナルでフルパスで実行します。インストールを確認する：

```bash
dotnet --info
```

出力には、「10.0.x」で始まるSDKバージョンが含まれている必要があります。

## グローバルツール(必須)

- C# スクリプト (REPL/スクリプト ビルド/ウィジェット) を動的に実行する

```bash
dotnet tool install -g dotnet-script
```

- プログラム コレクションおよび/またはパッケージ (単一のアセンブリの生成またはサードパーティの依存関係のマージ用)

```bash
dotnet tool install -g dotnet-ilrepack
```

インストールが完了したら、ツールが利用可能であることを確認します：

```bash
dotnet-script --version
ilrepack /?
```
