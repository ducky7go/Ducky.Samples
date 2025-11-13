<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.TryHarmony/README.md) | [English](../../en/Ducky.TryHarmony/README_en.md) | [Deutsch](README_de.md) | [Français](../../fr/Ducky.TryHarmony/README_fr.md) | [Español](../../es-ES/Ducky.TryHarmony/README_es.md) | [日本語](../../ja/Ducky.TryHarmony/README_ja.md) | [한국어](../../ko/Ducky.TryHarmony/README_ko.md) | [Português](../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский](../../ru/Ducky.TryHarmony/README_ru.md) | [繁體中文](../../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony Beispiel-Mod

Kurzbeschreibung

Dieses Beispiel zeigt einen Mod, der HarmonyLib verwendet, um Spielcode zur Laufzeit zu patchen.Das Beispiel enthält einen einfachen Harmony-Patch (Save-Patch), der dazu führt, dass der Speichervorgang konsistent fehlschlägt (SaveFilePatch).Eintrag und Patch-Registrierung unter ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1) verwirklicht wird.

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

1. Einführung em das Projekt

Dieses Verzeichnis ('Ducky.TryHarmony/') demonstriert den Harmony-Patch-Modus：Registrieren Sie den Patch, indem Sie PatchAll von Harmony in ModEnabled aufrufen, und brechen Sie den Patch in ModDisabled ab.Wir sehen uns in Schlüsselverwirklichungen：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Projektunterlagen：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

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

Die Hauptfunktion von 'SaveFilePatch' besteht darin, den Speichervorgang konsistent fehlschlagen zu lassen, um den Patch-Effekt und den Fehlerbehandlungsprozess leichter zu demonstrieren.Dieses Patch-Beispiel fängt die speicherbezogene Methode ab und gibt einen Fehler zurück (siehe ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. Betrieb und Prüfung

- Erstellen des Projekts：

```bash
dotnet construir Ducky.TryHarmony/
```

- Mods aktivieren (Builds im Mod-Katalog des Spiels bereitstellen und im Spiel aktivieren)
- Der Versuch, einen Spielstand im Spiel zu speichern, führt zu einer Meldung "Spielstand fehlgeschlagen", was darauf hinweist, dass der Patch in Kraft ist.

5. Häufige Überlegungen

- Vergewissern Sie sich, dass "IncludeHarmony" auf "true" festgelegt ist, da sonst der Harmony-bezogene Code nicht funktioniert.
- Beim Debuggen eines Patches können Sie ein Protokoll (mit Ducky.Sdk.Logging.Log) zu 'ModBehaviour' hinzufügen, um zu überprüfen, ob 'PatchAll()'/'UnpatchAll()' aufgerufen wird.
