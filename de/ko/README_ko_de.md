<!-- LANG_HEADER_START -->

\| [简体中文](../README.md) | [English](../en/README_en.md) | [Deutsch](../de/README_de.md) | [Français](../fr/README_fr.md) | [Español](../es-ES/README_es.md) | [日本語](../ja/README_ja.md) | [한국어](README_ko.md) | [Português](../pt-PT/README_pt.md) | [Русский](../ru/README_ru.md) | [繁體中文](../zh-TW/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky SDK 샘플 프로젝트 컬렉션

[! [빌드] (https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.그물] (https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [너겟] (https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [라이센스] (https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [플랫폼] (https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [언어] (https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! [대상] (https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [문제] (https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [풀 리퀘스트] (https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [마지막 커밋] (https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

이 저장소에는 [Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk) 프레임.

## 📋 준비

시작하기 전에 개발 환경이 준비되었는지 확인하십시오：

👉 [환경 준비 문서 보기](docs/Prequirement.md)\*\*

주요 요구 사항:：

- .NET SDK 10.x
- 글로벌 도구：'dotnet-script'、'dotnet-ilrepack'
- 지원되는 운영 체제：윈도우 / 리눅스 / 맥OS

## 🎯 빠르게 시작하기

```bash
# 저장소 복제
자식 복제 <repository-url>
cd 샘플

# 모든 예제 빌드
dotnet build Docky.Sdk.Sample.slnx

# 또는 단일 예제 작성
dotnet 빌드 Ducky.SingleProject/
```

## 📚 샘플 프로젝트 둘러보기

이 저장소는 쉬운 것부터 어려운 것까지 예제를 정리하고 있으며, 다음 순서로 공부하는 것이 좋습니다：

### 1️⃣ 초급 수준 - 기본 개념

#### [Ducky.SingleProject] (Ducky.SingleProject/- 가장 간단한 모드

**어려움：⭐**

완전한 초보자에게 적합한 가장 기본적인 단일 아이템 모드 예입니다.

- ✅ 단일 항목 구조
- ✅ 모드 수명 주기 ('ModEnabled' / 'ModDisabled')
- ✅ 기본 로깅
- ✅ 프로젝트 구성 및 건설

배워야 할 요점：\*\*

- 실행 가능한 최소 모드를 만드는 방법
- ['모드 행동'] (Ducky.SingleProject/ModBehaviour.cs) 수신 클래스
- '.csproj' 파일의 기본 구성

**사람들에게 적합：** Ducky SDK를 처음 사용하는 개발자

👉 [자세한 튜토리얼 보기](Ducky.SingleProject/README.md)

---

#### [덕키.인스턴트 킬] (Ducky.InstantKill/- 게임 이벤트 처리

**어려움：⭐⭐**

게임 이벤트를 구독하고 간단한 게임 로직 수정을 구현하는 방법을 보여줍니다.

- ✅ 게임 이벤트 구독 ('Health.OnHurt')
- ✅ 이벤트 처리기 구현
- ✅ 수명 주기 전반에 걸친 리소스 관리

배워야 할 요점：\*\*

- 게임 내 이벤트를 듣는 방법
- 이벤트를 안전하게 구독 및 구독 취소하는 방법
- ['데미지정보'] (Ducky.InstantKill/ModBehaviour.cs) 및 기타 게임 API

**사람들에게 적합：** 기본 모드 구조를 이해하고 게임 로직을 구현하려는 개발자

👉 [자세한 튜토리얼 보기](Ducky.InstantKill/README.md)

---

### 2️⃣ 고급 레벨 - 핵심 기능

#### [Ducky.현지화] (Ducky.Localization/- 다국어 현지화

**어려움：⭐⭐⭐**

다국어 지원 및 파일 기반 번역을 갖춘 현지화 시스템의 완전한 예입니다.

- ✅ 현지화된 키 정의(['LK.cs'](Ducky.Localization/LK.cs)）
- ✅ CSV 번역 파일
- ✅ 문서 번역(Markdown)
- ✅ 다국어 지원(중국어 간체 및 영어)

배워야 할 요점：\*\*

- 현지화 키를 구성하는 방법
- '[LanguageSupport]' 및 '[TranslateFile]' 기능 사용
- SDK 자동 생성 'lkeys.json' 및 'keys.hash.txt'
- 번역 문자열에 대한 런타임 액세스

**사람들에게 적합：** 다국어 모드 개발이 필요한 개발자

👉 [자세한 튜토리얼 보기](Ducky.Localization/README.md)

---

#### [Ducky.Buff등록] (Ducky.BuffRegistration/) - 사용자 지정 게임 개체

\*\*어려움：⭐⭐⭐

커스텀 버프를 등록하고 게임 시스템과 통합하는 방법을 보여줍니다.

- ✅ 'Contract.Buffs.RegisterBuff'를 사용하여 버프를 등록합니다.
- ✅ 장면 이벤트 처리('SceneLoader.onAfterSceneInitialize')
- ✅ 버프 인스턴스 생성 및 추가
- ✅ 버프 이름 및 설명 현지화

배워야 할 요점：\*\*

- 게임의 핵심 시스템을 확장하는 방법
- 계약 API의 사용 패턴
- 시나리오 수명 주기 관리
- 게임 엔터티의 구성 및 등록

**사람들에게 적합：** 맞춤형 게임 콘텐츠를 추가하려는 개발자

👉 [자세한 튜토리얼 보기](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/- 타사 종속성 관리

**어려움：⭐⭐⭐**

모드에서 NuGet 패키지를 사용하는 방법을 보여 줍니다(YamlDotNet을 예로 사용).

- ✅ 타사 NuGet 패키지 소개
- ✅ 리소스 파일 읽기 및 구문 분석
- ✅ 종속 패키징 및 배포

배워야 할 요점：\*\*

- 모드에서 외부 라이브러리를 사용하는 방법
- 리소스 파일의 액세스 경로
- SDK의 종속성 처리 메커니즘

**사람들에게 적합：** 타사 라이브러리로 기능을 확장해야 하는 개발자

---

### 3️⃣ 고급 - 복합 모드

#### [Ducky.EntranceMod] (Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/- 다계층 아키텍처

**어려움：⭐⭐⭐⭐**

코드 재사용을 위해 모드를 다중 계층 아키텍처로 분할하는 방법을 보여줍니다.

- ✅ 메인 모드 프로젝트는 공공 도서관과 분리되어 있습니다.
- ✅ \\`<ExcludeSdkLib>' 및 '<IsModLib>' 구성
- ✅ 프로젝트 간에 현지화 키 공유
- ✅ 프로젝트 참조 관리

배워야 할 요점：\*\*

- 다중 프로젝트 솔루션 구성
- 재사용 가능한 모드 라이브러리를 만드는 방법
- 리소스 파일의 프로젝트 간 공유
- 대형 모드를 위한 아키텍처 설계

**사람들에게 적합：** 대규모 또는 시리즈 모드를 개발하는 팀

---

#### [덕키.트라이 하모니] (Ducky.TryHarmony/- 런타임 코드 삽입

**어려움：⭐⭐⭐⭐⭐**

HarmonyLib를 사용하여 가장 심층적인 게임 수정을 위해 런타임에 게임 코드를 패치합니다.

- ✅ 하모니 패치 시스템
- ✅ 메서드 접두사/접미사/바꾸기
- ✅ 패치 등록 및 정리
- ✅ 게임 내 API 액세스

배워야 할 요점：\*\*

- HarmonyLib의 기본 사용
- 접두사/접미사 패치를 작성하는 방법
- 런타임 코드 수정에 대한 모범 사례
- 패치의 수명 주기 관리

**본보기：** ['파일 패치 저장'](Ducky.TryHarmony/SaveFilePatch.cs아카이브 작업을 가로채는 방법을 보여줍니다.

**사람들에게 적합：** 게임 로직을 심층적으로 수정해야 하는 고급 개발자

⚠️ **메모.：** 하모니 패치는 강력하지만 주의해서 사용해야 하며, 잘못된 패치로 인해 게임이 충돌할 수 있습니다

👉 [자세한 튜토리얼 보기](Ducky.TryHarmony/README.md)

---

## 🏗️ 프로젝트 아키텍처

모든 샘플 프로젝트는 다음과 같은 핵심 규칙을 따릅니다：

### 프로젝트 구성(필수)

```xml
<PropertyGroup>
  <TargetFramework>넷스탠다드2.1</TargetFramework>
  <Nullable>사용</Nullable>
  <LangVersion>미리 보기</LangVersion>
  <ImplicitUsings>참</ImplicitUsings>
  <ModName>YourModName</ModName>
</PropertyGroup>
```

### 모드 진입점

```csharp
공개 클래스 ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        모드가 활성화되었을 때의 초기화 로직
    }

    protected 재정의 void ModDisabled()
    {
        모드가 비활성화된 경우 정리 논리
    }
}
```

### 리소스 파일 구조

```
자산/
├── info.ini # 모드 메타 정보
├── description.md # 상세 설명(선택)
├── preview.png # 미리보기(선택사항)
├── lkeys.json # 현지화 체크리스트(자동 생성)
├── keys.hash.txt # 유효성 검사 해시(자동 생성)
└── 로케일/
    ├── zh.csv # 중국어 간체 번역
    ├── en.csv # 영어 번역
    └── ko/ # 문서 기반 번역
        └── *.md
```

## 📖 학습 경로 권장 사항

### 초급 경로

1. [Ducky.SingleProject] (Ducky.SingleProject/- 인프라 이해
2. [덕키.인스턴트 킬] (Ducky.InstantKill/- 사고 처리 배우기
3. [Ducky.현지화] (Ducky.Localization/- 마스터 현지화
4. [Ducky.Buff등록] (Ducky.BuffRegistration/) - 게임 콘텐츠 확장

### 고급 경로

1. [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/) - 타사 라이브러리 사용
2. [Ducky.EntranceMod] (Ducky.EntranceMod/- 다층 아키텍처 설계
3. [덕키.트라이 하모니] (Ducky.TryHarmony/- 런타임 코드 삽입

## 🛠️ 빌드 및 배포

### 빌드 명령

```bash
# 모든 프로젝트 빌드
dotnet build Docky.Sdk.Sample.slnx

# 단일 프로젝트 빌드
dotnet 빌드 Ducky.SingleProject/

# 빌드 정리
dotnet 정리
```

### 자동화된 배포

SDK는 빌드 시 게임 디렉터리에 모드를 자동으로 배포합니다('local.props'를 구성하거나 '.csproj'를 설정해야 함).<SteamFolder>`/`<DuckovFolder>\\`）：

```xml
<PropertyGroup>
  <SteamFolder>C:\Programme (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 프로젝트 사양

- **솔루션 형식**：새로운 '.slnx' XML 형식 사용
- **코드 분석**：SDK 내장 분석기는 프로젝트 구조의 유효성을 검사합니다.
- **자동 생성**：현지화된 메타데이터는 컴파일 타임에 자동으로 생성됩니다.

## 🔗 관련 자료

- [Ducky.Sdk NuGet 패키지] (https://www.nuget.org/packages/Ducky.Sdk)
- [게임 스팀 페이지] (https://store.steampowered.com/app/XXXXX(실제 링크로 대체)
- [개발자 문서] (docs/)

## 🤝 기여 지침

샘플 프로젝트를 개선하기 위해 문제 및 풀 리퀘스트를 자유롭게 제출하세요!

## 📄 허락하다.

이 프로젝트는 [LICENSE(라이센스)를 클릭합니다.

---

**즐거운 개발 되세요!🎮**
