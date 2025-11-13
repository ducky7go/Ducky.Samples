<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.BuffRegistration/README.md) | [영어] (../../en/Ducky.BuffRegistration/README_en.md) | [도이치] (../../de/Ducky.BuffRegistration/README_de.md) | [프랑세] (../../fr/Ducky.BuffRegistration/README_fr.md) | [스페인어] (README_es.md) | [일본어] (../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어] (../../ko/Ducky.BuffRegistration/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский] (../../ru/Ducky.BuffRegistration/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra Ducky.Buff등록

Breve descripción

En este ejemplo se muestra cómo usar Ducky.Sdk para registrar una mejora personalizada, incluidas las claves localizadas y los diseños de recursos. Entrada e implementación véase ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

Antes de comenzar, asegúrese de que los requisitos del entorno de preproducción estén preparados: [Preparación del entorno](../docs/Prequirement.md)

1. Introducción al proyecto

Este directorio (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1Demuestra el patrón de registro de Buffs a través de Contract.Buffs en un mod de un solo proyecto. Este proyecto también contiene claves de localización, consulte ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. Inicializar el proyecto

- Clone el repositorio y abra 'Ducky.BuffRegistration/'.
- Se recomienda incluir al menos .csproj：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>하빌리타르</Nullable>
    <LangVersion>비스타 프리비아</LangVersion>
    <ImplicitUsings>베르다데로</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>덕키버프 레지스트로</ModName>
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

4. Registrar un beneficio personalizado (ejemplo)

Use Contract.Buffs.RegisterBuff para registrar el Buff y establecer el nombre para mostrar, la descripción, el icono y la duración de la devolución de llamada.ejemplo：

```csharp
usando Ducky.Sdk;

ModBehaviour de clase pública : ModBehaviourBase
{
    int _buffId privado;

    anulación protegida void ModEnabled()
    {
        _buffId = Contrato.Buffs.RegistroBuff<DoNothingBuff>(버프 =>
        {
            팬. SetDisplayName(LK. UI. DoNothingBuffName)을 사용합니다.
                . SetDescription(LK. UI. DoNothingBuffDescription)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(true)
                . TotalLifeTime 설정(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        Escucha la inicialización de la escena：Otorga automáticamente este beneficio al protagonista al ingresar a la base (consulte ModBehaviour para la implementación)
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    anulación protegida void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter;
            if (메인 != null)
            {
                Crea y agrega una instancia de Buff registrada cuando ingresas a la escena base
                원금. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. localización

En este ejemplo se define una clave de cadena en ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。El archivo de traducción generalmente se encuentra en 'assets/localiz/' (visible en el directorio de origen), pero tenga cuidado：Los CSV de traducción, los metadatos de traducción ("assets/lkeys.json") y los archivos de validación ("assets/keys.hash.txt") se recopilan automáticamente y se escriben en el directorio " assets/" mediante el analizador o generador de MSBuild del SDK en tiempo de compilación. Por lo tanto, el flujo de trabajo recomendado es:：

- Definir o modificar claves en el código (recomendado)：에디타르 ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1) y compilar, y el SDK genera o actualiza los metadatos de traducción correspondientes.
- O edite 'assets/localmente/ directamente localmente' localmente{lang}.csv' y vuelva a compilar para permitir que el SDK integre los cambios.
- Si utiliza la traducción basada en archivos (por ejemplo, escribir texto largo en un archivo Markdown), puede usar '[TranslateFile("md")]' en 'LK.cs'; El SDK colocará el archivo correspondiente en 'assets/locales/{lang}/' y haga referencia a él en CSV con el nombre del archivo.

Clave de ejemplo：

- 'LK. UI. DoNothingBuffName'
- 'LK. UI. DoNothingBuff설명'

코멘타리오：'assets/lkeys.json' y 'assets/keys.hash.txt' se utilizan para el posicionamiento en tiempo de ejecución y la verificación del embalaje, y no se recomienda la modificación manual. Para forzar una actualización, limpie y vuelva a compilar el proyecto.

6. Construir y empaquetar

Comandos de compilación comunes：

```bash
dotnet build Ducky.BuffRegistration/
```

6. Habilitar mod (ejecutar el juego)

La compilación implementará automáticamente el mod en el catálogo de juegos, habilitará el mod en la interfaz de administración de mods del juego e iniciará el juego para ingresar a la escena base Para ver si el protagonista ha recibido un beneficio personalizado.
