<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.PackageFromNuget/README.md) | [日本語](../../en/Ducky.PackageFromNuget/README_en.md) | [ドイツ語](README_de.md) | [フランセ](../../fr/Ducky.PackageFromNuget/README_fr.md) | [スペイン語](../../es-ES/Ducky.PackageFromNuget/README_es.md) | [日本語](../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](../../ko/Ducky.PackageFromNuget/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский](../../ru/Ducky.PackageFromNuget/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget-Beispiel-Mod

クルツベシュライブン

In diesem Beispiel wird gezeigt, wie NuGet-Pakete von Drittanbietern in Mods verwendet werden, wobei YamlDotNet als Beispiel verwendet wird, einschließlich Abhängigkeitsverwaltung, Zugriff auf Ressourcendateien und Bereitstellung von Abhängigkeitspaketen.

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

## 1. Projekteinführung

Dieses Verzeichnis (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) zeigt, wie die Funktionalität von Mods erweitert werden kann：

- ✅ Einführung in NuGet-Pakete von Drittanbietern
- ✅ Analysieren von Daten mithilfe externer Bibliotheken (YAML)
- ✅ Zugreifen auf die Mod-Ressourcendatei
- ✅ Automatisches Verarbeiten des Pakets von Abhängigkeiten

**ベイスピエルゼナリオ：** Verwenden Sie die YamlDotNet-Bibliothek, um die YAML-Konfigurationsdatei im Ordner Mod Resources zu lesen und zu analysieren.

## 2. Projektstruktur

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Projektkonfiguration
├── ModBehaviour.cs # Mod-Einstiegsklasse
「README.md
└── ヴェルメゲンヴェルテ/
    ├── info.ini # Meta-Informationen für Mods
    ├── preview.png #ヴォルシャウビルト
    └── nice.yml #ベイスピール-YAML-伊達井
```

## 3. プロジェクト構成

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2.1</TargetFramework>
    <Nullable>エルモグリッヘン</Nullable>
    <LangVersion>ヴォルシャウ</LangVersion>
    <ImplicitUsings>スティムト</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>アッレ</PrivateAssets>
      <IncludeAssets>ラウフツァイト; バウエン; ウルスプルングリッヒ; content-Dateien; 分析; ビルドトランジティブ</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

Wichtige Punkte：\*\*

- Das SDK verwendet "PrivateAssets", um das Verpacken in der Ausgabe zu vermeiden
- Bibliotheken von Drittanbietern (YamlDotNet) werden automatisch in das mod-Ausgåverzeichnis gepackt

## 4. Hinzufügen des NuGet-Pakets

### 方法1：Verwenden der CLI (empfohlen)

```bash
cd Ducky.PackageFromNuget
dotnet Paket hinzufügen YamlDotNet
```

### 方法2：マヌエル・ベアベイテン・フォン .csproj

で '<ItemGroup>" ヒンツゲフュクト：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 方法3：Verwenden von Visual Studio

1. Klicken Sie mit der rechten Maustaste auf das Projekt→ NuGet-Pakete zu verwalten
2. 「YamlDotNet」
3. Klicken Sie auf "Installieren"

## 5) Beispiele für die Implementierung

### リソース-伊達井

['Vermögenswerte/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  タイトル:「シェーネ・ヤムル・コンフィギュレーション」
  description: "Dies ist eine Demonstration des Ladens von YAML aus dem Assets-Ordner eines Mods"
```

### Mod-Einstiegsklasse

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget / ModBehaviour.cs:1):

```csharp
mit Ducky.Sdk.Logging;
mit Ducky.Sdk.ModBehaviours;
mit YamlDotNet.Serialization;
mit YamlDotNet.Serialization.NamingConventions;

ナメンスラウム Ducky.PackageFromNuget;

öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Holen Sie sich das Verzeichnis, in dem sich die Mod-Assembly befindet
        var dir = Pfad.GetDirectoryName(typeof(ModBehaviour) です。 モンタージュ・オルト)!;
        var ymlPath = Pfad.Kombinieren(Dir, "nice.yml");

        if (Datei.Exists(ymlPfad))
        {
            Log.Info("Gefunden nice.yml:");
            
            Verwenden von YamlDotNet zum Deserialisieren von YAML-Dateien
            var deserializer = neuer DeserializerBuilder()
                . 命名規則(キャメルケース命名規則.インスタンス)
                . バウエン();

            var ymlContent = Datei.ReadAllText(ymlPfad);
            var niceData = Deserialisierer. Deserialisieren<NiceData>(ymlコンテンツ);
            
            Log.Info($"ティテル: {niceData.NiceHeader.Title}");
            Log.Info($"Beschreibung: {niceData.NiceHeader.Description}");
        }
        オーデル
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
    public NiceDateHeader NiceHeader { get; ガルニトゥール; } = neu();

    öffentliche Klasse NiceDateHeader
    {
        パブリック文字列 Titel { get; ガルニトゥール; } = ツァイヘンフォルゲ。 リーア;
        public string Beschreibung { get; ガルニトゥール; } = ツァイヘンフォルゲ。 リーア;
    }
}
```

## 6. Zugriff auf Ressourcendateien

### Holen Sie sich den Mod-Katalog

```csharp
方法1：Nach Montageort (empfohlen)
var modDir = Pfad.GetDirectoryName(typeof(ModBehaviour)です。 モンタージュ・オルト)!;
```

### Zugreifen auf die Ressourcendatei

```csharp
assets/ wird in das Stammverzeichnis des Mod-Ausgabeverzeichnisses kopiert
var configPath = Pfad.Kombinieren(modDir, "nice.yml");
var Inhalt = Datei.ReadAllText(configPath);
```

**SDK自動化：**

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

## 8) 方法論

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

## 9. アインシュレギゲ・ベイスピエレ

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - Grundlegende Projektstruktur
- [Ducky.EingangMod] (.. /Ducky.EntranceMod/README.md- Mehrschichtige Architektur (wenn Sie Bibliotheken von Drittanbietern freigeben müssen)
- [Dokumentation zur Vorbereitung der Umgebung] (../docs/Prequirement.md)

## 10. ズサメンファスン

Die Verwendung eines NuGet-Pakets eines Drittanbieters kann：

- ✅ Erweitern Sie schnell die Mod-Funktionen
- ✅ Vermeiden Sie es, das Rad neu zu erfinden
- ✅ Verwenden Sie eine bewährte und stabile Lösung
- ✅ Nutzen Sie Community-Ressourcen

**通知：**

- ⚠️ Stellen Sie sicher, dass die Bibliothek mit .NET Standard 2.1 kompatibel ist.
- ⚠️ Beachten Sie die Größe der Abhängigkeit und die Auswirkungen auf die Leistung.
- ⚠️ Guter Umgang mit Versionskonflikten
- ⚠️ Halten Sie sich an die Lizenz der Drittbibliothek
