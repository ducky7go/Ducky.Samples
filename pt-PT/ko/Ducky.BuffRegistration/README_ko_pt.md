<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.BuffRegistration/README.md) | [English](../../en/Ducky.BuffRegistration/README_en.md) | [Deutsch](../../de/Ducky.BuffRegistration/README_de.md) | [Français](../../fr/Ducky.BuffRegistration/README_fr.md) | [Español](../../es-ES/Ducky.BuffRegistration/README_es.md) | [日本語](../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어](README_ko.md) | [Português](../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский](../../ru/Ducky.BuffRegistration/README_ru.md) | [繁體中文](../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Buff등록 샘플 모드

간략한 설명

이 예제는 Ducky.Sdk 를 사용하여 현지화된 키 및 에셋 레이아웃을 포함한 커스텀 버프를 등록하는 방법을 보여줍니다.항목 및 구현은 ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

시작하기 전에 사전 프로덕션 환경 요구 사항이 준비되었는지 확인합니다. [환경 준비](../docs/Prequirement.md)

1. 프로젝트 소개

이 디렉터리(['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1단일 프로젝트 모드에서 Contract.Buffs 를 통해 버프를 등록하는 패턴을 보여줍니다.이 프로젝트에는 현지화 키도 포함되어 있습니다(['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. 프로젝트 초기화

- 리포지토리를 복제하고 'Ducky.BuffRegistration/'을 엽니다.
- 최소한 .csproj를 포함하는 것이 좋습니다.：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.Buff등록</ModName>
  </PropertyGroup>
</Project>
```

3. Ducky.Sdk 설치 및 구성

NuGet을 통해 SDK를 추가하는 것이 좋습니다：

```bash
dotnet 패키지 추가 Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>모두</PrivateAssets>
    <IncludeAssets>런타임; 체격; 원주민; content파일; 분석기; 빌드전이적</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. 커스텀 버프 등록(예)

Contract.Buffs.RegisterBuff 를 사용하여 버프를 등록하고 콜백에서 표시 이름, 설명, 아이콘 및 수명을 설정합니다.본보기：

```csharp
Ducky.Sdk 사용;

공개 클래스 ModBehaviour : ModBehaviourBase
{
    개인 int _buffId;

    protected 재정의 void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(버프 =>
        {
            광. SetDisplayName(LK. UI. DoNothingBuffName)을 사용합니다.
                . SetDescription(LK. UI. DoNothingBuffDescription)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(true)
                . TotalLifeTime 설정(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        장면 초기화 듣기：기지에 들어갈 때 주인공에게 이 버프를 자동으로 부여합니다(구현은 ModBehaviour 참조).
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    protected 재정의 void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter;
            if (메인 != null)
            {
                베이스 씬에 들어갈 때 등록된 버프 인스턴스를 만들고 추가합니다
                주요한. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. 지역화

이 예제에서는 ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。번역 파일은 일반적으로 'assets/locales/'(소스 디렉토리에서 볼 수 있음)에 있지만 주의하십시오.：번역 CSV, 번역 메타데이터('assets/lkeys.json') 및 유효성 검사 파일('assets/keys.hash.txt')은 컴파일 타임에 SDK의 MSBuild 분석기/생성기에 의해 자동으로 수집되어 'assets/' 디렉터리에 기록됩니다.따라서 권장되는 워크플로는 다음과 같습니다.：

- 코드에서 키 정의 또는 수정(권장)：['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)을 컴파일하고 컴파일하면 SDK가 해당 번역 메타데이터를 생성/업데이트합니다.
- 또는 'assets/locales/를 로컬로 직접 편집'합니다.{lang}.csv'을 입력하고 SDK가 변경 사항을 통합할 수 있도록 다시 컴파일합니다.
- 파일 기반 번역을 사용하는 경우(예: Markdown 파일에 긴 텍스트 쓰기) 'LK.cs'에서 '[TranslateFile("md")]'를 사용할 수 있습니다. SDK는 해당 파일을 'assets/locales/{lang}/'를 클릭하고 파일 이름으로 CSV로 참조합니다.

예제 키：

- «LK. UI. DoNothingBuffName»
- 'LK. UI. DoNothingBuff설명'

말：'assets/lkeys.json' 및 'assets/keys.hash.txt'는 런타임 포지셔닝 및 패키징 검증에 사용되며 수동 수정은 권장하지 않습니다. 강제로 새로 고치려면 프로젝트를 정리하고 다시 컴파일합니다.

6. 빌드 및 패키징

일반적인 빌드 명령：

```bash
dotnet construir Ducky.BuffRegistration/
```

6. 모드 활성화(게임 실행)

빌드는 자동으로 모드를 게임 카탈로그에 배포하고, 게임의 모드 관리 인터페이스에서 모드를 활성화하고, 게임을 실행하여 기본 장면으로 들어가 주인공이 커스텀 버프를 받았는지 확인합니다.
