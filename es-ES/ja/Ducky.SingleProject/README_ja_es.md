<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../Ducky.SingleProject/README.md) | [Inglés] (../../en/Ducky.SingleProject/README_en.md) | [Deutsch] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [English] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japonés] (README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Chino tradicional] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

簡単な説明

En este ejemplo se muestra cómo usar Ducky.Sdk para crear mods para un solo proyecto, incluida la inicialización del proyecto, la implementación del SDK, el ciclo de vida del mod y el proceso de empaquetado.

Antes de comenzar, asegúrese de haber preparado los requisitos previos al entorno: Prepare el entorno (../docs/Prequirement.md)

1. プロジェクト紹介

Este directorio ('Ducky.SingleProject/') muestra el modo Mod SingleProject：Todo el código y los recursos se colocan en el mismo proyecto, y la clase de entrada hereda 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. プロジェクトを初期化する

- Comience con una plantilla o repositorio：Clone el repositorio de muestra y abra "Ducky.SingleProject/".
- Configuración del proyecto requerida (recomendamos asegurarse con '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C: \ Archivos de programa (x86) \ Steam \ steamapps \ common \ Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

ejemplo：Asegúrese de que ModName coincida con el nombre del ensamblado o proyecto.

1. Ducky.Sdk をインストールして構成する

Se recomienda instalar Ducky.Sdk a través de NuGet.Puede usar la CLI para agregarlo rápidamente (por ejemplo, reemplácelo con la versión que desee)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>実行中; 建てる; ネイティブ; contentファイル; アナライザー; ビルド推移的</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Crea tu primer ModBehaviour

- イングレスクラスは ModBehaviourBase を継承し、ライフサイクルメソッド ModEnabled() と ModDisabled() を実装します。

サンプルコード：

```csharp
Ducky.Sdk.
Use ducky.Sdk.Logging.

espacio de nombres Ducky.SingleProject;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    anulación protegida void ModEnabled()
    {
        Registro de información en el momento de la inicialización
        Log.Info("Ducky.SingleProject Mod habilitado");
    }

    anulación protegida void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod deshabilitado");
    }
}
```

5. 実行とパッケージ化

一般的なビルドコマンド：

```bash
# Construir toda la solución (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet build Ducky.SingleProject/
```

6. Modを有効にする(ゲームを実行する)

La compilación implementa automáticamente el mod en el catálogo de juegos, inicia el juego y habilita el mod en la interfaz de administración de mods o en el juego.Una vez habilitado, puedes consultar la información de activación del mod en el registro del juego.
