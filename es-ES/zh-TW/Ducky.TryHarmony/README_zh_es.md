<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../Ducky.TryHarmony/README.md) | [Inglés] (../../en/Ducky.TryHarmony/README_en.md) | [Deutsch] (../../de/Ducky.TryHarmony/README_de.md) | [Français] (../../fr/Ducky.TryHarmony/README_fr.md) | [English] (../../es-ES/Ducky.TryHarmony/README_es.md) | [Japonés] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Português] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Chino tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra Ducky.TryHarmony

簡要說明

En este ejemplo se muestra el uso de HarmonyLib para parchear un mod para el código del juego en tiempo de ejecución.El ejemplo contiene una revisión de Harmony simple (revisión de guardado) con el efecto de hacer que la operación de guardado falle constantemente (SaveFilePatch).El registro de entradas y parches se implementa en ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1).

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

Este catálogo ('Ducky. TryHarmony/') muestra el modo de parche Harmony：Registre el parche llamando a PatchAll de Harmony en ModEnabled y cancele el parche en ModDisabled.Nos vemos en realizaciones clave：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Ficha de proyecto：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Habilitar Harmony en csproj

Para usar el parche de Harmony, habilite la propiedad IncludeHarmony en 'Ducky.TryHarmony.csproj'.Por ejemplo：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>verdadero</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. Parche de SaveFileFilePatch

La función principal de 'SaveFilePatch' es hacer que las operaciones de guardado (guardar partida) fallen constantemente, lo que facilita la demostración del efecto del parche y el proceso de manejo de errores.El ejemplo de revisión intercepta el método relacionado con el guardado y devuelve un error (consulte ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)).

4. Ejecución y pruebas

- Proyectos de construcción：

```bash
dotnet build Ducky.TryHarmony/
```

- Mods abiertos (implementa compilaciones en el catálogo de mods del juego y ábrelas en el juego)
- Intentar guardar una partida guardada en el juego da como resultado un "Guardado fallido" que indica que el parche está activo.

5. Precauciones comunes

- Confirme que 'IncludeHarmony' está establecido en 'true', de lo contrario, el código relacionado con Harmony no funcionará correctamente.
- Al depurar parches, el registro se puede agregar a 'ModBehaviour' (usando 'Ducky.Sdk.Logging.Log') para verificar que se llama a 'PatchAll()'/'UnpatchAll()'.
