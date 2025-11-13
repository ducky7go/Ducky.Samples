<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch](../de/Ducky.PackageFromNuget/README_de.md) | [Français](../fr/Ducky.PackageFromNuget/README_fr.md) | [Español](../es-ES/Ducky.PackageFromNuget/README_es.md) | [日本語](../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](../ko/Ducky.PackageFromNuget/README_ko.md) | [Português](../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский](../ru/Ducky.PackageFromNuget/README_ru.md) | [繁體中文](../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget-Beispiel-Mod

Kurzbeschreibung

In diesem Beispiel wird gezeigt, wie NuGet-Pakete von Drittanbietern in Mods verwendet werden, wobei YamlDotNet als Beispiel verwendet wird, einschließlich Abhängigkeitsverwaltung, Zugriff auf Ressourcendateien und Bereitstellung von Abhängigkeitspaketen.

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

## 1. Projekteinführung

Dieses Verzeichnis (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) zeigt, wie die Funktionalität von Mods erweitert werden kann：

- ✅ Einführung in NuGet-Pakete von Drittanbietern
- ✅ Analysieren von Daten mithilfe externer Bibliotheken (YAML)
- ✅ Zugreifen auf die Mod-Ressourcendatei
- ✅ Automatisches Verarbeiten des Pakets von Abhängigkeiten

**Beispielszenario：** Verwenden Sie die YamlDotNet-Bibliothek, um die YAML-Konfigurationsdatei im Ordner Mod Resources zu lesen und zu analysieren.

## 2. Projektstruktur

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Projektkonfiguration
├── ModBehaviour.cs # Mod-Einstiegsklasse
"README.md
└── Vermögenswerte/
    ├── info.ini # Meta-Informationen für Mods
    ├── preview.png # Vorschaubild
    └── nice.yml # Beispiel-YAML-Datei
```

## 3. Projektkonfiguration

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2.1</TargetFramework>
    <Nullable>ermöglichen</Nullable>
    <LangVersion>Vorschau</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>alle</PrivateAssets>
      <IncludeAssets>Laufzeit; bauen; ursprünglich; content-Dateien; Analysatoren; buildtransitiv</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

Wichtige Punkte：\*\*

- Das SDK verwendet "PrivateAssets", um das Verpacken in der Ausgabe zu vermeiden
- Bibliotheken von Drittanbietern (YamlDotNet) werden automatisch in das mod-Ausgabeverzeichnis gepackt

## 4. Hinzufügen des NuGet-Pakets

### Methode 1：Verwenden der CLI (empfohlen)

```bash
cd Ducky.PackageFromNuget
dotnet Paket hinzufügen YamlDotNet
```

### Methode 2：Manuelles Bearbeiten von .csproj

In '<ItemGroup>" hinzugefügt：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Methode 3：Verwenden von Visual Studio

1. Klicken Sie mit der rechten Maustaste auf das Projekt→ NuGet-Pakete zu verwalten
2. Suche nach "YamlDotNet"
3. Klicken Sie auf "Installieren"

## 5) Beispiele für die Implementierung

### Ressourcen-Datei

['Vermögenswerte/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  title: "Schöne YAML-Konfiguration"
  description: "Dies ist eine Demonstration des Ladens von YAML aus dem Assets-Ordner eines Mods"
```

### Mod-Einstiegsklasse

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
mit Ducky.Sdk.Logging;
mit Ducky.Sdk.ModBehaviours;
mit YamlDotNet.Serialization;
mit YamlDotNet.Serialization.NamingConventions;

Namensraum Ducky.PackageFromNuget;

öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Holen Sie sich das Verzeichnis, in dem sich die Mod-Assembly befindet
        var dir = Pfad.GetDirectoryName(typeof(ModBehaviour). Montage.Ort)!;
        var ymlPath = Pfad.Kombinieren(Dir, "nice.yml");

        if (Datei.Exists(ymlPfad))
        {
            Log.Info("Gefunden nice.yml:");
            
            Verwenden von YamlDotNet zum Deserialisieren von YAML-Dateien
            var deserializer = neuer DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . Bauen();

            var ymlContent = Datei.ReadAllText(ymlPfad);
            var niceData = Deserialisierer. Deserialisieren<NiceData>(ymlContent);
            
            Log.Info($"Titel: {niceData.NiceHeader.Title}");
            Log.Info($"Beschreibung: {niceData.NiceHeader.Description}");
        }
        oder
        {
            Log.Warn("nice.yml nicht gefunden!");
        }
    }

    geschützte Überschreibung void ModDisabled()
    {
        Bereinigen von Ressourcen (falls erforderlich)
    }
}

Klasse des Datenmodells
öffentliche Klasse NiceData
{
    public NiceDateHeader NiceHeader { get; Garnitur; } = neu();

    öffentliche Klasse NiceDateHeader
    {
        public string Titel { get; Garnitur; } = Zeichenfolge. Leer;
        public string Beschreibung { get; Garnitur; } = Zeichenfolge. Leer;
    }
}
```

## 6. Zugriff auf Ressourcendateien

### Holen Sie sich den Mod-Katalog

```csharp
Methode 1：Nach Montageort (empfohlen)
var modDir = Pfad.GetDirectoryName(typeof(ModBehaviour). Montage.Ort)!;
```

### Zugreifen auf die Ressourcendatei

```csharp
assets/ wird in das Stammverzeichnis des Mod-Ausgabeverzeichnisses kopiert
var configPath = Pfad.Kombinieren(modDir, "nice.yml");
var Inhalt = Datei.ReadAllText(configPath);
```

**SDK automatisch：**

- ✅ Kopieren der DLL eines NuGet-Pakets eines Drittanbieters
- ✅ Kopieren Sie die Ressourcendatei in das Ausgabeverzeichnis
- ✅ Bereitstellen im Verzeichnis der Spielmods

## 7. Mods aktivieren

Sobald der Build erfolgreich ist, aktiviere die Mod in der Mod-Verwaltungsoberfläche des Spiels：

1. Starte das Spiel
2. Gehen Sie zur Mod-Verwaltungsoberfläche
3. Suchen Sie nach "Ducky.PackageFromNuget"
4. Klicken Sie auf Aktivieren
5. Überprüfen Sie die Spielprotokolle, und Sie sollten den analysierten YAML-Inhalt sehen

## 8) Bewährte Methoden

### ✅ Wählen Sie die richtige Bibliothek

- Bevorzugen Sie Bibliotheken, die mit .NET Standard 2.0/2.1 kompatibel sind
- Vermeiden Sie die Verwendung plattformspezifischer Bibliotheken
- Überprüfen, ob der Abhängigkeitsbaum der Bibliothek komplex ist

### ✅ Verwalten abhängiger Versionen

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Einschlägige Beispiele

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Grundlegende Projektstruktur
- [Ducky.EingangMod] (../Ducky.EntranceMod/README.md- Mehrschichtige Architektur (wenn Sie Bibliotheken von Drittanbietern freigeben müssen)
- [Dokumentation zur Vorbereitung der Umgebung] (../docs/Prequirement.md)

## 10. Zusammenfassung

Die Verwendung eines NuGet-Pakets eines Drittanbieters kann：

- ✅ Erweitern Sie schnell die Mod-Funktionen
- ✅ Vermeiden Sie es, das Rad neu zu erfinden
- ✅ Verwenden Sie eine bewährte und stabile Lösung
- ✅ Nutzen Sie Community-Ressourcen

**Notizen：**

- ⚠️ Stellen Sie sicher, dass die Bibliothek mit .NET Standard 2.1 kompatibel ist.
- ⚠️ Beachten Sie die Größe der Abhängigkeit und die Auswirkungen auf die Leistung.
- ⚠️ Guter Umgang mit Versionskonflikten
- ⚠️ Halten Sie sich an die Lizenz der Drittbibliothek
