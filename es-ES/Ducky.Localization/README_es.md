<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](../en/Ducky.Localization/README_en.md) | [Deutsch](../de/Ducky.Localization/README_de.md) | [Français](../fr/Ducky.Localization/README_fr.md) | [Español](../es-ES/Ducky.Localization/README_es.md) | [日本語](../ja/Ducky.Localization/README_ja.md) | [한국어](../ko/Ducky.Localization/README_ko.md) | [Português](../pt-PT/Ducky.Localization/README_pt.md) | [Русский](../ru/Ducky.Localization/README_ru.md) | [繁體中文](../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra de Ducky.Localization

Breve descripción

En este ejemplo se muestra cómo definir y organizar claves de localización en un mod independiente y cómo convertir las traducciones en recursos para su uso en tiempo de ejecución.Las definiciones de entrada y clave se muestran en ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) con ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Antes de empezar

Lea y prepare primero su entorno de desarrollo：['docs/Prequirement.md'] (docs/Prequirement.md:1)。

Estructura del proyecto (puntos clave)

- ['Ducky.Localization/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — Entrada de mod que muestra cómo hacer referencia a cadenas localizadas.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) — Definiciones de clave localizadas estáticas (se recomienda mantenerlas en el código).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1): contiene recursos como CSV de traducción, traducciones basadas en documentos y descripciones.

Clave de localización (LK.cs)

- En ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) utilizando claves de organización de constantes estáticas (p. ej.：Clasificación de IU).
- El texto largo se puede traducir como un archivo usando la anotación '[TranslateFile("md)]]' (que genera 'assets/Localiz/{lang}/' en el archivo).
- Para declarar un idioma admitido, use el atributo [LanguageSupport("en","en","zh-hant")]' (si lo desea).

Traducir archivos y generar

- Traducir CSV：'assets/Localiz/{lang}.csv', en el formato Clave, Valor.
- Traducción basada en documentos：Colocado en 'assets/localities/{lang}/', se hace referencia a la mediana de CSV por el nombre del archivo, por ejemplo：'"ducky.singleproject.ui.longdescription.md"'。
- MSBuild del SDK generará 'assets/lkeys.json' y "assets/keys.hash.txt" en tiempo de compilación para el posicionamiento en tiempo de ejecución y las comprobaciones de empaquetado, por lo que no los edite manualmente.

Flujos de trabajo recomendados

- Agregar o modificar claves en el código (recomendado)：Editar ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) y compilar, y el SDK actualiza los metadatos de traducción.
- O edite "assets/localiz/ directamente"{lang}.csv' y vuelva a compilar para permitir que el SDK integre los cambios.

Ejemplos de uso

```csharp
usando Ducky.Sdk.Localizations;
var mensaje = L.UI. Buen mensaje de bienvenida; Se resuelve en una traducción del idioma actual en tiempo de ejecución
```

Compilación y ejecución

```bash
dotnet build Ducky.Localization/
# o construir la solución completa
dotnet build Docky.Sdk.Sample.slnx
```

comentario

- Asegúrese de que '.csproj' esté configurado en '<ModName>' con el atributo general del proyecto (ver otros proyectos de ejemplo).
- Se recomienda utilizar la traducción basada en archivos para un mejor mantenimiento en los repositorios de código fuente.

terminar
