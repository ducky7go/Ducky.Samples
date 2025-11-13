<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.PackageFromNuget/README.md) | [영어] (../../en/Ducky.PackageFromNuget/README_en.md) | [도이치] (README_de.md) | [프랑세] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [스페인어] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [일본어] (../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget-Beispiel-모드

쿠르츠베슈라이붕

In diesem Beispiel wird gezeigt, wie NuGet-Pakete von Drittanbietern in Mods verwendet werden, wobei YamlDotNet als Beispiel verwendet wird, einschließlich Abhängigkeitsverwaltung, Zugriff auf Ressourcendateien und Bereitstellung von Abhängigkeitspaketen.

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

## 1. 프로젝트

Dieses Verzeichnis (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) zeigt, wie die Funktionalität von Mods erweitert werden kann：

- ✅ Einführung in NuGet-Pakete von Drittanbietern
- ✅ Analysieren von Daten mithilfe externer Bibliotheken (YAML)
- ✅ Zugreifen auf die Mod-Ressourcendatei
- ✅ Automatisches Verarbeiten des Pakets von Abhängigkeiten

**베이스필제나리오：** Verwenden Sie die YamlDotNet-Bibliothek, um die YAML-Konfigurationsdatei im Ordner Mod Resources zu lesen und zu analysieren.

## 2. 프로젝트

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # 프로젝트
├── ModBehaviour.cs # Mod-Einstiegsklasse
"README.md
└── Vermögenswerte/
    ├── info.ini # Meta-Informationen für Mods
    ├── preview.png # Vorschaubild
    └── nice.yml # Beispiel-YAML-Datei
```

## 3. 프로젝트 구성(Projektkonfiguration)

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷츠스탠다드2.1</TargetFramework>
    <Nullable>에르뫼글리헨</Nullable>
    <LangVersion>보르샤우</LangVersion>
    <ImplicitUsings>스팀트</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>알레</PrivateAssets>
      <IncludeAssets>라우프자이트; 바우엔; 우르스프륀글리히; 내용-Dateien; 분석기; 빌드트랜지티브</IncludeAssets>
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

### 방법 1：Verwenden der CLI (empfohlen)

```bash
cd Ducky.PackageFromNuget
dotnet Paket hinzufügen YamlDotNet
```

### 방법 2：Manuelles Bearbeiten von .csproj

'에서<ItemGroup>" 힌주게퓌트：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 방법 3：Verwenden von Visual Studio

1. Klicken Sie mit der rechten Maustaste auf das Projekt→ NuGet-Pakete zu verwalten
2. Suche nach "YamlDotNet"
3. Klicken Sie auf "Installieren"

## 5) Beispiele für die Implementierung

### Ressourcen-Datei

['Vermögenswerte/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader 를 사용합니다.
  제목: "Schöne YAML-Konfiguration"
  description: "Dies ist eine Demonstration des Ladens von YAML aus dem Assets-Ordner eines Mods"
```

### Mod-Einstiegsklasse

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget / ModBehaviour.cs : 1 ) :

```csharp
mit Ducky.Sdk.Logging;
mit Ducky.Sdk.ModBehaviours;
mit YamlDotNet.Serialization;
mit YamlDotNet.Serialization.NamingConventions;

Namensraum Ducky.PackageFromNuget;

Öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Holen Sie sich das Verzeichnis, in dem sich die Mod-Assembly befindet
        var dir = Pfad.GetDirectoryName(typeof(ModBehaviour)입니다. 몽타주.오르트)!;
        var ymlPath = Pfad.Kombinieren(디렉토리, "nice.yml");

        if (Datei.Exists(ymlPfad))
        {
            Log.Info("Gefunden nice.yml:");
            
            Verwenden von YamlDotNet zum Deserialisieren von YAML-Dateien
            var deserializer = neuer DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . 바우엔();

            var ymlContent = Datei.ReadAllText(ymlPfad);
            var niceData = Deserialisierer. Deserialisieren<NiceData>(yml콘텐츠);
            
            Log.Info($"티텔: {niceData.NiceHeader.Title}");
            Log.Info($"Beschreibung: {niceData.NiceHeader.Description}");
        }
        오더
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
    공개 NiceDateHeader NiceHeader { get; 가르니투르; } = neu();

    öffentliche Klasse NiceDateHeader
    {
        공개 문자열 Titel { get; 가르니투르; } = 자이헨폴게. 리어;
        공개 문자열 Beschreibung { get; 가르니투르; } = 자이헨폴게. 리어;
    }
}
```

## 6. Zugriff auf Ressourcendateien

### Holen Sie sich den Mod-Katalog

```csharp
방법 1：Nach Montageort (empfohlen)
var modDir = Pfad.GetDirectoryName(typeof(ModBehaviour)입니다. 몽타주.오르트)!;
```

### Zugreifen auf die Ressourcendatei

```csharp
assets/ wird in das Stammverzeichnis des Mod-Ausgabeverzeichnisses kopiert
var configPath = Pfad.Kombinieren(modDir, "nice.yml");
var Inhalt = Datei.ReadAllText(configPath);
```

**SDK 자동화：**

- ✅ Kopieren der DLL eines NuGet-Pakets eines Drittanbieters
- ✅ Kopieren Sie die Ressourcendatei in das Ausgabeverzeichnis
- ✅ Bereitstellen im Verzeichnis der Spielmods

## 7. 모드 작업

Sobald der Build erfolgreich ist, aktiviere die Mod in der Mod-Verwaltungsoberfläche des Spiels：

1. 스타테 다스 슈필
2. Gehen Sie zur Mod-Verwaltungsoberfläche
3. Suchen Sie nach "Ducky.PackageFromNuget"
4. Klicken Sie auf Aktivieren
5. Überprüfen Sie die Spielprotokolle, und Sie sollten den analysierten YAML-Inhalt sehen

## 8) 방법

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

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - Grundlegende Projektstruktur
- [Ducky.EingangMod] (.. /Ducky.EntranceMod/README.md- Mehrschichtige Architektur (wenn Sie Bibliotheken von Drittanbietern freigeben müssen)
- [Dokumentation zur Vorbereitung der Umgebung] (.. /docs/Prequirement.md)를 사용합니다.

## 10. 주삼멘파성(Zusammenfassung)

Die Verwendung eines NuGet-Pakets eines Drittanbieters kann：

- ✅ Erweitern Sie schnell die Mod-Funktionen
- ✅ Vermeiden Sie es, das Rad neu zu erfinden
- ✅ Verwenden Sie eine bewährte und stabile Lösung
- ✅ Nutzen Sie 커뮤니티-Ressourcen

**알림：**

- ⚠️ Stellen Sie sicher, dass die Bibliothek mit .NET Standard 2.1 kompatibel ist.
- ⚠️ Beachten Sie die Größe der Abhängigkeit und die Auswirkungen auf die Leistung.
- ⚠️ Guter Umgang mit Versionskonflikten
- ⚠️ Halten Sie sich an die Lizenz der Drittbibliothek
