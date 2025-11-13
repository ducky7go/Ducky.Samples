<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.Localization/README.md) | [English](../../en/Ducky.Localization/README_en.md) | [Deutsch](../../de/Ducky.Localization/README_de.md) | [Français](README_fr.md) | [Español](../../es-ES/Ducky.Localization/README_es.md) | [日本語](../../ja/Ducky.Localization/README_ja.md) | [한국어](../../ko/Ducky.Localization/README_ko.md) | [Português](../../pt-PT/Ducky.Localization/README_pt.md) | [Русский](../../ru/Ducky.Localization/README_ru.md) | [繁體中文](../../zh-TW/Ducky.Localization/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.Localization exemple mod

Brève description

Cet exemple montre comment définir et organiser les clés de localisation dans un mod autonome et comment placer les traductions dans des ressources pour une utilisation au moment de l’exécution.Les définitions d’entrée et de clé sont indiquées dans ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) avec ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Avant de commencer

Veuillez d’abord lire et préparer votre environnement de développement：['docs/Prequirement.md'] (docs/Prequirement.md:1)。

Structure du projet (points clés)

- ['Ducky.Localization/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — Entrée de mod qui montre comment référencer des chaînes localisées.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) — Définitions de clés localisées statiques (recommandées pour être conservées dans le code).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1) — Contient des ressources telles que des fichiers CSV de traduction, des traductions basées sur des documents et des descriptions.

Clé de localisation (LK.cs)

- Dans ['ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) à l’aide de clés d’organisation constantes statiques (par exemple：UI).
- Le texte long peut être traduit sous forme de fichier à l’aide de l’annotation '[TranslateFile("md)]]' (qui génère 'assets/Locales/{lang}/' dans le fichier).
- Pour déclarer une langue prise en charge, utilisez l’attribut [LanguageSupport(« en »,"en »,"zh-hant »)]' (si vous le souhaitez).

Traduire des fichiers et générer

- Traduire CSV：'assets/Locales/{lang}.csv', au format Clé, Valeur.
- Traduction basée sur des documents：Placé dans 'assets/locales/{lang}/', la médiane CSV est référencée par le nom du fichier, par exemple：''ducky.singleproject.ui.longdescription.md''。
- « assets/lkeys.json » et « assets/keys.hash.txt » seront générés par le MSBuild du SDK au moment de la compilation pour les vérifications de positionnement et d’empaquetage au moment de l’exécution, ne les modifiez donc pas manuellement.

Flux de travail recommandés

- Ajouter ou modifier des clés dans votre code (recommandé)：Modifier ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) et compilez, et le SDK met à jour les métadonnées de traduction.
- Ou modifiez 'assets/locales/ directement'{lang}.csv » et recompilez pour permettre au SDK d’intégrer les modifications.

Exemples d’utilisation

```csharp
à l’aide de Ducky.Sdk.Localizations ;
var message = L.UI. NiceWelcomeMessage ; Se résout en une traduction de la langue actuelle au moment de l’exécution
```

Construire et exécuter

```bash
dotnet build Ducky.Localisation/
# ou construire l’ensemble de la solution
dotnet build Docky.Sdk.Sample.slnx
```

remarque

- Assurez-vous que '.csproj' est défini sur '<ModName>' avec l’attribut general project (voir autres exemples de projets).
- Il est recommandé d’utiliser la traduction basée sur des fichiers pour une meilleure maintenance dans les dépôts de code source.

Finir
