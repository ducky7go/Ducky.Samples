<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.SingleProject/README.md) | [日本語](../../en/Ducky.SingleProject/README_en.md) | [ドイツ語](../../de/Ducky.SingleProject/README_de.md) | [フランセ](../../fr/Ducky.SingleProject/README_fr.md) | [スペイン語](../../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../../ja/Ducky.SingleProject/README_ja.md) | [한국어](README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../../ru/Ducky.SingleProject/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル モード

간략한 설명

この例はDucky.Sdk を사용하여 プロジェクト초기화, SDK 導入, 모드 수명 주기 および패키징 프로세스를 포함한 단일 프로젝트 모드를 만드는 방법을 보여줍니다.

시작하기 전에 사전 환경 요구 사항이 준비되었는지 확인합니다. [환경 준비](../docs/Prequirement.md)

1. 프로젝트 소개

このディレクトリ('Ducky.SingleProject/')はSingleProject モードモードを示しています.：すべてのコードとリソースは同じプロジェクトに配置され、エントリ クラスは'ModBehaviourBase'를 상속합니다( ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. 프로젝트 초기화

- 템플릿 또는 리포지토리로 시작：샘플 리포지토리를 복제하고 'Ducky.SingleProject/'를 엽니다.
- 필요한 프로젝트 설정('.csproj'에서 보장되는 것이 좋습니다)：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>사용</Nullable>
    <LangVersion>미리 보기</LangVersion>
    <ImplicitUsings>참</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

본보기：ModNameこのアセンブリ/プロジェクト 名前と一致するか확인합니다.

1. Ducky.Sdk 설치 및 구성

NuGet을 통해 Ducky.Sdkを설치하는 것이 좋습니다. CLIを사용하여 빠르게 추가할 수 있습니다(예 - 원하는 버전으로 교체하십시오).：

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

4. 最初の ModBehaviour 작성

- 수신 클래스는 ModBehaviourBase를 상속하고 수명 주기 메서드 ModEnabled() および ModDisabled()を実装します。

샘플 코드：

```csharp
Ducky.Sdk 使用;
Ducky.Sdk.Logging 使用;

네임스페이스 Ducky.SingleProject;

公開 クラス ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        초기화 시 정보 기록
        Log.Info("Ducky.SingleProject モード 활성화됨");
    }

    protected 재정의 void ModDisabled()
    {
        Log.Info("Ducky.SingleProject モード비활성화됨");
    }
}
```

5. 실행 및 패키징

일반적인 빌드 명령：

```bash
# 전체 솔루션 빌드(.slnx)
dotnet build Docky.Sdk.Sample.slnx

# 단일 샘플 프로젝트만 빌드
dotnet ビルド Ducky.SingleProject/
```

6. 모드 활성화(게임 실행)

빌드는 모드를 게임 카탈로그에 자동으로 배포하고 게임을 실행하여 모드 관리 인터페이스 또는 게임 내에서 모드를 활성화합니다.활성화되면 게임 로그에서 모드의 활성화 정보를 볼 수 있습니다.
