<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.Localization/README.md) | [Englisch] (../../en/Ducky.Localization/README_en.md) | [English] (../../de/Ducky.Localization/README_de.md) | [Français] (../../fr/Ducky.Localization/README_fr.md) | [Español] (../../es-ES/Ducky.Localization/README_es.md) | [Japanisch] (README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [Português] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [Traditionelles Chinesisch] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization サンプル MOD

簡単な説明

Dieses Beispiel zeigt, wie Lokalisierungsschlüssel in einem eigenständigen Mod definiert und organisiert werden und wie Übersetzungen in Assets für die Verwendung zur Laufzeit eingefügt werden.Die Eintrags- und Schlüsseldefinitionen werden in ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) を ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Bevor Sie beginnen

Lesen Sie zunächst die Entwicklungsumgebung und bereiten Sie sie vor：['ドキュメント/Prequirement.md'] (docs/Prequirement.md:1)。

Projektstruktur (Punkte)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1— Ein Mod-Eintrag, der zeigt, wie eine lokalisierte Zeichenkette referenziert wird.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1– Statisch lokalisierte Schlüsseldefinitionen (es wird empfohlen, sie im Code zu verwalten).
- ['Ducky.Lokalisierung/assets/'] (Ducky.Localization/assets/:1– Enthält Ressourcen wie CSV-Übersetzungsdateien, dokumentenbasierte Übersetzungen und Erklärungen.

ローカライズキー(LK.cs)

- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) unter Verwendung eines statischen konstanten Organisationsschlüssels (z. B.：UI-Klassifikation).
- Langer Text ist in der Anmerkung '[TranslateFile("md)]]' ('assets/Locales/{lang}/') als Datei.
- Um eine unterstützte Sprache zu deklarieren, verwenden Sie das Attribut LanguageSupport("en","en","en-hant")]' (falls erforderlich).

Übersetzen und Generieren von Dateien

- CSV übersetzen：'assets/ロケール/{lang}.csv" in Form von Schlüsseln und Werten.
- Dokumentenbasierte Übersetzung：「Assets/Gebietsschemata/{lang}/" wird der CSV-Median durch den Dateinamen referenziert (z. B.：'"ducky.singleproject.ui.longdescription.md"'。
- "assets/lkeys.json" und "assets/keys.hash.txt" sollten nicht manuell bearbeitet werden, da sie von der MSBuild des SDK zur Kompilierzeit für die Laufzeitpositionierung und Verpackungsüberprüfungen generiert werden.

Empfohlener Arbeitsablauf

- Hinzufügen oder Ändern von Schlüsseln in Ihrem Code (empfohlen)：['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) und das SDK aktualisiert die Übersetzungsmetadaten.
- Oder bearbeiten Sie 'assets/locales/ direkt'{lang}.csv" und kompilieren Sie es neu, damit das SDK die Änderungen integrieren kann.

Anwendungsfälle:

```csharp
Verwenden Sie Ducky.Sdk.Localizations.
var message = L.UI です。 ナイスウェルカムメッセージ; Es wird zur Laufzeit in die Übersetzung der aktuellen Sprache aufgelöst
```

Erstellen und Ausführen

```bash
dotnet build Ducky.Localization/
# oder erstellen Sie die gesamte Lösung
dotnet build Docky.Sdk.Sample.slnx
```

Siehe

- Stellen Sie sicher, dass ".csproj" auf "" festgelegt ist.<ModName>' mit dem Projektattribut Allgemein (siehe andere Projektbeispiele).
- Bei Langtexten empfiehlt es sich, die dateibasierte Übersetzung zu verwenden, um die Pflege des Quellcode-Repositorys zu verbessern.

Beenden
