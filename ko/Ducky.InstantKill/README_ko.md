<!-- LANG_HEADER_START -->

\| [중국어 간체자] (README.md) | [영어] (../en/Ducky.InstantKill/README_en.md) | [도이치] (../de/Ducky.InstantKill/README_de.md) | [프랑세] (../fr/Ducky.InstantKill/README_fr.md) | [스페인어] (../es-ES/Ducky.InstantKill/README_es.md) | [일본어] (../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../ko/Ducky.InstantKill/README_ko.md) | [포르투갈어] (../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../ru/Ducky.InstantKill/README_ru.md) | [중국어 번체자] (../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill 샘플 모드

간략한 설명

이 예는 주인공이 적을 공격하자마자 죽이는 간단한 모드를 구현합니다.활성화하면 피해원이 주인공이라면 대상에게 높은 피해를 입히고 즉사시킵니다.구현은 ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

시작하기 전에 사전 프로덕션 환경 요구 사항이 준비되었는지 확인합니다. [환경 준비](../docs/Prequirement.md)

1. 프로젝트 소개

이 디렉토리('Ducky.InstantKill/')는 단일 프로젝트 모드 모드를 보여줍니다.：모든 코드와 리소스는 동일한 프로젝트에 배치되며 항목 클래스는 ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. 프로젝트 초기화

- 리포지토리를 복제하고 'Ducky.InstantKill/'을 엽니다.
- 최소한 '.csproj'에 포함하는 것이 좋습니다.：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>덕키.인스턴트 킬</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
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

4. ModBehaviour 작성

수신 클래스는 ModBehaviourBase를 상속하고 수명 주기 메서드 ModEnabled() 및 ModDisabled()를 구현합니다.이 예에서는 주인공에게서 피해가 발생할 때 대상에게 큰 피해를 입히기 위해 'OnHurt' 이벤트에 프로세서를 등록합니다.

샘플 코드：

```csharp
Ducky.Sdk 사용;
Ducky.Sdk.Logging 사용;

네임스페이스 Ducky.InstantKill;

공개 클래스 ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    protected 재정의 void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    개인 무효 Health_OnHurt(체력 h, DamageInfo da)
    {
        if (da. 에게(h). IsFromMainToEnemy())를 사용합니다.
        {
            Log.Debug("즉시 처치 모드: 적을 처치합니다.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                손상 값 = 1000,
            });
        }
    }
}
```

5. 실행 및 패키징

일반적인 빌드 명령：

```bash
# 전체 솔루션 구축
dotnet build Docky.Sdk.Sample.slnx

# 이 프로젝트만 빌드
dotnet build Ducky.InstantKill/
```

6. 모드 활성화(게임 실행)

빌드는 모드를 게임 카탈로그에 자동으로 배포하고, 게임의 모드 관리 인터페이스에서 활성화하고, 게임이 시작되고 전장이 시작되면 효과를 테스트합니다.：주인공이 적을 공격하면 적은 즉시 죽어야 합니다.
