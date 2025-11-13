<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.TryHarmony/README.md) | [Englisch] (../../en/Ducky.TryHarmony/README_en.md) | [English] (../../de/Ducky.TryHarmony/README_de.md) | [Français] (../../fr/Ducky.TryHarmony/README_fr.md) | [Español] (../../es-ES/Ducky.TryHarmony/README_es.md) | [Japanisch] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Português] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Traditionelles Chinesisch] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony Beispiel-Mod

簡要說明

Dieses Beispiel veranschaulicht die Verwendung von HarmonyLib zum Patchen eines Mods für Spielcode zur Laufzeit.Das Beispiel enthält einen einfachen Harmony-Patch (Save-Patch), der dazu führt, dass der Speichervorgang ständig fehlschlägt (SaveFilePatch).Die Eintrags- und Patch-Registrierung ist in ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1) implementiert.

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

Dieser Katalog ('Ducky. TryHarmony/') demonstriert den Harmony-Patch-Modus：Registrieren Sie den Patch, indem Sie Harmonys PatchAll in ModEnabled aufrufen und den Patch in ModDisabled abbrechen.Wir sehen uns in Schlüsselverwirklichungen：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Projektdatei：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Aktivieren von Harmony in csproj

Um den Harmony-Patch zu verwenden, aktivieren Sie die IncludeHarmony-Eigenschaft in 'Ducky.TryHarmony.csproj'.Zum Beispiel：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2.1</TargetFramework>
    <Nullable>ermöglichen</Nullable>
    <LangVersion>Vorschau</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>STIMMT</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. SaveFilePatch (englisch)

Die Hauptfunktion von 'SaveFilePatch' besteht darin, dass Speichervorgänge (Save Game) konsistent fehlschlagen, was es einfacher macht, den Patch-Effekt und den Fehlerbehandlungsprozess zu demonstrieren.Das Patch-Beispiel fängt die speicherbezogene Methode ab und gibt einen Fehler zurück (siehe ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)).

4. Ausführen und Testen

- Projekte erstellen：

```bash
dotnet build Ducky.TryHarmony/
```

- Mods öffnen (Builds im Mod-Katalog des Spiels bereitstellen und im Spiel öffnen)
- Der Versuch, einen Spielstand im Spiel zu speichern, führt zu einer Meldung "Speichern fehlgeschlagen", die anzeigt, dass der Patch aktiv ist.

5. Allgemeine Vorsichtsmaßnahmen

- Vergewissern Sie sich, dass "IncludeHarmony" auf "true" festgelegt ist, da sonst der Harmony-bezogene Code nicht ordnungsgemäß funktioniert.
- Beim Debuggen von Patches kann ein Protokoll zu 'ModBehaviour' hinzugefügt werden (mit 'Ducky.Sdk.Logging.Log'), um zu überprüfen, ob 'PatchAll()'/'UnpatchAll()' aufgerufen wird.
