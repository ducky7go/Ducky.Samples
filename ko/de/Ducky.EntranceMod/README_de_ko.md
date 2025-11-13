<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.EntranceMod/README.md) | [English](../../en/Ducky.EntranceMod/README_en.md) | [Deutsch](README_de.md) | [Français](../../fr/Ducky.EntranceMod/README_fr.md) | [Español](../../es-ES/Ducky.EntranceMod/README_es.md) | [日本語](../../ja/Ducky.EntranceMod/README_ja.md) | [한국어](../../ko/Ducky.EntranceMod/README_ko.md) | [Português](../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский](../../ru/Ducky.EntranceMod/README_ru.md) | [繁體中文](../../zh-TW/Ducky.EntranceMod/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod Beispiel-Mod

쿠르츠베슈라이붕

Dieses Beispiel zeigt, wie Mods mithilfe eines mehrschichtigen Architekturmusters entwickelt werden, um gemeinsam genutzten Code in separate Bibliotheksprojekte für die Wiederverwendung von Code und modulares Design zu unterteilen.Geeignet für große Mods oder Szenarien, in denen Code von mehreren Mods gemeinsam genutzt werden muss.

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

## 1. Projekteinführung

Dieses Beispiel besteht aus zwei Elementen：

- **Haupt-Mod-Projekt** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Mod-Eingang mit Ressourcendateien
- **Projekt einer öffentlichen Bibliothek** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Gemeinsame Codebasis

Dieses Architekturmuster gilt：

- Große Mods erfordern eine hierarchische Verwaltung
- Mehrere Mods haben eine gemeinsame Logik
- Gemeinsame Entwicklung im Team
- Die Geschäftslogik muss unabhängig getestet werden

## 2. Projektstruktur

```
Ducky.EntranceMod/ # Haupt-Mod-Projekt
├── Ducky.EntranceMod.csproj # Projektkonfiguration
├── ModBehaviour.cs # Mod-Einstiegsklasse
"README.md
└── assets/ # Verzeichnis der Ressourcendatei
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Gebietsschemata/
        ├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/ # Projekt für öffentliche Bibliotheken
├── Ducky.EntranceMod.Common.csproj # Konfiguration des Bibliotheksprojekts
├── LK.cs # Lokalisierungsschlüssel freigeben
└── MyModBase.cs # Gemeinsame Basisklasse
```

## 3. Konfiguration des Haupt-Mod-Projekts

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1) Tastenkonfiguration：

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

- \\`<ExcludeSdkLib>STIMMT</ExcludeSdkLib>- Vermeiden Sie das doppelte Verpacken von SDK-Bibliotheken in das Ausgabeverzeichnis

## 4. Projektkonfiguration für öffentliche Bibliotheken

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1) Tastenkonfiguration：

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

- \\`<IsModLib>STIMMT</IsModLib>' - Markieren Sie diesen Artikel als Mod-Bibliothek, das SDK wird ihn speziell behandeln
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
    Eine universelle Methode für das Teilen von Mods kann hier hinzugefügt werden
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

Gemeinsame Basisklasse für Vererbung
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

### ✅ Wiederverwendung von Code

- Mehrere Mods können sich die Bibliothek 'Ducky.EntranceMod.Common' teilen
- Vermeiden Sie Code-Duplizierung und verbessern Sie die Wartbarkeit

### ✅ Modulbauweise

- Die Geschäftslogik ist vom Mod-Eingang entkoppelt
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

Das SDK verarbeitet automatisch Abhängigkeiten von mehreren Projekten：

```bash
# Erstellen der gesamten Lösung (empfohlen)
dotnet build Docky.Sdk.Sample.slnx

# oder erstellen Sie das Hauptprojekt separat (wodurch das abhängige Bibliotheksprojekt automatisch erstellt wird)
dotnet build Ducky.EntranceMod/
```

Produkte entwickeln：\*\*

- Die Haupt-Mod-Assembly + die Assembly der öffentlichen Bibliothek wird zusammen gepackt
- Die Ressourcendatei wird aus dem Verzeichnis "assets/" des Hauptprojekts abgerufen
- SDK-Bibliotheken werden nicht wiederholt eingebunden (weil '<ExcludeSdkLib>STIMMT</ExcludeSdkLib>\\`）

## 8. Mods aktivieren

Sobald die Mods erstellt sind, werden sie automatisch in den Spielekatalog aufgenommen：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── Vermögenswerte/
    ├── info.ini
    ├── lkeys.json
    └── Gebietsschemata/</游戏目录>
```

Aktiviere den Mod in der Mod-Verwaltungsoberfläche des Spiels.

## 9. Empfehlungen zur Erweiterung

### Erstellen Sie mehr öffentliche Bibliotheken

Bei komplexen Projekten können Sie mehrere öffentliche Bibliotheken erstellen：

```
Ducky.EntranceMod/ # Meister Mod
Ducky.EntranceMod.Common/ # Universeller Code
Ducky.EntranceMod.Gameplay/ # Logik des Gameplays
Ducky.EntranceMod.UI/ # UI-bezogen
```

## 10. Häufig gestellte Fragen

### F: Warum wird "<ExcludeSdkLib>STIMMT</ExcludeSdkLib>\\`？

A: Vermeiden Sie das doppelte Packen der Bibliotheksdateien von Ducky.Sdk in das mod-Ausgabeverzeichnis.Die SDK-Bibliothek ist bereits im Spiel vorhanden und muss nicht erneut eingebunden werden.

### Q: \\`<AssetsDir>Müssen Sie es einstellen?

A: Wenn Sie bei Projekten in öffentlichen Bibliotheken einen Lokalisierungsschlüssel (LK.cs) einschließen, müssen Sie '<AssetsDir>Verweist auf das Assets-Verzeichnis des Hauptprojekts, damit das SDK lokalisierte Metadaten ordnungsgemäß generieren kann.

### F: Können sich mehrere Hauptmod-Projekte dieselbe öffentliche Bibliothek teilen?

A: Ja!Dies ist der Vorteil von mehrstufigen Architekturen.Mehrere Mods können auf dasselbe öffentliche Bibliotheksprojekt verweisen.

### F: Wo wird der Lokalisierungsschlüssel für öffentliche Bibliotheken generiert?

A: Es wird '<AssetsDir>' angegebenes Verzeichnis, d.h. die Datei 'lkeys.json' im Verzeichnis 'assets/' des Hauptprojekts.

## 11. Verwandte Ressourcen

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Referenz für den Einzelelementmodus
- [Ducky.Lokalisierung] (../Ducky.Localization/README.md- Detaillierte Erläuterung des Lokalisierungssystems
- [Dokumentation zur Vorbereitung der Umgebung] (../docs/Prequirement.md)

## 12. Zusammenfassung

Das mehrschichtige Architekturmuster eignet sich：

- ✅ Große Mod-Projekte
- ✅ Szenarien, in denen die Wiederverwendung von Code erforderlich ist
- ✅ Gemeinsame Entwicklung im Team
- ✅ Entwicklung von Serien-Mods

Wenn Ihr Mod relativ einfach ist, wird empfohlen, mit [Ducky.SingleProject](../Ducky.SingleProject/README.md) für ein einzelnes Projekt.
