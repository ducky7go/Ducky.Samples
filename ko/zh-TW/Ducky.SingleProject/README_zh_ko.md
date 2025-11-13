<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.SingleProject/README.md) | [영어] (../../en/Ducky.SingleProject/README_en.md) | [도이치] (../../de/Ducky.SingleProject/README_de.md) | [프랑세] (../../fr/Ducky.SingleProject/README_fr.md) | [스페인어] (../../es-ES/Ducky.SingleProject/README_es.md) | [일본어] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [중국어 번체자] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject 샘플 모드

간략하게 설명

이 예제는 프로젝트 초기화, SDK 도입, 모드 수명 주기 및 패키징 프로세스를 포함하여 Ducky.Sdk를 사용하여 단일 프로젝트 모드를 만드는 방법을 보여줍니다.

시작하기 전에 사전 환경 요구 사항이 준비되었는지 확인합니다： [환경 준비](.. /docs/Prequirement.md)를 사용합니다.

1. 프로젝트 소개

이 카탈로그('Ducky. SingleProject/')는 SingleProject 모드 모드를 보여줍니다.：모든 코드와 리소스는 동일한 프로젝트에 배치되며 엔트리 클래스는 ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)에서 구현할 수 있는 'ModBehaviourBase'를 상속합니다.

2. 프로젝트 초기화

- 템플릿 또는 웨어하우스로 시작：샘플 리포지토리를 복제하고 "Ducky.SingleProject/"를 엽니다.
- 필수 항목 설정('.csproj'에서 보장하는 것이 좋습니다)：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

본보기：ModName이 어셈블리/프로젝트 이름과 일치하는지 확인합니다.

1. Ducky.Sdk 설치 및 구성

NuGet을 통해 Ducky.Sdk를 설치하는 것이 좋습니다.CLI를 사용하여 빠르게 추가할 수 있습니다(예: - 원하는 버전으로 교체).：

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

4. 첫 번째 ModBehaviour 작성

- 엔트리 클래스는 'ModBehaviourBase'를 상속하고 라이프사이클 메서드 'ModEnabled()' 및 'ModDisabled()'를 구현해야 합니다.

샘플 코드：

```csharp
Ducky.Sdk 사용;
Ducky.Sdk.Logging 사용;

네임스페이스 Ducky.SingleProject;

공개 클래스 ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        초기화 시 정보 기록
        Log.Info("Ducky.SingleProject 모드 활성화됨");
    }

    protected 재정의 void ModDisabled()
    {
        Log.Info("Ducky.SingleProject 모드 비활성화됨");
    }
}
```

5. 실행 및 패키징

일반적인 빌드 명령：

```bash
# 전체 솔루션 빌드(.slnx)
dotnet build Docky.Sdk.Sample.slnx

# 단일 샘플 프로젝트만 빌드
dotnet 빌드 Ducky.SingleProject/
```

6. 모드 열기(게임 실행)

빌드는 자동으로 모드를 게임 카탈로그에 배포하고 게임을 실행하여 모드 관리 인터페이스 또는 게임 내에서 모드를 활성화합니다.활성화 후 게임 로그에서 모드의 활성화 정보를 확인할 수 있습니다.
