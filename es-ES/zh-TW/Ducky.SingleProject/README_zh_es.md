<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../Ducky.SingleProject/README.md) | [Inglés] (../../en/Ducky.SingleProject/README_en.md) | [Deutsch] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [English] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japonés] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Chino tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra de Ducky.SingleProject

簡要說明

En este ejemplo, se muestra cómo crear un mod de un solo proyecto con Ducky.Sdk, incluida la inicialización del proyecto, la introducción del SDK, el ciclo de vida del mod y el proceso de empaquetado.

Antes de comenzar, asegúrese de que los requisitos previos al entorno estén listos： [Preparación ambiental](.. /docs/Prequirement.md)

1. 項目簡介

Este catálogo ('Ducky. SingleProject/') muestra el modo Mod SingleProject：Todo el código y los recursos se colocan en el mismo proyecto, y la clase de entrada hereda 'ModBehaviourBase', que se puede implementar en ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1).

2. 初始化專案

- Comience con una plantilla o almacén：Clone el repositorio de muestra y abra "Ducky.SingleProject/".
- Configuración de elementos requerida (se recomienda garantizar en '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C: \ Archivos de programa (x86) \ Steam \ steamapps \ common \ Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

ejemplo：Asegúrese de que ModName sea coherente con el nombre del ensamblado o proyecto.

1. 安裝並配置 Ducky.Sdk

Se recomienda instalar Ducky.Sdk a través de NuGet.Puede usar la CLI para agregar rápidamente (ejemplo: reemplácelo con la versión deseada)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>todo</PrivateAssets>
    <IncludeAssets>Ejecución; construir; nativo; archivos de contenido; Analizadores; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Escribe el primer ModBehaviour

- La clase de entrada debe heredar 'ModBehaviourBase' e implementar los métodos de ciclo de vida 'ModEnabled()' y 'ModDisabled()'.

Código de ejemplo：

```csharp
usando Ducky.Sdk;
usando Ducky.Sdk.Logging;

espacio de nombres Ducky.SingleProject;

ModBehaviour de clase pública : ModBehaviourBase
{
    anulación protegida void ModEnabled()
    {
        Registrar información en la inicialización
        Log.Info("Ducky.SingleProject Mod habilitado");
    }

    anulación protegida void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod deshabilitado");
    }
}
```

5. Ejecutar y empaquetar

常用構建命令：

```bash
# Construir toda la solución (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Construir solo un proyecto de muestra
dotnet build Ducky.SingleProject/
```

6. 開啟 Mod（執行遊戲）

Build implementará automáticamente mods en el catálogo de juegos e iniciará el juego para habilitar el mod en la interfaz de administración de mods o en el juego.Después de la activación, puedes ver la información de activación del mod en el registro del juego.
