<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.EntranceMod/README.md) | [Englisch] (../../en/Ducky.EntranceMod/README_en.md) | [English] (../../de/Ducky.EntranceMod/README_de.md) | [Français] (../../fr/Ducky.EntranceMod/README_fr.md) | [Español] (../../es-ES/Ducky.EntranceMod/README_es.md) | [Japanisch] (../../ja/Ducky.EntranceMod/README_ja.md) | [한국어] (../../ko/Ducky.EntranceMod/README_ko.md) | [Português] (../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский] (../../ru/Ducky.EntranceMod/README_ru.md) | [Traditionelles Chinesisch] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod Beispiel-Mod

簡要說明

Dieses Beispiel zeigt, wie Mods mit einem mehrschichtigen Architekturmuster entwickelt werden, wie gemeinsam genutzter Code in unabhängige Bibliotheksprojekte unterteilt wird und wie die Wiederverwendung von Code und das modulare Design erreicht werden.Geeignet für große Mods oder Szenarien, in denen Code von mehreren Mods gemeinsam genutzt werden muss.

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

## 1. Einführung in das Projekt

Dieses Beispiel besteht aus zwei Elementen：

- **Main Mod Project** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Mod-Eintrag mit Ressourcendateien
- **Öffentliches Bibliotheksprojekt** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Gemeinsame Codebasis

Dieses Architekturmuster gilt：

- Große Mods erfordern eine hierarchische Verwaltung
- Mehrere Mods teilen sich eine gemeinsame Logik
- Kollaborative Entwicklung im Team
- Die Geschäftslogik muss unabhängig getestet werden

## 2. Projektstruktur

```
Ducky.EntranceMod/ # Haupt-Mod-Projekt
├── Ducky.EntranceMod.csproj # Projektkonfiguration
├── ModBehaviour.cs # Mod-Eingang
"README.md
└── assets/ # Verzeichnis des Ressourcendokuments
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Gebietsschemata/
        ├── zh.csv
        └── en.csv

ducky.EntranceMod.Common/ # Projekt für öffentliche Bibliotheken
├── Ducky.EntranceMod.Common.csproj # Konfiguration des Bibliotheksprojekts
├── LK.cs # Lokalisierungsschlüssel freigeben
└── MyModBase.cs # Gemeinsame Basisklasse
```

## 3. Konfiguration des Haupt-Mod-Projekts

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1).：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2.1</TargetFramework>
    <Nullable>ermöglichen</Nullable>
    <LangVersion>Vorschau</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>STIMMT</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>alle</PrivateAssets>
      <IncludeAssets>Laufzeit; bauen; ursprünglich; content-Dateien; Analysatoren; buildtransitiv</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**Beschreibung der Kernkonfiguration：**

- \\`<ExcludeSdkLib>STIMMT</ExcludeSdkLib>- Vermeiden Sie das wiederholte Verpacken von SDK-Bibliotheken in das Ausgabeverzeichnis

## 4. Projektkonfiguration für öffentliche Bibliotheken

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1).：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2.1</TargetFramework>
    <Nullable>ermöglichen</Nullable>
    <LangVersion>Vorschau</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>STIMMT</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/Vermögenswerte</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>alle</PrivateAssets>
      <IncludeAssets>Laufzeit; bauen; ursprünglich; content-Dateien; Analysatoren; buildtransitiv</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**Beschreibung der Kernkonfiguration：**

- \\`<IsModLib>STIMMT</IsModLib>' - Markieren Sie diesen Gegenstand als Mod-Bibliothek, und das SDK wird ihn speziell handhaben
- \\`<AssetsDir>' - Zeigt auf das Assets-Verzeichnis des Hauptprojekts, damit der Lokalisierungsschlüssel korrekt generiert wird.

## 5. Teilen Sie Codebeispiele

### Freigeben von Lokalisierungsschlüsseln

['Ducky.EntranceMod.Common/LK.cs'] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
Namensraum Ducky.EntranceMod.Common;

öffentliche statische Klasse LK
{
    Benutzeroberfläche der öffentlichen statischen Klasse
    {
        public const string NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### Freigegebene Basisklassen

['Ducky.EntranceMod.Common/MyModBase.cs'] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
mit Ducky.Sdk.ModBehaviours;

Namensraum Ducky.EntranceMod.Common;

öffentliche abstrakte Klasse MyModBase : ModBehaviourBase
{
    Eine gemeinsame Methode, die von allen Mods gemeinsam genutzt wird, kann hier hinzugefügt werden
    protected virtual void LogModInfo(Zeichenfolge, Nachricht)
    {
        Log.Info($"[{GetType(). Vorname}] {message}");
    }
}
```

### Der Hauptmod verwendet einen gemeinsam genutzten Code

['Ducky.EntranceMod/ModBehaviour.cs'] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
mit Ducky.Sdk.Logging;
mit Ducky.EntranceMod.Common;

Namensraum Ducky.EntranceMod;

Erben der allgemeinen Basisklasse
öffentliche Klasse ModBehaviour : MyModBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Log.Info("Mod aktiviert");
        Verwenden eines freigegebenen Lokalisierungsschlüssels
        var Nachricht = LK. BENUTZEROBERFLÄCHE. NiceWelcomeMessage;
        LogModInfo($"Schlüssel für die Begrüßungsnachricht: {message}");
    }

    geschützte Überschreibung void ModDisabled()
    {
        Log.Info("Mod deaktiviert");
    }
}
```

## 6. Vorteile der Multi-Layer-Architektur

### ✅ Code-Multiplexing

- Mehrere Mods können sich die Bibliothek 'Ducky.EntranceMod.Common' teilen
- Vermeiden Sie Code-Duplizierung und verbessern Sie die Wartbarkeit

### ✅ Modulbauweise

- Die Geschäftslogik ist vom Mod-Eintrag getrennt
- Einfacher Unit-Test
- Klare Abhängigkeiten

### ✅ Zusammenarbeit im Team

- Verschiedene Entwickler können unabhängig voneinander unterschiedliche Schichten entwickeln
- Reduzieren von Codekonflikten
- Einfache Code-Überprüfung

### ✅ Lokalisierte Freigabe

- Öffentliche Bibliotheken können gemeinsam genutzte Lokalisierungsschlüssel definieren
- Alle Mods, die die Bibliothek verwenden, werden automatisch für die Übersetzung unterstützt

## 7. Bauen Sie den Prozess auf

Das SDK verarbeitet automatisch Abhängigkeiten von mehreren Elementen：

```bash
# Erstellen der gesamten Lösung (empfohlen)
dotnet build Docky.Sdk.Sample.slnx

# oder erstellen Sie das Hauptprojekt separat (das abhängige Bibliotheksprojekt wird automatisch erstellt)
dotnet build Ducky.EntranceMod/
```

**Produkte erstellen：**

- Das Haupt-Mod-Set + die Assembly der öffentlichen Bibliothek werden zusammen verpackt
- Die Ressourcendatei wird aus dem Verzeichnis "assets/" des Hauptprojekts abgerufen
- SDK-Bibliotheken werden nicht wiederholt eingebunden (da die '<ExcludeSdkLib>STIMMT</ExcludeSdkLib>\\`）

## 8. Mods aktivieren

Sobald die Mods erstellt sind, werden sie automatisch in den Spielekatalog aufgenommen：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── assets/
    ├── info.ini
    ├── lkeys.json
    └── Locales/</游戏目录>
```

Aktiviere den Mod in der Mod-Verwaltungsoberfläche des Spiels.

## 9. Vorschläge zur Erweiterung

### Erstellen Sie mehr öffentliche Bibliotheken

Für komplexe Projekte können mehrere öffentliche Bibliotheken erstellt werden：

```
Ducky.EntranceMod/ # Meister Mod
Ducky.EntranceMod.Common/ # Universeller Code
Ducky.EntranceMod.Gameplay/ # Logik des Gameplays
Ducky.EntranceMod.UI/ # UI-bezogen
```

## 10. Häufig gestellte Fragen

### Q： Warum setzen Sie '<ExcludeSdkLib>STIMMT</ExcludeSdkLib>\\`？

Ein： Vermeiden Sie das doppelte Packen der Bibliotheksdateien von Ducky.Sdk in das mod-Ausgabeverzeichnis.Die SDK-Bibliothek ist bereits im Spiel vorhanden und muss nicht erneut eingebunden werden.

### Q: \\`<AssetsDir>Ist es notwendig, es einzustellen?

Ein： Wenn bei Projekten in öffentlichen Bibliotheken ein Lokalisierungsschlüssel (LK.cs) enthalten ist, wird die '<AssetsDir>' in das assets-Verzeichnis des Hauptprojekts ein, damit das SDK lokalisierte Metadaten ordnungsgemäß generieren kann.

### Q： Können sich mehrere Hauptmod-Projekte dieselbe öffentliche Bibliothek teilen?

Ein： OKAY!Dies ist der Vorteil von mehrstufigen Architekturen.Mehrere Mods können auf dasselbe öffentliche Bibliotheksprojekt verweisen.

### Q： Wo wird der Lokalisierungsschlüssel für die öffentliche Bibliothek generiert?

Ein： wird "<AssetsDir>' im angegebenen Verzeichnis, d.h. in der Datei 'lkeys.json' im Verzeichnis 'assets/' des Masterprojekts.

## 11. Verwandte Ressourcen

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) – Eine Musterreferenz für ein einzelnes Projekt
- [Ducky.Lokalisierung] (.. /Ducky.Localization/README.md) - Detaillierte Erklärung des Lokalisierungssystems
- [Dokument zur Vorbereitung der Umwelt] (../docs/Prequirement.md)

## 12. Zusammenfassung

Das mehrschichtige Architekturmuster eignet sich：

- ✅ Große Mod-Projekte
- ✅ Szenarien, die eine Wiederverwendung von Code erfordern
- ✅ Kollaborative Entwicklung im Team
- ✅ Entwicklung von Serien-Mods

Wenn Ihr Mod relativ einfach ist, empfehlen wir die Verwendung von [Ducky.SingleProject](.. /Ducky.SingleProject/README.md) im Einzelprojektmodus.
