<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.Localization/README.md) | [English](../../en/Ducky.Localization/README_en.md) | [Deutsch](../../de/Ducky.Localization/README_de.md) | [Français](../../fr/Ducky.Localization/README_fr.md) | [Español](../../es-ES/Ducky.Localization/README_es.md) | [日本語](../../ja/Ducky.Localization/README_ja.md) | [한국어](README_ko.md) | [Português](../../pt-PT/Ducky.Localization/README_pt.md) | [Русский](../../ru/Ducky.Localization/README_ru.md) | [繁體中文](../../zh-TW/Ducky.Localization/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.Localization 샘플 모드

간략한 설명

이 예제는 독립형 모드에서 현지화 키를 정의하고 구성하는 방법과 런타임 사용을 위해 번역을 자산에 넣는 방법을 보여줍니다.항목 및 키 정의는 ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1)를 ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

시작하기 전에

먼저 개발 환경을 읽고 준비하십시오.：['문서/Prequirement.md'] (docs/Prequirement.md:1)。

프로젝트 구조(요점)

- ['Ducky.Localization/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — 현지화된 문자열을 참조하는 방법을 보여주는 모드 항목입니다.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) — 정적 현지화된 키 정의(코드에서 유지 관리하는 것이 좋습니다).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1) - 번역 CSV, 문서 기반 번역 및 설명과 같은 리소스를 포함합니다.

현지화 키(LK.cs)

- ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) 정적 상수 조직 키(예:：UI 분류).
- 긴 텍스트는 '[TranslateFile("md)]]' 주석('assets/Locales/{lang}/')를 사용합니다.
- 지원되는 언어를 선언하려면 [LanguageSupport("en","en","zh-hant")]' 특성을 사용합니다(원하는 경우).

파일 번역 및 생성

- CSV 번역：'자산/로케일/{lang}.csv', 키, 값 형식.
- 문서 기반 번역：'assets/locales/{lang}/', CSV 중앙값은 파일 이름으로 참조됩니다(예:：'"ducky.singleproject.ui.longdescription.md"'。
- 'assets/lkeys.json' 및 'assets/keys.hash.txt'는 런타임 위치 지정 및 패키징 검사를 위해 컴파일 타임에 SDK의 MSBuild에 의해 생성되므로 수동으로 편집하지 마십시오.

권장 워크플로

- 코드에서 키 추가 또는 수정(권장)：['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)을 컴파일하고 컴파일하면 SDK가 번역 메타데이터를 업데이트합니다.
- 또는 'assets/locales/를 직접 편집합니다.'{lang}.csv'을 입력하고 SDK가 변경 사항을 통합할 수 있도록 다시 컴파일합니다.

사용 예

```csharp
Ducky.Sdk.Localizations 사용;
var message = L.UI입니다. NiceWelcomeMessage입니다. 런타임에 현재 언어의 번역으로 확인됩니다.
```

빌드 및 실행

```bash
dotnet build Ducky.Localization/
# 또는 전체 솔루션을 빌드합니다.
dotnet build Docky.Sdk.Sample.slnx
```

말

- '.csproj'가 '<ModName>'를 일반 프로젝트 속성으로 바꿉니다(다른 예제 프로젝트 참조).
- 긴 텍스트는 소스 코드 저장소에서 더 나은 유지 관리를 위해 파일 기반 번역을 사용하는 것이 좋습니다.

끝내다
