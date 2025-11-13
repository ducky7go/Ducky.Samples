<!-- LANG_HEADER_START -->
| [简体中文](../README.md) | [English](../en/README_en.md) | [Deutsch](README_de.md) | [Français](../fr/README_fr.md) | [Español](../es-ES/README_es.md) | [日本語](../ja/README_ja.md) | [한국어](../ko/README_ko.md) | [Português](../pt-PT/README_pt.md) | [Русский](../ru/README_ru.md) | [繁體中文](../zh-TW/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Sammlung von Ducky SDK-Beispielprojekten

[! [Bauen] (https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.NET] (https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [NuGet] (https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [Lizenz] (https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [Plattform] (https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [Sprache] (https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! [Ziel] (https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [Probleme] (https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [Pull-Anfragen] (https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [Letzter Commit] (https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

Dieses Repository enthält mehrere Beispielprojekte, um die Entwicklung des Mods "Escape from Duckov" mit [Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk) ein.

## 📋 Bereit

Bevor Sie beginnen, stellen Sie sicher, dass Ihre Entwicklungsumgebung bereit ist：

👉 [Dokumentation zur Vorbereitung der Umgebung anzeigen](docs/Prequirement.md)\*\*

Hauptanforderungen:：

- .NET SDK 10.x
- Globales Werkzeug：'dotnet-script'、'dotnet-ilrepack'
- Unterstützte Betriebssysteme：Windows / Linux / macOS

## 🎯 Schneller Einstieg

```bash
# Klonen Sie das Repository
git-Klon <repository-url>
cd Hörproben

# Alle Beispiele erstellen
dotnet build Docky.Sdk.Sample.slnx

# oder erstellen Sie ein einzelnes Beispiel
dotnet build Ducky.SingleProject/
```

## 📚 Beispielhafte Projekttour

Dieses Repositorium organisiert die Beispiele in der Reihenfolge von leicht bis schwierig, und es wird empfohlen, in der folgenden Reihenfolge zu studieren：

### 1️⃣ Einsteiger - grundlegende Konzepte

#### [Ducky.SingleProject] (Ducky.SingleProject/- Der einfachste Mod

**Schwierigkeit：⭐**

Das einfachste Beispiel für einen Einzelgegenstand, geeignet für absolute Anfänger.

- ✅ Struktur mit nur einem Element
- ✅ Mod-Lebenszyklus ('ModEnabled' / 'ModDisabled')
- ✅ Grundlegende Protokollierung
- ✅ Projektkonfiguration und -konstruktion

Wichtige Punkte, die Sie lernen sollten：\*\*

- So erstellen Sie einen minimal funktionsfähigen Mod
- ['ModVerhalten'] (Ducky.SingleProject/ModBehaviour.cs) Ingress-Klasse
- Die grundlegende Konfiguration der Datei ".csproj"

**Geeignet für Menschen：** Entwickler, die neu im Ducky SDK sind

👉 [Ausführliches Tutorial anzeigen](Ducky.SingleProject/README.md)

---

#### [Ducky.InstantKill] (Ducky.InstantKill/- Behandlung von Spielereignissen

**Schwierigkeit：⭐⭐**

Veranschaulicht, wie Spielereignisse abonniert und einfache Änderungen an der Spiellogik implementiert werden.

- ✅ Abonnement für Spielereignisse ("Health.OnHurt")
- ✅ Implementierung des Event-Handlers
- ✅ Ressourcenmanagement über den gesamten Lebenszyklus

Wichtige Punkte, die Sie lernen sollten：\*\*

- So lauschen Sie auf Ereignisse im Spiel
- Sicheres Abonnieren und Abmelden von Ereignissen
- ['DamageInfo'] (Ducky.InstantKill/ModBehaviour.cs) und andere Spiel-APIs

**Geeignet für Menschen：** Entwickler, die die grundlegende Mod-Struktur verstehen und Spiellogik implementieren wollen

👉 [Ausführliches Tutorial anzeigen](Ducky.InstantKill/README.md)

---

### 2️⃣ Fortgeschrittene Stufe - Kernfunktionen

#### [Ducky.Lokalisierung] (Ducky.Localization/- Mehrsprachige Lokalisierung

**Schwierigkeit：⭐⭐⭐**

Ein vollständiges Beispiel für ein Lokalisierungssystem mit mehrsprachiger Unterstützung und dateibasierter Übersetzung.

- ✅ Lokalisierte Schlüsseldefinition(['LK.cs'](Ducky.Localization/LK.cs)）
- ✅ CSV-Übersetzungsdatei
- ✅ Übersetzung von Dokumenten (Markdown)
- ✅ Mehrsprachige Unterstützung (vereinfachtes Chinesisch und Englisch)

Wichtige Punkte, die Sie lernen sollten：\*\*

- So organisieren Sie Lokalisierungsschlüssel
- Nutzung der Funktionen '[LanguageSupport]' und '[TranslateFile]'
- SDK automatisch generierte "lkeys.json" und "keys.hash.txt"
- Laufzeitzugriff auf Übersetzungszeichenfolgen

**Geeignet für Menschen：** Entwickler, die mehrsprachige Mods entwickeln müssen

👉 [Ausführliches Tutorial anzeigen](Ducky.Localization/README.md)

---

#### [Ducky.BuffRegistrierung] (Ducky.BuffRegistration/) - Benutzerdefinierte Spielentitäten

\*\*Schwierigkeit：⭐⭐⭐

Zeigt, wie Sie benutzerdefinierte Buffs registrieren und in Ihr Spielsystem integrieren.

- ✅ Verwenden Sie 'Contract.Buffs.RegisterBuff', um den Buff zu registrieren
- ✅ Behandlung von Szenenereignissen ('SceneLoader.onAfterSceneInitialize')
- ✅ Erstellen und Hinzufügen von Buff-Instanzen
- ✅ Lokalisieren des Buff-Namens und der Beschreibung

Wichtige Punkte, die Sie lernen sollten：\*\*

- So erweitern Sie das Kernsystem des Spiels
- Verwendungsmuster der Vertrags-API
- Lebenszyklus-Management von Szenarien
- Konfiguration und Registrierung von Spielentitäten

**Geeignet für Menschen：** Entwickler, die benutzerdefinierte Spielinhalte hinzufügen möchten

👉 [Ausführliches Tutorial anzeigen](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/- Verwaltung von Abhängigkeiten von Drittanbietern

**Schwierigkeit：⭐⭐⭐**

Veranschaulicht die Verwendung von NuGet-Paketen in Mods (am Beispiel von YamlDotNet).

- ✅ Einführung in NuGet-Pakete von Drittanbietern
- ✅ Lesen und Analysieren von Ressourcendateien
- ✅ Abhängiges Packen und Bereitstellen

Wichtige Punkte, die Sie lernen sollten：\*\*

- So verwenden Sie externe Bibliotheken in Mods
- Der Zugriffspfad der Ressourcendatei
- Der Mechanismus zur Behandlung von Abhängigkeiten des SDK

**Geeignet für Menschen：** Entwickler, die ihre Funktionalität mit Bibliotheken von Drittanbietern erweitern müssen

---

### 3️⃣ Fortgeschritten - Komplexer Modus

#### [Ducky.EingangMod] (Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/- Mehrstufige Architektur

**Schwierigkeit：⭐⭐⭐⭐**

Zeigt, wie Mods für die Wiederverwendung von Code in mehrschichtige Architekturen aufgeteilt werden.

- ✅ Das Hauptmod-Projekt ist von der öffentlichen Bibliothek getrennt
- ✅ \`<ExcludeSdkLib>" und "<IsModLib>'-Konfiguration
- ✅ Lokalisierungsschlüssel projektübergreifend freigeben
- ✅ Verwaltung von Projektreferenzen

Wichtige Punkte, die Sie lernen sollten：\*\*

- Organisation von Multiprojektlösungen
- So erstellen Sie eine wiederverwendbare Mod-Bibliothek
- Projektübergreifendes Teilen von Ressourcendateien
- Architekturdesign für große Mods

**Geeignet für Menschen：** Teams, die große oder Serien-Mods entwickeln

---

#### [Ducky.TryHarmony] (Ducky.TryHarmony/- Laufzeit-Code-Injektion

**Schwierigkeit：⭐⭐⭐⭐⭐**

Verwenden Sie HarmonyLib, um Spielcode zur Laufzeit für die tiefgreifendsten Spieländerungen zu patchen.

- ✅ Harmony Patching-System
- ✅ Präfix/Suffix/Ersetzen der Methode
- ✅ Patch-Registrierung und -Bereinigung
- ✅ API-Zugriff im Spiel

Wichtige Punkte, die Sie lernen sollten：\*\*

- Grundlegende Verwendung von HarmonyLib
- Wie schreibe ich Präfix/Postfix-Patches?
- Best Practices für die Änderung von Laufzeitcode
- Lifecycle-Management von Patches

**Beispiel：** ['SaveFilePatch'](Ducky.TryHarmony/SaveFilePatch.csVeranschaulicht, wie Archivierungsvorgänge abgefangen werden

**Geeignet für Menschen：** Fortgeschrittene Entwickler, die die Spiellogik grundlegend ändern müssen

⚠️ **Anmerkung.：** Harmony-Patches sind mächtig, sollten aber mit Vorsicht verwendet werden, und falsche Patches können zum Absturz des Spiels führen

👉 [Ausführliches Tutorial anzeigen](Ducky.TryHarmony/README.md)

---

## 🏗️ Projektarchitektur

Alle Beispielprojekte folgen den folgenden Kernkonventionen：

### Projektkonfiguration (erforderlich)

```xml
<PropertyGroup>
  <TargetFramework>Netzstandard2.1</TargetFramework>
  <Nullable>ermöglichen</Nullable>
  <LangVersion>Vorschau</LangVersion>
  <ImplicitUsings>STIMMT</ImplicitUsings>
  <ModName>IhrModName</ModName>
</PropertyGroup>
```

### Einstiegspunkt für Mods

```csharp
öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Initialisierungslogik, wenn der Mod aktiviert ist
    }

    geschützte Überschreibung void ModDisabled()
    {
        Aufräumlogik, wenn der Mod deaktiviert ist
    }
}
```

### Struktur der Ressourcendatei

```
Vermögen/
├── info.ini # Meta-Informationen für Mods
├── description.md # Detaillierte Beschreibung (optional)
├── preview.png # Vorschau (optional)
lkeys.json # Checkliste für die Lokalisierung (automatisch generiert)
├── keys.hash.txt # Validierungs-Hash (automatisch generiert)
└── Gebietsschemata/
    ├── zh.csv # Vereinfachte Übersetzung Chinesisch
    ├── en.csv # Englische Übersetzung
    └── de/ # Dokumentenbasierte Übersetzung
        └── *.md
```

## 📖 Empfehlungen für Lernpfade

### Pfad für Anfänger

1. [Ducky.SingleProject] (Ducky.SingleProject/- Verstehen der Infrastruktur
2. [Ducky.InstantKill] (Ducky.InstantKill/- Erlernen des Umgangs mit Vorfällen
3. [Ducky.Lokalisierung] (Ducky.Localization/- Master-Lokalisierung
4. [Ducky.BuffRegistrierung] (Ducky.BuffRegistration/) - Erweitert den Spielinhalt

### Erweiterter Pfad

1. [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/) - Verwenden Sie Bibliotheken von Drittanbietern
2. [Ducky.EingangMod] (Ducky.EntranceMod/- Design einer mehrschichtigen Architektur
3. [Ducky.TryHarmony] (Ducky.TryHarmony/- Laufzeit-Code-Injektion

## 🛠️ Erstellen und Bereitstellen

### Build-Befehle

```bash
# Alle Projekte erstellen
dotnet build Docky.Sdk.Sample.slnx

# Erstellen Sie ein einzelnes Projekt
dotnet build Ducky.SingleProject/

# Bereinigen Sie den Build
dotnet clean
```

### Automatisierte Bereitstellung

Das SDK stellt Mods zur Build-Zeit automatisch im Spielverzeichnis bereit (erfordert die Konfiguration von "local.props" oder die Einstellung von ".csproj")<SteamFolder>`/`<DuckovFolder>\`）：

```xml
<PropertyGroup>
  <SteamFolder>C:\Programme (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 Projektspezifikationen

- **Format der Lösung**：Verwenden Sie das neue XML-Format ".slnx"
- **Code-Analyse**：Das integrierte SDK-Analysetool überprüft die Projektstruktur
- **Automatische Generierung**：Lokalisierte Metadaten werden zur Kompilierzeit automatisch generiert

## 🔗 Verwandte Ressourcen

- [Ducky.Sdk NuGet-Paket] (https://www.nuget.org/packages/Ducky.Sdk)
- [Steam-Seite des Spiels] (https://store.steampowered.com/app/XXXXX(ersetzt durch tatsächlichen Link)
- [Entwickler-Dokumentation] (docs/)

## 🤝 Richtlinien für Beiträge

Fühlen Sie sich frei, Issues und Pull Requests einzureichen, um das Beispielprojekt zu verbessern!

## 📄 Erlauben.

In diesem Projekt wird [LICENSE(LIZENZ).

---

**Viel Spaß bei der Entwicklung!🎮**
