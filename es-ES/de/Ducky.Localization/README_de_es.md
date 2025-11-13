<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../Ducky.Localization/README.md) | [Inglés] (../../en/Ducky.Localization/README_en.md) | [Deutsch] (README_de.md) | [Français] (../../fr/Ducky.Localization/README_fr.md) | [English] (../../es-ES/Ducky.Localization/README_es.md) | [Japonés] (../../ja/Ducky.Localization/README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [Português] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [Chino tradicional] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization Beispiel-Mod

Kurzbeschreibung

Dieses Beispiel zeigt, wie man Lokalisierungsschlüssel in einem eigenständigen Mod definiert und organisiert und wie man Übersetzungen in Assets für die Laufzeitnutzung einfügt. Eintrags- und Schlüsseldefinitionen werden in ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) mit ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Bevor Sie beginnen

Bitte lesen und bereiten Sie zuerst Ihre Entwicklungsumgebung vor：['docs/Prequirement.md'] (docs/Prequirement.md:1)。

Projektstruktur (Kernpunkte)

- ['Ducky.Localization/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — Mod-Eintrag, der zeigt, wie lokalisierte Zeichenketten referenziert werden.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) — Statische, lokalisierte Schlüsseldefinitionen (es wird empfohlen, sie im Code zu verwalten).
- ['Ducky.Lokalisierung/assets/'] (Ducky.Localization/assets/:1) – Enthält Ressourcen wie CSV-Übersetzungsdateien, dokumentenbasierte Übersetzungen und Beschreibungen.

Lokalisierungsschlüssel (LK.cs)

- En ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) unter Verwendung statischer konstanter Organisationsschlüssel (z. B.：UI-Klassifikation).
- Langer Text kann mit der Anmerkung '[TranslateFile("md)]]' (die 'assets/Locales/ generiert) als Datei übersetzt werden.{lang}/' in der Datei).
- Um eine unterstützte Sprache zu deklarieren, verwenden Sie das Attribut [LanguageSupport("en","en","zh-hant")]' (falls gewünscht).

Übersetzen von Dateien und Generieren

- CSV übersetzen：«Vermögenswerte/Gebietsschemata/{lang}.csv" im Format Schlüssel, Wert.
- Dokumentenbasierte Übersetzung：Abgelegt en 'assets/locales/{lang}/', CSV-Median wird durch den Dateinamen referenziert, z.B.：'"ducky.singleproject.ui.longdescription.md"'。
- "assets/lkeys.json" und "assets/keys.hash.txt" werden von MSBuild des SDK zur Kompilierzeit für die Laufzeitpositionierung und Paketierungsüberprüfungen generiert, bearbeiten Sie sie Daher bitte nicht manuell.

Flujos de trabajo de Empfohlene

- Hinzufügen oder Ändern von Schlüsseln in Ihrem Code (empfohlen)：Bearbeiten ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) und kompilieren, und das SDK aktualisiert die Übersetzungsmetadaten.
- Oder bearbeiten Sie 'assets/locales/ direkt'{lang}.csv" und kompilieren Sie neu, damit das SDK die Änderungen integrieren kann.

Anwendungsbeispiele

```csharp
mit Ducky.Sdk.Localizations;
var mensaje = L.UI. Buen mensaje de bienvenida; Löst zur Laufzeit eine Übersetzung der aktuellen Sprache auf
```

Erstellen und Ausführen

```bash
dotnet build Ducky.Localization/
# oder erstellen Sie die gesamte Lösung
dotnet build Docky.Sdk.Sample.slnx
```

Bemerkung

- Stellen Sie sicher, dass ".csproj" auf " festgelegt ist.<ModName>' mit dem Attribut "Allgemeines Projekt" (siehe andere Beispielprojekte).
- Lange Texte werden empfohlen, mmm die dateibasierte Übersetzung zur besseren Pflege in Quellcode-Repositories zu verwenden.

beenden
