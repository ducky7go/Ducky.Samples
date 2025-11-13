<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.PackageFromNuget/README.md) | [日本語](../../en/Ducky.PackageFromNuget/README_en.md) | [ドイツ語](../../de/Ducky.PackageFromNuget/README_de.md) | [フランセ](../../fr/Ducky.PackageFromNuget/README_fr.md) | [スペイン語](../../es-ES/Ducky.PackageFromNuget/README_es.md) | [日本語](../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский](../../ru/Ducky.PackageFromNuget/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル モード

간략한 설명

この例では종속성 管理, 리소스 ファイル アクセス および종속성 パッケージ 배포를 포함하여 YamlDotNet을 예로 사용하여 모드에서 타사 NuGet パッケージを사용하는 방법을 보여 줍니다.

시작하기 전에 사전 프로덕션 환경 요구 사항이 준비되었는지 확인합니다. [환경 준비](../docs/Prequirement.md)

## 1. 프로젝트 소개

이 디렉토리(['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/))는 모드의 기능을 확장하는 방법을 보여줍니다.：

- ✅ 타사 NuGet 패키지 소개
- ✅ 外部ライブラリを사용하여 데이터 구문 분석(YAML)
- ✅ 모드 리소스 파일에 액세스
- ✅ 종속성 패키징 자동 처리

**예제 시나리오：** YamlDotNet ライブラリを使用 Mod Resources 폴더의 YAML 구성 파일을 읽고 구문 分析합니다.

## 2. 프로젝트 구조

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # プロジェクト構成
├── ModBehaviour.cs # モード 입学 クラス
├── README.md
└── 자산/
    ├── info.ini # モード 메타 정보
    ├── preview.png # ミリ보기 이미지
    └── nice.yml # サンプル YAML ファイル
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
      <IncludeAssets>런타임; 체격; 원주민; contentファイル; 분석기; 빌드전이적</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

키 포인트：\*\*

- SDK는 'PrivateAssets'를 사용하여 출력에 패키징하는 것을 방지합니다.
- 타사 라이브러리(YamlDotNet)는 모드 출력 디렉토리에 자동으로 패키징됩니다.

## 4. NuGet パッケージ 추가

### 방법 1：CLI 使用(권장)

```bash
cd Ducky.PackageFromNuget
dotnet パッケージ 追加 YamlDotNet
```

### 방법 2：.csproj 수동 편집

'에서<ItemGroup>' 추가：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 방법 3：Visual Studio 使用

1. プロジェクト마우스 오른쪽 단추で클릭하여 NuGet 패키지→ 管理합니다.
2. "YamlDotNet" 검색
3. "설치"를 클릭합니다.

## 5) 구현 사례

### 리소스 파일

['資産/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader を사용합니다.
  title: "멋진 YAML 구성"
  description: "モードの資産 폴더에서 YAML을 로드하는 데모입니다."
```

### 모드 입문 클래스

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget / ModBehaviour.cs:1):

```csharp
Ducky.Sdk.Logging 使用;
Ducky.Sdk.ModBehaviours 使用;
YamlDotNet.Serialization 使用;
YamlDotNet.Serialization.NamingConventions 使用;

네임스페이스 Ducky.PackageFromNuget;

公開 クラス ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        모드 어셈블리가 있는 디렉터리를 가져옵니다.
        var dir = Path.GetDirectoryName(typeof(ModBehaviour)です。 Assembly.Location)!;
        var ymlPath = Path.Combine(디렉토리, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("nice.yml:");
            
            YamlDotNet을 사용하여 YAML 파일 역직렬화
            var deserializer = 新しい DeserializerBuilder()
                . 命名規則(キャメルケース命名規則.インスタンス)
                . 빌드();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = deserializerです。 역직렬화<NiceData>(ymlコンテンツ);
            
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
public クラス NiceData
{
    公開 NiceDateHeader NiceHeader { get; 집합; } = 새로운();

    public クラス NiceDateHeader
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
var modDir = Path.GetDirectoryName(typeof(ModBehaviour)です。 Assembly.Location)!;
```

### 리소스 파일에 액세스

```csharp
assets/ ディレクトリはMod 출력 디렉토리의 루트 디렉토리에 복사됩니다
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK 自動：**

- ✅ 타사 NuGet 패키지의 DLL 복사
- ✅ 리소스 파일을 출력 디렉터리에 복사합니다.
- ✅ 게임 모드 디렉터리에 배포

## 7. 모드 활성화

빌드가 성공하면 게임의 모드 관리 인터페이스에서 모드를 활성화하세요.：

1. 게임 실행
2. 모드 관리 인터페이스로 이동
3. "Ducky.PackageFromNuget" 찾기
4. 활성화를 클릭합니다.
5. ゲームログを確認하면 구문 분석된 YAML 내용이 표시됩니다.

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

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - 基本プロジェクト構造
- [Ducky.EntranceMod] (.. /Ducky.EntranceMod/README.md- 다중 계층 아키텍처(타사 라이브러리를 공유해야 하는 경우)
- [환경 준비 문서] (.. /docs/Prequirement.md) です。

## 10. 요약

타사 NuGet 패키지를 사용하면：

- ✅ 모드 기능을 빠르게 확장
- ✅ 바퀴를 재발명하지 마십시오
- ✅ 입증되고 안정적인 솔루션 사용
- ✅ 커뮤니티 리소스 활용

**노트：**

- ⚠️ ライブラリが.NET Standard 2.1과 호환되는지 확인
- ⚠️ 종속성 크기 및 성능 영향에 유의하세요.
- ⚠️ 버전 충돌을 잘 처리합니다.
- ⚠️ 타사 라이브러리의 라이선스 준수
