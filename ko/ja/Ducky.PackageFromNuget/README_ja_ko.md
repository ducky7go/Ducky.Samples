<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.PackageFromNuget/README.md) | [영어] (../../en/Ducky.PackageFromNuget/README_en.md) | [도이치] (../../de/Ducky.PackageFromNuget/README_de.md) | [프랑세] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [스페인어] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [일본어] (README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget 샘플 MOD

간략한 설명

이 예제에서는 종속성 관리, 리소스 파일 액세스 및 종속성 패키지 배포와 같은 YamlDotNet을 예로 사용하여 모드에서 타사 NuGet 패키지를 사용하는 방법을 보여 줍니다.

시작하기 전에 사전 프로덕션 환경 요구 사항을 준비했는지 확인합니다. 환경 준비(../docs/Prequirement.md)

## 1. 프로젝트 소개

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/))는 모드의 기능을 확장하는 방법을 보여줍니다.：

- ✅ 타사 NuGet 패키지 소개
- ✅ 외부 라이브러리를 사용하여 데이터 구문 분석(YAML)
- ✅ Mod 리소스 파일にアクセスする
- ✅ 종속성 패키지 자동 처리

예제 시나리오：\*\* YamlDotNet 라이브러리를 사용하여 Mod Resources 폴더의 YAML 구성 파일을 읽고 구문 분석합니다.

## 2. 프로젝트 구조

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # 프로젝트 구성
├── ModBehaviour.cs #モードエントリークラス
├── README.md
└── アセット/
    ├── info.ini #モードメタ情報
    ├── preview.png #プレビュー画像
    └── nice.yml # 샘플YAML파일
```

## 3. 프로젝트 구조

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>달리기; 체격; ネイティブ; content파일; アナライザー; 트랜지셔널 빌드</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

キーポイント：\*\*

- SDK는 'PrivateAssets'를 사용하여 출력으로 패키징하지 않도록 합니다.
- 타사 라이브러리(YamlDotNet)는 mod 출력 디렉토리에 자동으로 패키징됩니다.

## 4. NuGet 패키지 추가

### 방법 1：CLI 사용(권장)

```bash
cd Ducky.PackageFromNuget
dotnet 패키지 추가 YamlDotNet
```

### 방법 2：.csproj를 수동으로 편집합니다.

で '<ItemGroup>'가 추가되었습니다.：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 방법 3：Visual Studio 사용

1. 프로젝트를 마우스 오른쪽 단추로 클릭하여 NuGet 패키지→ 관리합니다.
2. "YamlDotNet" 검색
3. 「インストール」をクリックします

## 5) 구현 사례

### リソースファイル

['자산/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader입니다。
  title: "멋진 YAML 구성"
  description: 「이는、MOD의 자산 폴더에서 YAML을 로드하는 데몬스트레이션입니다」
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
ducky.Sdk.Logging을 사용합니다.
Ducky.Sdk.ModBehaviours를 사용합니다.
YamlDotNet.Serialization을 사용합니다.
YamlDotNet.Serialization.NamingConventions를 사용합니다.

네임스페이스 Ducky.PackageFromNuget;

퍼블릭 클래스 ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        모드 어셈블리가 있는 디렉토리를 가져옵니다.
        var dir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
        var ymlPath = Path.Combine(디렉토리, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("nice.yml:");
            
            YamlDotNet을 사용하여 YAML 파일 역직렬화
            var deserializer = new DeserializerBuilder()
                . 명명 규칙(Camel case 명명 규칙.
                . ビルド();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = デシリアライザー。 역직렬화<NiceData>(yml콘텐츠);
            
            Log.Info($"タイトル: {niceData.NiceHeader.Title}");
            Log.Info($" 설명: {niceData.NiceHeader.Description}");
        }
        그렇지 않은 경우
        {
            Log.Warn("nice.yml 찾을 수 없습니다!");
        }
    }

    protected 재정의 void ModDisabled()
    {
        리소스 정리(필요한 경우)
    }
}

データモデルクラス
public 클래스 NiceData
{
    공개 NiceDateHeader NiceHeader { get; セット; } = 새로운();

    퍼블릭・클래스 NiceDateHeader
    {
        공개 문자열 제목 { get; セット; } = 문자열. 비우다;
        공개 문자열 설명 { get; } セット; } = 문자열. 비우다;
    }
}
```

## 6. リソースファイルへのアクセス

### 모드 카탈로그 받기

```csharp
방법 1：조립 위치별(권장)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
```

### リソースファイルにアクセスする

```csharp
assets/ 디렉토리는 Mod 출력 디렉토리의 루트 디렉토리에 복사됩니다
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK 자동：**

- ✅ 서드 파티의 NuGet 패키지의 DLL 를 복사하는
- ✅ 리소스 파일을 출력 디렉터리에 복사합니다.
- ✅ 게임 mods 디렉토리에 デプロイする

## 7. 모드 활성화

빌드가 성공하면 게임의 모드 관리 인터페이스에서 모드를 활성화하세요.：

1. 게임 실행
2. 모드 관리 인터페이스로 이동
3. "Ducky.PackageFromNuget"을 검색합니다.
4. 활성화를 클릭합니다.
5. 게임 로그를 확인하면 구문 분석된 YAML의 내용을 볼 수 있습니다

## 8) ベストプラクティス

### ✅ 올바른 라이브러리 선택

- .NET Standard 2.0/2.1과 호환되는 라이브러리의 우선 순위 지정
- 플랫폼별 라이브러리 사용 방지
- 라이브러리의 종속성 트리가 복잡한지 확인

### ✅ 종속 버전 관리

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. 관련사례

- [ダッキー・シングルプロジェクト] (../Ducky.SingleProject/README.md) - 기본 프로젝트 구조
- [ダッキー・エントランス・モッド] (.. /Ducky.EntranceMod/README.md - 다계층 아키텍처(타사 라이브러리를 공유해야 하는 경우)
- 환경 준비 설명서 (../docs/Prequirement.md)

## 10. プロット

타사 NuGet 패키지를 사용하는 경우：

- ✅ 모드 기능을 빠르게 확장
- ✅ 바퀴를 재발명하지 마십시오
- ✅ 입증되고 안정적인 솔루션 사용
- ✅ 커뮤니티 리소스 활용

**메모：**

- ⚠️ 라이브러리가 .NET Standard 2.1과 호환되는지 확인
- ⚠️ 종속성의 크기와 성능에 미치는 영향을 인식하십시오
- ⚠️ 버전 충돌을 적절하게 처리
- ⚠️ 타사 라이브러리 라이선스 준수
