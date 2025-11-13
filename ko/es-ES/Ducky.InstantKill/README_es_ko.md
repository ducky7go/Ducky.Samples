<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.InstantKill/README.md) | [English](../../en/Ducky.InstantKill/README_en.md) | [Deutsch](../../de/Ducky.InstantKill/README_de.md) | [Français](../../fr/Ducky.InstantKill/README_fr.md) | [Español](README_es.md) | [日本語](../../ja/Ducky.InstantKill/README_ja.md) | [한국어](../../ko/Ducky.InstantKill/README_ko.md) | [Português](../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](../../ru/Ducky.InstantKill/README_ru.md) | [繁體中文](../../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra de Ducky.InstantKill

Breve descripción

Este ejemplo implementa un mod simple que mata al protagonista tan pronto como ataca a un enemigo.Cuando está habilitado, si la fuente de daño es el personaje principal, infligirá un gran daño al objetivo y lo matará instantáneamente.Implementación ver ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Antes de comenzar, asegúrese de que los requisitos del entorno de preproducción estén preparados: [Preparación del entorno](../docs/Prequirement.md)

1. Introducción al proyecto

Este directorio ('Ducky.InstantKill/') demuestra el modo mod de un solo proyecto：Todo el código y los recursos se colocan en el mismo proyecto, y la clase de entrada hereda 'ModBehaviourBase', como se muestra en ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Inicializar el proyecto

- Clone el repositorio y abra 'Ducky.InstantKill/'.
- Se recomienda incluir al menos en '.csproj'：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.Muerte instantánea</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Instalación y configuración de Ducky.Sdk

Se recomienda agregar un SDK a través de NuGet：

```bash
dotnet 패키지 추가 Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>할 일</PrivateAssets>
    <IncludeAssets>에제쿠시온; 컨스트루어; 나티보; Archivos de Contenido; 아날리자도레스; 빌드전이적</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Escribir ModBehaviour

La clase de entrada hereda ModBehaviourBase e implementa los métodos de ciclo de vida ModEnabled() y ModDisabled().En este ejemplo se registra el procesador en el evento "OnHurt" para infligir un gran daño al objetivo cuando el daño proviene del personaje principal.

Código de ejemplo：

```csharp
usando Ducky.Sdk;
usando Ducky.Sdk.Logging;

espacio de nombres Ducky.InstantKill;

ModBehaviour de clase pública : ModBehaviourBase
{
    anulación protegida void ModEnabled()
    {
        Salud.OnHurt += Health_OnHurt;
    }

    anulación protegida void ModDisabled()
    {
        Salud.OnHurt -= Health_OnHurt;
    }

    privado void Health_OnHurt(Salud h, Información de daños da)
    {
        si (da. Para(h). IsFromMainToEnemy())
        {
            Log.Debug("Mod de muerte instantánea: Matar enemigo.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000,
            });
        }
    }
}
```

5. Ejecutar y empaquetar

Comandos de compilación comunes：

```bash
# Construir toda la solución
dotnet build Docky.Sdk.Sample.slnx

# Construir solo este proyecto
dotnet build Ducky.InstantKill/
```

6. Habilitar mod (ejecutar el juego)

Build implementará automáticamente el mod en el catálogo de juegos, lo habilitará en la interfaz de administración de mods del juego y probará el efecto una vez que se inicie el juego y se inicie el campo de batalla：Cuando el protagonista ataca a un enemigo, el enemigo debería morir instantáneamente.
