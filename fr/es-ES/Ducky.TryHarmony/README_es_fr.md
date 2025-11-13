<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.TryHarmony/README.md) | [Traduction] (../../en/Ducky.TryHarmony/README_en.md) | [Deutsch] (../../de/Ducky.TryHarmony/README_de.md) | [English] (../../fr/Ducky.TryHarmony/README_fr.md) | [Español] (README_es.md) | [Japonais] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Português] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Chinois traditionnel] (../../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra Ducky.TryHarmony

Breve descripción

En este ejemplo se muestra un mod que usa HarmonyLib para parchear el código del juego en tiempo de ejecución. El ejemplo contiene una revisión simple de Harmony (revisión de guardado) que tiene el efecto de hacer que la operación de guardado falle de forma coherente (SaveFilePatch). Registro de entrada y parche en ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1).

Antes de comenzar, asegúrese de que los requisitos del entorno de preproducción estén preparados : [Preparación del entorno](../docs/Prequirement.md)

1. Introducción al proyecto

Este directorio ('Ducky.TryHarmony/') muestra el modo de parche de Harmony：Registre el parche llamando a PatchAll de Harmony en ModEnabled y cancele el parche en ModDisabled.Nos vemos en realizaciones clave：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Documentos del proyecto：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj :1)

2. Habilitar Harmony en csproj

Para usar el parche de Harmony, habilite la propiedad IncludeHarmony en 'Ducky.TryHarmony.csproj'. Por ejemplo：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Estándar de red2.1</TargetFramework>
    <Nullable>Habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>Verdadero</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>Verdadero</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. Parche de SaveFileFilePatch

La función principal de 'SaveFilePatch' es hacer que la operación de guardado falle constantemente, lo que facilita la demostración del efecto del parche y el proceso de manejo de errores. Este ejemplo de parche intercepta el método relacionado con el guardado y devuelve un error (consulte ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. Funcionamiento y pruebas

- Construir el proyecto：

```bash
dotnet build Ducky.TryHarmony/
```

- Habilitar mods (implementar compilaciones en el catálogo de mods del juego y habilitarlas en el juego)
- Intentar guardar un guardado en el juego da como resultado un « guardado fallido », lo que indica que el parche está en vigor.

5. Consideraciones comunes

- Confirme que 'IncludeHarmony' está establecido en 'true', de lo contrario, el código relacionado con Harmony no funcionará.
- Al depurar un parche, puede agregar un registro (mediante Ducky.Sdk.Logging.Log) a 'ModBehaviour' para verificar que se llama a 'PatchAll()'/'UnpatchAll()'.
