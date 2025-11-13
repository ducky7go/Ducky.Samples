<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../Ducky.Localization/README.md) | [Inglés] (../../en/Ducky.Localization/README_en.md) | [Deutsch] (../../de/Ducky.Localization/README_de.md) | [Français] (../../fr/Ducky.Localization/README_fr.md) | [English] (../../es-ES/Ducky.Localization/README_es.md) | [Japonés] (README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [Português] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [Chino tradicional] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization サンプル MOD

簡単な説明

En este ejemplo se muestra cómo definir y organizar las claves de localización en un mod independiente y cómo convertir las traducciones en recursos para su uso en tiempo de ejecución.La entrada y las definiciones clave se definen en ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) を ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Antes de empezar

Primero, lea el entorno de desarrollo y prepárelo：['ドキュメント/Prequirement.md'] (docs/Prequirement.md:1)。

Estructura del proyecto (puntos)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1— Una entrada de mod que muestra cómo hacer referencia a una cadena localizada.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1— Definiciones de clave localizadas estáticamente (se recomienda mantenerlas en el código).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1— Incluye recursos como traducción CSV, traducciones basadas en documentos y explicaciones.

ローカライズキー(LK.cs)

- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) utilizando una clave de organización constante estática (p. ej.：Clasificación de IU).
- El texto largo se puede encontrar en la anotación '[TranslateFile("md)]]' ('assets/Locales/{lang}/') como un archivo.
- Para declarar un idioma admitido, use el atributo LanguageSupport("en","en","en-hant")]' (si es necesario).

Traducir y generar archivos

- Traducir CSV：'assets/ロケール/{lang}.csv', en forma de claves y valores.
- Traducción basada en documentos：「assets/localiz/{lang}/', se hace referencia a la mediana de CSV por el nombre del archivo (por ejemplo,：'"ducky.singleproject.ui.longdescription.md"'。
- 'assets/lkeys.json' y 'assets/keys.hash.txt' no deben editarse manualmente, ya que MSBuild del SDK los genera en tiempo de compilación para el posicionamiento en tiempo de ejecución y las comprobaciones de empaquetado.

Flujo de trabajo recomendado

- Agregar o cambiar claves en el código (recomendado)：['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) y el SDK actualiza los metadatos de traducción.
- O edite "assets/localiz/ directamente"{lang}.csv" y volver a compilarlo para que el SDK pueda integrar los cambios.

Casos de uso:

```csharp
Use Ducky.Sdk.Localizations.
var message = L.UI です。 ナイスウェルカムメッセージ; Se resuelve en la traducción del idioma actual en tiempo de ejecución
```

Compilación y ejecución

```bash
dotnet build Ducky.Localization/
# o construir la solución completa
dotnet build Docky.Sdk.Sample.slnx
```

Ver

- Asegúrese de que '.csproj' esté establecido en '.<ModName>' con el atributo General project (ver otros ejemplos de proyectos).
- Para texto largo, se recomienda utilizar la traducción basada en archivos para mejorar el mantenimiento del repositorio de código fuente.

Terminar
