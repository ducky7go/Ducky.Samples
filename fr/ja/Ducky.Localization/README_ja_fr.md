<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.Localization/README.md) | [Traduction] (../../en/Ducky.Localization/README_en.md) | [Deutsch] (../../de/Ducky.Localization/README_de.md) | [English] (../../fr/Ducky.Localization/README_fr.md) | [Español] (../../es-ES/Ducky.Localization/README_es.md) | [Japonais] (README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [Português] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [Chinois traditionnel] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization サンプル MOD

簡単な説明

Cet exemple montre comment définir et organiser les clés de localisation dans un mod autonome, et comment placer les traductions dans des ressources à utiliser dans le runtime.Les définitions d’entrée et de clé sont définies dans ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) を ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Avant de commencer

Tout d’abord, lisez l’environnement de développement et préparez-le：['ドキュメント/Prequirement.md'] (docs/Prequirement.md:1)。

Structure du projet (points)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1— Une entrée de mod qui montre comment référencer une chaîne localisée.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1— Définitions de clés localisées statiquement (il est recommandé de les conserver dans le code).
- ['Ducky.Localization/assets/'] (Ducky.Localization/assets/:1— Comprend des ressources telles que des fichiers CSV de traduction, des traductions basées sur des documents et des explications.

ローカライズキー(LK.cs)

- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) à l’aide d’une clé d’organisation de constante statique (p. ex.：UI).
- Le texte long se trouve dans l’annotation '[TranslateFile("md)]]' ('assets/Locales/{lang}/') sous forme de fichier.
- Pour déclarer une langue prise en charge, utilisez l’attribut LanguageSupport(« en »,"en »,"en-hant »)]' (si nécessaire).

Traduire et générer des fichiers

- Traduire CSV：'actifs/ロケール/{lang}.csv', sous forme de clés et de valeurs.
- Traduction basée sur des documents：「assets/locales/{lang}/', la médiane CSV est référencée par le nom du fichier (par exemple,：''ducky.singleproject.ui.longdescription.md''。
- « assets/lkeys.json » et « assets/keys.hash.txt » ne doivent pas être modifiés manuellement, car ils sont générés par le MSBuild du SDK au moment de la compilation pour les vérifications de positionnement et d’empaquetage au moment de l’exécution.

Flux de travail recommandé

- Ajouter ou modifier des clés dans votre code (recommandé)：['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) et le SDK met à jour les métadonnées de traduction.
- Ou modifiez 'assets/locales/ directement'{lang}.csv » et recompilez-le afin que le SDK puisse intégrer les modifications.

Cas d’utilisation :

```csharp
Utilisez Ducky.Sdk.Localizations.
var message = L.UI です。 ナイスウェルカムメッセージ; Il s’agit de la traduction de la langue actuelle au moment de l’exécution
```

Construire et exécuter

```bash
dotnet build Ducky.Localisation/
# ou construire l’ensemble de la solution
dotnet build Docky.Sdk.Sample.slnx
```

Voir

- Assurez-vous que '.csproj' est défini sur '.<ModName>' avec l’attribut Projet général (voir autres exemples de projet).
- Pour les textes longs, il est recommandé d’utiliser la traduction basée sur les fichiers afin d’améliorer la maintenance du référentiel de code source.

Finir
