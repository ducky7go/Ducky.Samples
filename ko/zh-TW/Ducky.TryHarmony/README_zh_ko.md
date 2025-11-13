<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.TryHarmony/README.md) | [영어] (../../en/Ducky.TryHarmony/README_en.md) | [도이치] (../../de/Ducky.TryHarmony/README_de.md) | [프랑세] (../../fr/Ducky.TryHarmony/README_fr.md) | [스페인어] (../../es-ES/Ducky.TryHarmony/README_es.md) | [일본어] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [중국어 번체자] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony 샘플 모드

간략하게 설명

이 예제는 HarmonyLib를 사용하여 런타임에 게임 코드용 모드를 패치하는 방법을 보여줍니다.이 예제에는 저장 작업이 지속적으로 실패하도록 하는 효과(SaveFilePatch)가 있는 간단한 Harmony 패치(저장 패치)가 포함되어 있습니다.엔트리 및 패치 등록은 ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1)에서 구현됩니다.

시작하기 전에 프론트엔드 환경 요구 사항이 준비되었는지 확인합니다： [환경 준비](.. /docs/Prequirement.md)를 사용합니다.

1. 프로젝트 소개

이 카탈로그('Ducky. TryHarmony/')는 Harmony 패치 모드를 보여줍니다.：ModEnabled에서 Harmony의 PatchAll을 호출하여 패치를 등록하고 ModDisabled에서 패치를 취소합니다.주요 실현에서 만나요：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- 프로젝트 파일：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. csproj에서 Harmony 활성화

Harmony 패치를 사용하려면 'Ducky.TryHarmony.csproj'에서 IncludeHarmony 속성을 사용하도록 설정합니다.예를 들어：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <ModName>덕키.트라이하모니</ModName>
    <IncludeHarmony>참</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. 파일 패치 저장

'SaveFilePatch'의 주요 기능은 저장(게임 저장) 작업을 지속적으로 실패시켜 패치 효과와 오류 처리 프로세스를 더 쉽게 시연할 수 있도록 하는 것입니다.패치 예제는 저장 관련 메서드를 가로채고 실패를 반환합니다( ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1) 참조).

4. 실행 및 테스트

- 프로젝트 빌드：

```bash
dotnet 빌드 Ducky.TryHarmony/
```

- 모드 열기(빌드를 게임의 모드 카탈로그에 배포하고 게임 내에서 열기)
- 게임 내에서 저장 내용을 저장하려고 하면 패치가 활성화되었음을 나타내는 "저장 실패"가 표시됩니다.

5. 일반적인 예방 조치

- 'IncludeHarmony'가 'true'로 설정되어 있는지 확인하지 않으면 Harmony 관련 코드가 제대로 작동하지 않습니다.
- 패치를 디버깅할 때 'ModBehaviour'('Ducky.Sdk.Logging.Log' 사용)에 로그를 추가하여 'PatchAll()'/'UnpatchAll()'이 호출되었는지 확인할 수 있습니다.
