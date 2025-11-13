<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.Localization/README.md) | [日本語](../../en/Ducky.Localization/README_en.md) | [ドイツ語](../../de/Ducky.Localization/README_de.md) | [フランセ](../../fr/Ducky.Localization/README_fr.md) | [スペイン語](../../es-ES/Ducky.Localization/README_es.md) | [日本語](../../ja/Ducky.Localization/README_ja.md) | [한국어](README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.Localization/README_pt.md) | [Русский](../../ru/Ducky.Localization/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization サンプル モード

간략한 설명

この例は、独立型モードで、現地化、デバイスを定義、構成する方法と런타임 사용을 위해 번역을 자산에 넣는 방법을 보여줍니다.항목 およびキー 정의는 ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1)を['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

시작하기 전에

먼저 개발 환경을 읽고 준비하십시오.：['문서/Prequirement.md'] (docs/Prequirement.md:1)。

프로젝트 구조(요점)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — 현지화된 문자열을 참조하는 방법을 보여주는 모드 항목입니다.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) — 정적 현지화된 키 정의(코드에서 유지 관리하는 것이 좋습니다).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1) - 翻訳 CSV, 문서 기반 번역 및 설명과 같은 리소스를 포함합니다.

현지화 키(LK.cs)

- ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) 정적 상수 조직 키(예:：UI 分類)。
- 긴 텍스트는 '[TranslateFile("md)]]' 주석('assets/Locales/{lang}/')를 사용합니다.
- 지원되는 언어를 선언하려면 [LanguageSupport("en","en","zh-hant")]' 특성을 사용합니다(원하는 경우).

파일 번역 및 생성

- CSV 翻訳：'자산/로케일/{lang}.csv', 키, 값 형식.
- 문서 기반 번역：'assets/locales/{lang}/', CSV 중앙값은 파일 이름으로 참조됩니다(예:：'"ducky.singleproject.ui.longdescription.md"'。
- 'assets/lkeys.json' および'assets/keys.hash.txt'は런타임 位置指定および패키징 검사를 위해 컴파일 타임에 SDKのMSBuild에 의해 생성되므로 수동으로 편집하지 마십시오.

권장 워크플로

- 코드에서 키 추가 또는 수정(권장)：['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)을 컴파일하고 컴파일하면 SDK가 번역 메타데이터를 更新합니다.
- または'assets/locales/를 직접 편집합니다.'{lang}.csv'を入力하고 SDKが変更사항을 통합할 수 있도록 다시 컴파일합니다.

사용 예

```csharp
Ducky.Sdk.Localizations 使用;
var message = L.UIです。 NiceWelcomeMessageです。 런타임에 현재 언어의 번역으로 확인됩니다.
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
