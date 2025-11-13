<!-- LANG_HEADER_START -->

\| [Chino simplificado] (README.md) | [Inglés] (../en/Ducky.SingleProject/README_en.md) | [Deutsch] (../de/Ducky.SingleProject/README_de.md) | [Français] (../fr/Ducky.SingleProject/README_fr.md) | [English] (../es-ES/Ducky.SingleProject/README_es.md) | [Japonés] (../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../ko/Ducky.SingleProject/README_ko.md) | [Português] (../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../ru/Ducky.SingleProject/README_ru.md) | [Chino tradicional] (../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra de Ducky.SingleProject

Breve descripción

En este ejemplo, se muestra cómo usar Ducky.Sdk para crear un mod de un solo proyecto, incluida la inicialización del proyecto, la introducción del SDK, el ciclo de vida del mod y el proceso de empaquetado.

Antes de comenzar, asegúrese de que los requisitos previos al entorno estén listos: [Preparación del entorno](../docs/Prequirement.md)

1. Introducción al proyecto

Este directorio ('Ducky.SingleProject/') muestra el modo Mod SingleProject：Todo el código y los recursos se colocan en el mismo proyecto, y la clase de entrada hereda el 'ModBehaviourBase', consulte ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Inicializar el proyecto

- Comience con una plantilla o repositorio：Clone el repositorio de muestra y abra 'Ducky.SingleProject/'.
- Configuración necesaria del proyecto (se recomienda garantizar en '.csproj')：

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

ejemplo：Asegúrese de que ModName coincida con el nombre del ensamblado o proyecto.

1. Instalación y configuración de Ducky.Sdk

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

- La clase de entrada hereda ModBehaviourBase e implementa los métodos de ciclo de vida ModEnabled() y ModDisabled().

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

Comandos de compilación comunes：

```bash
# Construir toda la solución (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Construir solo un proyecto de muestra
dotnet build Ducky.SingleProject/
```

6. Habilitar mod (ejecutar el juego)

Build implementa automáticamente mods en el catálogo de juegos e inicia el juego para habilitar el mod en la interfaz de administración de mods o en el juego.Una vez habilitado, puedes ver la información de activación del mod en el registro del juego.
