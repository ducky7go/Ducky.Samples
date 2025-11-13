<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../docs/Prequirement.md) | [日本語](../../en/docs/Prequirement_en.md) | [ドイツ語](../../de/docs/Prequirement_de.md) | [フランセ](../../fr/docs/Prequirement_fr.md) | [スペイン語](../../es-ES/docs/Prequirement_es.md) | [日本語](../../ja/docs/Prequirement_ja.md) | [한국어](Prequirement_ko.md) | [ポルトガル語](../../pt-PT/docs/Prequirement_pt.md) | [Русский](../../ru/docs/Prequirement_ru.md) | [繁体字中国語](../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# 開発環境準備(.NET / Ducky.Sdk 프로젝트)

이 문서에서는 이 리포지토리에 대한 .NET 개발 환경을 설정하는 데 필요한 최소 요구 사항 및 권장 구성에 대해 설명합니다.

## 개요

- 対象 .NET SDK：.NET 10(SDK 10.x)
- 필요한 글로벌 도구：
  - C# 스크립트를 동적으로 실행하는 데 사용됩니다.：'dotnet-script'
  - 프로그램 컬렉션 및/또는 패키징에 사용됩니다.：'dotnet-ilrepack'

## 시스템 요구 사항:

- 지원되는 운영 체제：Linux / macOS / Windows (배포 パッケージ 管理 または公式インストール スクリプトを사용하여 .NET SDK를 설치하십시오)
- 디스크 공간 및 메모리 권장：少なくとも2GBの使用可能なディスクおよび4GBのメモリ

## .NET SDK 10 インストール

公式インストール方法 またはパッケージ 管理者を使用 .NET 10 SDK 설치 예제：

```bash
# Linux(Microsoft 스크립트 사용)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --チャンネル 10.0
```

```bash
# macOS(홈브류 예제)
brew install --cask dotnet-sdk # 그런 다음 brew info를 통해 使用可能な버전을 확인하거나 dotnet-install 스크립트를 사용합니다.
```

```bash
# 윈도우(PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -채널 10.0
```

インストール後、SDKの경로를 PATHに追加하거나 터미널에서 전체 경로로 실행합니다.설치 확인：

```bash
dotnet --情報
```

출력에는 "10.10.x"로 시작하는 SDK 버전이 포함되어야 합니다.

## 글로벌 도구(필수)

- C# スクリプトを동的に実行(REPL/스크립팅된 빌드/위젯)

```bash
dotnet tool install -g dotnet-script
```

- 프로그램 컬렉션 및/패키지(단일 어셈블리를 생성하거나 타사 종속성을 병합하기 위해)

```bash
dotnet ツールインストール -g dotnet-ilrepack
```

설치가 완료되면 도구를 사용할 수 있는지 확인하세요：

```bash
dotnet-script --バージョン
ilrepack /?
```
