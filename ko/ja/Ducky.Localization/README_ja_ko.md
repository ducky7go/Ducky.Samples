<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.Localization/README.md) | [영어] (../../en/Ducky.Localization/README_en.md) | [도이치] (../../de/Ducky.Localization/README_de.md) | [프랑세] (../../fr/Ducky.Localization/README_fr.md) | [스페인어] (../../es-ES/Ducky.Localization/README_es.md) | [일본어] (README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization 샘플 MOD

간략한 설명

이 예제는 독립형 모드에서 현지화 키를 정의하고 구성하는 방법과 런타임에 사용할 수 있도록 번역을 자산에 넣는 방법을 보여줍니다.항목 및 키 정의는 ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1)(을)를 ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

시작하기 전에

먼저 개발 환경을 읽고 준비합니다.：['문서/Prequirement.md'] (docs/Prequirement.md:1)。

프로젝트 구조(포인트)

- ['닥키.로카라이제션/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1— 현지화된 문자열을 참조하는 방법을 보여주는 모드 항목입니다.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1— 정적으로 현지화된 키 정의(코드에서 유지 관리하는 것이 좋습니다).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1— 번역 CSV, 문서 기반 번역 및 설명과 같은 리소스를 포함합니다.

로카라이즈키(LK.cs)

- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) 정적 상수 조직 키(예:：UI 분류).
- 긴 텍스트는 '[TranslateFile("md)]]' 주석('assets/Locales/{lang}/')를 파일로 사용합니다.
- 지원되는 언어를 선언하려면 LanguageSupport("en","en","en-hant")]' 특성을 사용합니다(필요한 경우).

파일 번역 및 생성

- CSV 번역：'assets/로케르/{lang}.csv', 키와 값의 형태로.
- 문서 기반 번역：「자산/로케일/{lang}/', CSV 중앙값은 파일 이름(예:：'"ducky.singleproject.ui.longdescription.md"'。
- 'assets/lkeys.json' 및 'assets/keys.hash.txt'는 런타임 위치 지정 및 패키징 검사를 위해 컴파일 타임에 SDK의 MSBuild에 의해 생성되므로 수동으로 편집해서는 안 됩니다.

권장 워크플로

- 코드에서 키 추가 또는 변경(권장)：['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1)을 호출하고 SDK가 번역 메타데이터를 업데이트합니다.
- 또는 'assets/locales/를 직접 편집합니다.'{lang}.csv"을 입력하고 SDK가 변경 사항을 통합할 수 있도록 다시 컴파일합니다.

사용 사례:

```csharp
Ducky.Sdk.Localizations를 사용합니다.
var message = L.UI です。 ナイスウェルカムメッセージ; 런타임에 현재 언어의 번역으로 확인됩니다
```

빌드 및 실행

```bash
dotnet build Ducky.Localization/
# 또는 전체 솔루션을 빌드합니다.
dotnet build Docky.Sdk.Sample.slnx
```

보다

- '.csproj'가 '로 설정되어 있는지 확인합니다.<ModName>'를 일반 프로젝트 속성으로 바꿉니다(다른 프로젝트 예제 참조).
- 긴 텍스트의 경우 소스 코드 저장소의 유지 관리를 개선하기 위해 파일 기반 번역을 사용하는 것이 좋습니다.

끝내다
