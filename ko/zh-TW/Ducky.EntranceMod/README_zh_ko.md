<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.EntranceMod/README.md) | [영어] (../../en/Ducky.EntranceMod/README_en.md) | [도이치] (../../de/Ducky.EntranceMod/README_de.md) | [프랑세] (../../fr/Ducky.EntranceMod/README_fr.md) | [스페인어] (../../es-ES/Ducky.EntranceMod/README_es.md) | [일본어] (../../ja/Ducky.EntranceMod/README_ja.md) | [한국어] (../../ko/Ducky.EntranceMod/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский] (../../ru/Ducky.EntranceMod/README_ru.md) | [중국어 번체자] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod 샘플 모드

간략하게 설명

이 예제는 다층 아키텍처 패턴을 사용하여 모드를 개발하고, 공유 코드를 독립적인 라이브러리 프로젝트로 분리하고, 코드 재사용 및 모듈식 설계를 달성하는 방법을 보여줍니다.대규모 모드나 여러 모드 간에 코드를 공유해야 하는 시나리오에 적합합니다.

시작하기 전에 프론트엔드 환경 요구 사항이 준비되었는지 확인합니다： [환경 준비](.. /docs/Prequirement.md)를 사용합니다.

## 1. 프로젝트 소개

이 예제는 두 항목으로 구성됩니다：

- **메인 모드 프로젝트** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - 리소스 파일이 포함된 모드 항목
- **공공 도서관 프로젝트** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - 공유 코드베이스

이 아키텍처 패턴은 다음과 같이 적용됩니다.：

- 대규모 모드에는 계층적 관리가 필요합니다.
- 여러 모드가 공통 로직을 공유합니다.
- 팀의 공동 개발
- 비즈니스 로직은 독립적으로 테스트해야 합니다.

## 2. 프로젝트 구조

```
Ducky.EntranceMod/ # 메인 모드 프로젝트
├── Ducky.EntranceMod.csproj # 프로젝트 구성
├── ModBehaviour.cs # 모드 입구
├── README.md
└── assets/ # 리소스 문서 디렉토리
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── 로케일/
        ├── zh.csv
        └── en.csv

ducky.EntranceMod.Common/ # 공공 도서관 프로젝트
├── Ducky.EntranceMod.Common.csproj # 라이브러리 프로젝트 구성
├── LK.cs # 현지화 키 공유
└── MyModBase.cs # 공유 베이스 클래스
```

## 3. 메인 모드 프로젝트 구성

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1)를 사용합니다.：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>참</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>모두</PrivateAssets>
      <IncludeAssets>런타임; 체격; 원주민; content파일; 분석기; 빌드전이적</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**핵심 구성 설명：**

- \\`<ExcludeSdkLib>참</ExcludeSdkLib>- SDK 라이브러리를 출력 디렉터리에 반복적으로 패키징하지 마십시오.

## 4. 공용 라이브러리 프로젝트 구성

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1)입니다.：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>참</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/assets</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>모두</PrivateAssets>
      <IncludeAssets>런타임; 체격; 원주민; content파일; 분석기; 빌드전이적</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**핵심 구성 설명：**

- \\`<IsModLib>참</IsModLib>' - 이 항목을 모드 라이브러리로 표시하면 SDK가 특별히 처리합니다.
- \\`<AssetsDir>' - 현지화 키가 올바르게 생성되도록 기본 프로젝트의 자산 디렉터리를 가리킵니다.

## 5. 코드 예제 공유

### 현지화 키 공유

['Ducky.EntranceMod.Common/LK.cs'] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
네임스페이스 Ducky.EntranceMod.Common;

public 정적 클래스 LK
{
    public static class UI
    {
        공개 const 문자열 NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### 공유 기본 클래스

['Ducky.EntranceMod.Common/MyModBase.cs'] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
Ducky.Sdk.ModBehaviours 사용;

네임스페이스 Ducky.EntranceMod.Common;

공개 추상 클래스 MyModBase : ModBehaviourBase
{
    모든 모드가 공유하는 공통 방법을 여기에 추가할 수 있습니다.
    보호된 가상 무효 LogModInfo(문자열 메시지)
    {
        Log.Info($"[{GetType(). 이름}] {message}");
    }
}
```

### 메인 모드는 공유 코드를 사용합니다.

['Ducky.EntranceMod/ModBehaviour.cs'] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
Ducky.Sdk.Logging 사용;
Ducky.EntranceMod.Common 사용;

네임스페이스 Ducky.EntranceMod;

공통 기본 클래스 상속
공개 클래스 ModBehaviour : MyModBase
{
    protected 재정의 void ModEnabled()
    {
        Log.Info("모드 활성화됨");
        공유 현지화 키 사용
        var message = LK. UI. NiceWelcomeMessage입니다.
        LogModInfo($"환영 메시지 키: {message}");
    }

    protected 재정의 void ModDisabled()
    {
        Log.Info("모드 비활성화됨");
    }
}
```

## 6. 다층 아키텍처의 장점

### ✅ 코드 다중화

- 여러 모드가 'Ducky.EntranceMod.Common' 라이브러리를 공유할 수 있습니다.
- 코드 중복 방지 및 유지 관리성 향상

### ✅ 모듈식 설계

- 비즈니스 로직은 Mod 항목과 분리되어 있습니다.
- 쉬운 단위 테스트
- 종속성 지우기

### ✅ 팀 협업

- 다른 개발자는 서로 다른 계층을 독립적으로 개발할 수 있습니다
- 코드 충돌 감소
- 간편한 코드 검토

### ✅ 현지화된 공유

- 공용 라이브러리는 공유 지역화 키를 정의할 수 있습니다.
- 라이브러리를 사용하는 모든 모드는 자동으로 번역을 지원합니다.

## 7. 프로세스 구축

SDK는 다중 항목 종속성을 자동으로 처리합니다.：

```bash
# 전체 솔루션 구축(권장)
dotnet build Docky.Sdk.Sample.slnx

# 또는 메인 프로젝트를 별도로 빌드합니다(종속 라이브러리 프로젝트가 자동으로 생성됨).
dotnet 빌드 Ducky.EntranceMod/
```

**제품 구축：**

- 메인 모드 세트 + 공공 라이브러리 어셈블리가 함께 패키징됩니다.
- 리소스 파일은 기본 프로젝트의 'assets/' 디렉토리에서 가져옵니다.
- SDK 라이브러리는 반복적으로 포함되지 않습니다(<ExcludeSdkLib>참</ExcludeSdkLib>\\`）

## 8. 모드 활성화

일단 구축되면 모드는 자동으로 게임 카탈로그에 배포됩니다：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── 자산/
    ├── info.ini
    ├── lkeys.json
    └── 로케일/</游戏目录>
```

게임의 모드 관리 인터페이스에서 모드를 활성화하세요.

## 9. 확장 제안

### 더 많은 공용 라이브러리 만들기

복잡한 프로젝트의 경우 여러 공용 라이브러리를 만들 수 있습니다：

```
Ducky.EntranceMod/ # 마스터 모드
Ducky.EntranceMod.Common/ # 범용 코드
Ducky.EntranceMod.Gameplay/ # 게임플레이 로직
Ducky.EntranceMod.UI/ # UI 관련
```

## 10. 자주 묻는 질문

### Q： '<ExcludeSdkLib>참</ExcludeSdkLib>\\`？

A： Ducky.Sdk의 라이브러리 파일을 모드 출력 디렉토리에 중복 패키징하지 마십시오.SDK 라이브러리는 이미 게임에 존재하므로 다시 포함할 필요가 없습니다.

### Q: \\`<AssetsDir>설정이 필요합니까?

A： 공용 도서관 프로젝트의 경우 현지화 키(LK.cs)가 포함된 경우 '<AssetsDir>'를 기본 프로젝트의 assets 디렉터리에 추가하여 SDK가 현지화된 메타데이터를 제대로 생성할 수 있도록 합니다.

### Q： 여러 메인 모드 프로젝트가 동일한 공개 라이브러리를 공유할 수 있나요?

A： 그래!이것이 다계층 아키텍처의 장점입니다.여러 모드가 동일한 공개 라이브러리 프로젝트를 참조할 수 있습니다.

### Q： 공공 도서관의 지역화 키는 어디에서 생성되나요?

A： '<AssetsDir>' 지정된 디렉토리, 즉 마스터 프로젝트의 'assets/' 디렉토리 아래에 있는 'lkeys.json' 파일입니다.

## 11. 관련 자료

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - 단일 프로젝트 패턴 참조
- [Ducky.현지화] (.. /Ducky.Localization/README.md) - 현지화 시스템에 대한 자세한 설명
- [환경준비문서] (../docs/Prequirement.md)

## 12. 요약

다층 아키텍처 패턴이 적합합니다.：

- ✅ 대규모 모드 프로젝트
- ✅ 코드 재사용이 필요한 시나리오
- ✅ 팀의 공동 개발
- ✅ 시리즈 모드 개발

모드가 비교적 간단하다면 [Ducky.SingleProject](.. /Ducky.SingleProject/README.md) 단일 프로젝트 모드를 사용합니다.
