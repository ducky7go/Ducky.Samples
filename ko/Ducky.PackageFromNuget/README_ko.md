<!-- LANG_HEADER_START -->

\| [중국어 간체자] (README.md) | [영어] (../en/Ducky.PackageFromNuget/README_en.md) | [도이치] (../de/Ducky.PackageFromNuget/README_de.md) | [프랑세] (../fr/Ducky.PackageFromNuget/README_fr.md) | [스페인어] (../es-ES/Ducky.PackageFromNuget/README_es.md) | [일본어] (../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어] (../ko/Ducky.PackageFromNuget/README_ko.md) | [포르투갈어] (../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../ru/Ducky.PackageFromNuget/README_ru.md) | [중국어 번체자] (../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget 샘플 모드

간략한 설명

이 예제에서는 종속성 관리, 리소스 파일 액세스 및 종속성 패키지 배포를 포함하여 YamlDotNet을 예로 사용하여 모드에서 타사 NuGet 패키지를 사용하는 방법을 보여 줍니다.

시작하기 전에 사전 프로덕션 환경 요구 사항이 준비되었는지 확인합니다. [환경 준비](../docs/Prequirement.md)

## 1. 프로젝트 소개

이 디렉토리(['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/))는 모드의 기능을 확장하는 방법을 보여줍니다.：

- ✅ 타사 NuGet 패키지 소개
- ✅ 외부 라이브러리를 사용하여 데이터 구문 분석(YAML)
- ✅ 모드 리소스 파일에 액세스
- ✅ 종속성 패키징 자동 처리

**예제 시나리오：** YamlDotNet 라이브러리를 사용하여 Mod Resources 폴더의 YAML 구성 파일을 읽고 구문 분석합니다.

## 2. 프로젝트 구조

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # 프로젝트 구성
├── ModBehaviour.cs # 모드 입학 클래스
├── README.md
└── 자산/
    ├── info.ini # 모드 메타 정보
    ├── preview.png # 미리보기 이미지
    └── nice.yml # 샘플 YAML 파일
```

## 3. 프로젝트 구성

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>모두</PrivateAssets>
      <IncludeAssets>런타임; 체격; 원주민; content파일; 분석기; 빌드전이적</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

키 포인트：\*\*

- SDK는 'PrivateAssets'를 사용하여 출력에 패키징하는 것을 방지합니다.
- 타사 라이브러리(YamlDotNet)는 모드 출력 디렉토리에 자동으로 패키징됩니다.

## 4. NuGet 패키지 추가

### 방법 1：CLI 사용(권장)

```bash
cd Ducky.PackageFromNuget
dotnet 패키지 추가 YamlDotNet
```

### 방법 2：.csproj 수동 편집

'에서<ItemGroup>' 추가：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 방법 3：Visual Studio 사용

1. 프로젝트를 마우스 오른쪽 단추로 클릭하여 NuGet 패키지→ 관리합니다.
2. "YamlDotNet" 검색
3. "설치"를 클릭합니다.

## 5) 구현 사례

### 리소스 파일

['자산/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader 를 사용합니다.
  title: "멋진 YAML 구성"
  description: "모드의 자산 폴더에서 YAML을 로드하는 데모입니다."
```

### 모드 입문 클래스

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Ducky.Sdk.Logging 사용;
Ducky.Sdk.ModBehaviours 사용;
YamlDotNet.Serialization 사용;
YamlDotNet.Serialization.NamingConventions 사용;

네임스페이스 Ducky.PackageFromNuget;

공개 클래스 ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        모드 어셈블리가 있는 디렉터리를 가져옵니다.
        var dir = Path.GetDirectoryName(typeof(ModBehaviour)입니다. Assembly.Location)!;
        var ymlPath = Path.Combine(디렉토리, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("nice.yml:");
            
            YamlDotNet을 사용하여 YAML 파일 역직렬화
            var deserializer = new DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . 빌드();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = deserializer입니다. 역직렬화<NiceData>(yml콘텐츠);
            
            Log.Info($"제목: {niceData.NiceHeader.Title}");
            Log.Info($"설명: {niceData.NiceHeader.Description}");
        }
        다른
        {
            Log.Warn("nice.yml 찾을 수 없습니다!");
        }
    }

    protected 재정의 void ModDisabled()
    {
        리소스 정리(필요한 경우)
    }
}

데이터 모델 클래스
public 클래스 NiceData
{
    공개 NiceDateHeader NiceHeader { get; 집합; } = 새로운();

    public 클래스 NiceDateHeader
    {
        공개 문자열 제목 { get; 집합; } = 문자열. 비우다;
        공개 문자열 설명 { get; 집합; } = 문자열. 비우다;
    }
}
```

## 6. 리소스 파일 액세스

### 모드 카탈로그 받기

```csharp
방법 1：조립 위치별(권장)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour)입니다. Assembly.Location)!;
```

### 리소스 파일에 액세스

```csharp
assets/ 디렉토리는 Mod 출력 디렉토리의 루트 디렉토리에 복사됩니다
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK 자동：**

- ✅ 타사 NuGet 패키지의 DLL 복사
- ✅ 리소스 파일을 출력 디렉터리에 복사합니다.
- ✅ 게임 모드 디렉터리에 배포

## 7. 모드 활성화

빌드가 성공하면 게임의 모드 관리 인터페이스에서 모드를 활성화하세요.：

1. 게임 실행
2. 모드 관리 인터페이스로 이동
3. "Ducky.PackageFromNuget" 찾기
4. 활성화를 클릭합니다.
5. 게임 로그를 확인하면 구문 분석된 YAML 내용이 표시됩니다.

## 8) 모범 사례

### ✅ 올바른 라이브러리 선택

- .NET Standard 2.0/2.1과 호환되는 라이브러리 선호
- 플랫폼별 라이브러리 사용 방지
- 라이브러리의 종속성 트리가 복잡한지 확인

### ✅ 종속 버전 관리

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. 관련 사례

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - 기본 프로젝트 구조
- [Ducky.EntranceMod] (../Ducky.EntranceMod/README.md- 다중 계층 아키텍처(타사 라이브러리를 공유해야 하는 경우)
- [환경 준비 문서] (../docs/Prequirement.md)

## 10. 요약

타사 NuGet 패키지를 사용하면：

- ✅ 모드 기능을 빠르게 확장
- ✅ 바퀴를 재발명하지 마십시오
- ✅ 입증되고 안정적인 솔루션 사용
- ✅ 커뮤니티 리소스 활용

**노트：**

- ⚠️ 라이브러리가 .NET Standard 2.1과 호환되는지 확인
- ⚠️ 종속성 크기 및 성능 영향에 유의하세요.
- ⚠️ 버전 충돌을 잘 처리합니다.
- ⚠️ 타사 라이브러리의 라이선스 준수
