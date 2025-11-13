<!-- LANG_HEADER_START -->

\| [簡體中文](../../docs/Prequirement.md) | [English](../../en/docs/Prequirement_en.md) | [Deutsch](../../de/docs/Prequirement_de.md) | [Français](../../fr/docs/Prequirement_fr.md) | [Español](../../es-ES/docs/Prequirement_es.md) | [日本語](../../ja/docs/Prequirement_ja.md) | [한국어](Prequirement_ko.md) | [Português](../../pt-PT/docs/Prequirement_pt.md) | [Русский](../../ru/docs/Prequirement_ru.md) | [繁體中文](../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# 개발 환경 준비(.NET / Ducky.Sdk 프로젝트)

이 문서에서는 이 리포지토리에 대한 .NET 개발 환경을 설정하는 데 필요한 최소 요구 사항 및 권장 구성에 대해 설명합니다.

## 개요

- 대상 .NET SDK：.NET 10(SDK 10.x)
- 필요한 글로벌 도구：
  - C# 스크립트를 동적으로 실행하는 데 사용됩니다.：'dotnet-script'
  - 프로그램 컬렉션 및/또는 패키징에 사용됩니다.：'dotnet-ilrepack'

## 시스템 요구 사항:

- 지원되는 운영 체제：Linux / macOS / Windows (배포 패키지 관리 또는 공식 설치 스크립트를 사용하여 .NET SDK를 설치하십시오)
- 디스크 공간 및 메모리 권장：최소 2GB의 사용 가능한 디스크 및 4GB의 메모리

## .NET SDK 10 설치

공식 설치 방법 또는 패키지 관리자를 사용하여 .NET 10 SDK 설치 예제：

```bash
# Linux(Microsoft 스크립트 사용)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --채널 10.0
```

```bash
# macOS(홈브류 예제)
brew install --cask dotnet-sdk # 그런 다음 brew info를 통해 사용 가능한 버전을 확인하거나 dotnet-install 스크립트를 사용합니다.
```

```bash
# 윈도우(PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -채널 10.0
```

설치 후 SDK의 경로를 PATH에 추가하거나 터미널에서 전체 경로로 실행합니다.설치 확인：

```bash
dotnet --정보
```

출력에는 "10.10.x"로 시작하는 SDK 버전이 포함되어야 합니다.

## 글로벌 도구(필수)

- C# 스크립트를 동적으로 실행(REPL/스크립팅된 빌드/위젯)

```bash
dotnet tool install -g dotnet-script
```

- 프로그램 컬렉션 및/패키지(단일 어셈블리를 생성하거나 타사 종속성을 병합하기 위해)

```bash
dotnet 도구 설치 -g dotnet-ilrepack
```

설치가 완료되면 도구를 사용할 수 있는지 확인하세요：

```bash
dotnet-script --버전
ilrepack /?
```
