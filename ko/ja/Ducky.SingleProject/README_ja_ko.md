<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.SingleProject/README.md) | [영어] (../../en/Ducky.SingleProject/README_en.md) | [도이치] (../../de/Ducky.SingleProject/README_de.md) | [프랑세] (../../fr/Ducky.SingleProject/README_fr.md) | [스페인어] (../../es-ES/Ducky.SingleProject/README_es.md) | [일본어] (README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject 샘플 MOD

간략한 설명

이 예제는 Ducky.Sdk 를 사용하여 프로젝트 초기화, SDK 배포, 모드 수명 주기 및 패키징 프로세스를 포함하여 단일 프로젝트에 대한 모드를 생성하는 방법을 보여줍니다.

시작하기 전에 사전 환경 요구 사항을 준비했는지 확인합니다. 환경 준비(../docs/Prequirement.md)

1. 프로젝트 소개

이 디렉토리('Ducky.SingleProject/')는 SingleProject Mod 모드를 보여줍니다.：모든 코드와 리소스는 동일한 프로젝트에 배치되며 엔트리 클래스는 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. 프로젝트 초기화

- 템플릿 또는 리포지토리로 시작：샘플 리포지토리를 복제하고 "Ducky.SingleProject/"를 엽니다.
- 필수 프로젝트 구성('.csproj'를 사용하여 확인하는 것이 좋습니다)：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Single프로젝트</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

본보기：ModName이 어셈블리/프로젝트 이름과 일치하는지 확인합니다.

1. Ducky.Sdk 설치 및 구성

NuGet을 통해 Ducky.Sdk를 설치하는 것이 좋습니다.CLI를 사용하여 빠르게 추가할 수 있습니다(예: 원하는 버전으로 교체).：

```bash
dotnet 패키지 추가 Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>달리기; 체격; ネイティブ; content파일; アナライザー; 트랜지셔널 빌드</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. 첫 번째 ModBehaviour 만들기

- 수신 클래스는 ModBehaviourBase에서 상속되며 수명 주기 메서드 ModEnabled() 및 ModDisabled()를 구현합니다.

サンプルコード：

```csharp
Ducky.Sdk입니다.
ducky.Sdk.Logging을 사용합니다.

네임스페이스 Ducky.SingleProject;

퍼블릭 클래스 ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        초기화 당시의 정보 기록
        Log.Info("Ducky.SingleProject 모드 활성화됨");
    }

    protected 재정의 void ModDisabled()
    {
        Log.Info("Ducky.SingleProject 모드 비활성화됨");
    }
}
```

5. 실행 및 패키징

일반 빌드 명령：

```bash
# 전체 솔루션 빌드(.slnx)
dotnet build Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet 빌드 Ducky.SingleProject/
```

6. 모드 활성화(게임 실행)

빌드는 모드를 게임 카탈로그에 자동으로 배포하고, 게임을 실행하고, 모드 관리 인터페이스 또는 게임 내에서 모드를 활성화합니다.활성화되면 게임 로그에서 모드의 활성화 정보를 확인할 수 있습니다.
