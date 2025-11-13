<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.Localization/README.md) | [영어] (../../en/Ducky.Localization/README_en.md) | [도이치] (README_de.md) | [프랑세] (../../fr/Ducky.Localization/README_fr.md) | [스페인어] (../../es-ES/Ducky.Localization/README_es.md) | [일본어] (../../ja/Ducky.Localization/README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Localization Beispiel-Mod

쿠르츠베슈라이붕

Dieses Beispiel zeigt, wie man Lokalisierungsschlüssel in einem eigenständigen Mod definiert und organisiert und wie man Übersetzungen in Assets für die Laufzeitnutzung einfügt. Eintrags- und Schlüsseldefinitionen werden in ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) mit ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Bevor Sie beginnen

Bitte lesen und bereiten Sie zuerst Ihre Entwicklungsumgebung vor：['문서/Prequirement.md'] (문서/Prequirement.md:1)。

Projektstruktur (Kernpunkte)

- ['Ducky.Localization/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — Mod-Eintrag, der zeigt, wie lokalisierte Zeichenketten referenziert werden.
- ['Ducky.Localization/LK.cs'] (Ducky.Localization/LK.cs:1) — Statische, lokalisierte Schlüsseldefinitionen (es wird empfohlen, sie im Code zu verwalten).
- ['Ducky.Lokalisierung/자산/'] (Ducky.Localization/assets/:1) – Enthält Ressourcen wie CSV-Übersetzungsdateien, dokumentenbasierte Übersetzungen und Beschreibungen.

Lokalisierungsschlüssel (LK.cs)

- ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) unter Verwendung statischer konstanter Organisationsschlüssel (z. B.：UI-Klassifikation)을 사용합니다.
- Langer Text kann mit der Anmerkung '[TranslateFile("md)]]' (die 'assets/Locales/ generiert) als Datei übersetzt werden.{lang}/' der Datei).
- Um eine unterstützte Sprache zu deklarieren, verwenden Sie das Attribut [LanguageSupport("en","en","zh-hant")]' (falls gewünscht).

Übersetzen von Dateien und Generieren

- CSV übersetzen：'Vermögenswerte/Gebietsschemata/{lang}.csv" im Format Schlüssel, Wert.
- Dokumentenbasierte Übersetzung：'assets/locales/ 의 Abgelegt{lang}/', CSV-Median wird durch den Dateinamen referenziert, z.B.：'"ducky.singleproject.ui.longdescription.md"'。
- "assets/lkeys.json" und "assets/keys.hash.txt" werden von MSBuild des SDK zur Kompilierzeit für die Laufzeitpositionierung und Paketierungsüberprüfungen generiert, bearbeiten Sie sie Daher bitte nicht manuell.

Empfohlene 워크플로

- Hinzufügen oder Ändern von Schlüsseln in Ihrem Code (empfohlen)：베어베이텐 ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) und kompilieren, und das SDK aktualisiert die Übersetzungsmetadaten.
- Oder bearbeiten Sie 'assets/locales/ direkt'{lang}.csv" und kompilieren Sie neu, damit das SDK die Änderungen integrieren kann.

안웬둥스베이스피엘레

```csharp
mit Ducky.Sdk.Localizations;
var message = L.UI입니다. NiceWelcomeMessage입니다. Löst zur Laufzeit eine Übersetzung der aktuellen Sprache auf
```

Erstellen und Ausführen

```bash
dotnet build Ducky.Localization/
# oder erstellen Sie die gesamte Lösung
dotnet build Docky.Sdk.Sample.slnx
```

베메르쿵

- Stellen Sie sicher, dass ".csproj" auf " festgelegt ist.<ModName>' mit dem Attribut "Allgemeines Projekt" (siehe andere Beispielprojekte).
- Lange Texte werden empfohlen, um die dateibasierte Übersetzung zur besseren Pflege in Quellcode-Repositories zu verwenden.

벤덴
