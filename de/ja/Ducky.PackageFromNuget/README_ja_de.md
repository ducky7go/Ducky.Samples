<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.PackageFromNuget/README.md) | [Englisch] (../../en/Ducky.PackageFromNuget/README_en.md) | [English] (../../de/Ducky.PackageFromNuget/README_de.md) | [Français] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japanisch] (README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Traditionelles Chinesisch] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル MOD

簡単な説明

In diesem Beispiel wird gezeigt, wie NuGet-Pakete von Drittanbietern in Mods verwendet werden, wobei YamlDotNet als Beispiel verwendet wird, z. B. Abhängigkeitsverwaltung, Zugriff auf Ressourcendateien und Bereitstellung von Abhängigkeitspaketen.

開始する前に、実稼働前の環境要件が準備されていることを確認してください: [環境の準備](../docs/Prequirement.md)

## 1. プロジェクト紹介

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) zeigt, wie die Funktionalität von Mods erweitert werden kann：

- ✅ Einführung in NuGet-Pakete von Drittanbietern
- ✅ Analysieren von Daten mithilfe externer Bibliotheken (YAML)
- ✅ Mod リソース ファイルにアクセスする
- ✅ Automatisches Verarbeiten von Abhängigkeitspaketen

Beispielszenario：\*\* Verwenden Sie die YamlDotNet-Bibliothek, um die YAML-Konfigurationsdatei im Ordner Mod Resources zu lesen und zu analysieren.

## 2. プロジェクト構造

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Projektkonfiguration
"ModBehaviour.cs #モードエントリークラス
"README.md
└── アセット/
    ├── info.ini #モードメタ情報
    ├── preview.png #プレビュー画像
    └── nice.yml # サンプルYAMLファイル
```

## 3. Projektstruktur

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>Ausgeführte; Bauen; ネイティブ; contentファイル; アナライザー; Übergang erstellen</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

キーポイント：\*\*

- Das SDK verwendet "PrivateAssets", um das Packen in die Ausgabe zu vermeiden
- Bibliotheken von Drittanbietern (YamlDotNet) werden automatisch in das mod-Ausgabeverzeichnis gepackt

## 4. Hinzufügen eines NuGet-Pakets

### Methode 1：Verwenden der CLI (empfohlen)

```bash
cd Ducky.PackageFromNuget
dotnet Paket hinzufügen YamlDotNet
```

### Methode 2：Manuelles Bearbeiten der CSPROJ-Datei

で '<ItemGroup>" wurde hinzugefügt.：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Methode 3：Verwenden von Visual Studio

1. Klicken Sie mit der rechten Maustaste auf das Projekt→ NuGet-Pakete zu verwalten
2. Suche nach "YamlDotNet"
3. 「インストール」をクリックします

## 5) Beispiele für die Implementierung

### リソースファイル

['Vermögenswert/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  title: "Schöne YAML-Konfiguration"
  Beschreibung: "これは、MOD の assets フォルダーから YAML をロードするデモンストレーションです"
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Verwenden Sie ducky.Sdk.Logging.
Ducky.Sdk.ModBehaviours.
YamlDotNet.Serialization.
Verwenden Sie YamlDotNet.Serialization.NamingConventions.

Namensraum Ducky.PackageFromNuget;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Holen Sie sich das Verzeichnis, in dem sich die Mod-Assembly befindet
        var dir = Pfad.GetDirectoryName(typeof(ModBehaviour) です。 Montage.Ort)!;
        var ymlPath = Pfad.Kombinieren(ディレクトリ, "nice.yml");

        if (Datei.Exists(ymlPfad))
        {
            Log.Info("Gefunden nice.yml:");
            
            Verwenden von YamlDotNet zum Deserialisieren von YAML-Dateien
            var deserializer = neuer DeserializerBuilder()
                . Namenskonventionen (Namenskonventionen für Camel-Fälle.
                . ビルド();

            var ymlContent = Datei.ReadAllText(ymlPfad);
            var niceData = デシリアライザー。 Deserialisierung<NiceData>(ymlコンテンツ);
            
            Log.Info($"タイトル: {niceData.NiceHeader.Title}");
            Log.Info($" Beschreibung: {niceData.NiceHeader.Description}");
        }
        Wenn nicht,
        {
            Log.Warn("nice.yml nicht gefunden!");
        }
    }

    geschützte Überschreibung void ModDisabled()
    {
        Bereinigen von Ressourcen (falls erforderlich)
    }
}

データモデルクラス
public クラス NiceData
{
    public NiceDateHeader NiceHeader { get; セット; } = neu();

    パブリック・クラス NiceDateHeader
    {
        public string Titel { get; セット; } = Zeichenfolge. Leer;
        public string erklärt { get; } セット; } = Zeichenfolge. Leer;
    }
}
```

## 6. リソースファイルへのアクセス

### Holen Sie sich den Mod-Katalog

```csharp
Methode 1：Nach Montageort (empfohlen)
var modDir = Pfad.GetDirectoryName(typeof(ModBehaviour) です。 Montage.Ort)!;
```

### リソースファイルにアクセスする

```csharp
Das Verzeichnis assets/ wird in das Stammverzeichnis des Ausgabeverzeichnisses Mod kopiert
var configPath = Pfad.Kombinieren(modDir, "nice.yml");
var Inhalt = Datei.ReadAllText(configPath);
```

**SDK Automatisch：**

- ✅ サード パーティの NuGet パッケージの DLL をコピーする
- ✅ Kopieren Sie die Ressourcendatei in das Ausgabeverzeichnis
- ✅ ゲーム mods ディレクトリにデプロイする

## 7. Mods aktivieren

Sobald der Build erfolgreich ist, aktiviere die Mod in der Mod-Verwaltungsoberfläche des Spiels：

1. Starte das Spiel
2. Gehen Sie zur Mod-Verwaltungsoberfläche
3. Suchen Sie nach "Ducky.PackageFromNuget".
4. Klicken Sie auf Aktivieren
5. Wenn Sie die Spielprotokolle überprüfen, sehen Sie den Inhalt der analysierten YAML-Datei

## 8) ベストプラクティス

### ✅ Wählen Sie die richtige Bibliothek

- Priorisieren von Bibliotheken, die mit .NET Standard 2.0/2.1 kompatibel sind
- Vermeiden Sie die Verwendung plattformspezifischer Bibliotheken
- Überprüfen, ob der Abhängigkeitsbaum der Bibliothek komplex ist

### ✅ Verwaltung abhängiger Versionen

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Verwandter Fall

- [ダッキー・シングルプロジェクト] (../Ducky.SingleProject/README.md) - Grundlegende Projektstruktur
- [ダッキー・エントランス・モッド] (.. /Ducky.EntranceMod/README.md - Mehrstufige Architektur (wenn Sie Bibliotheken von Drittanbietern freigeben müssen)
- [環境準備ドキュメント](../docs/Prequirement.md)

## 10. プロット

Wenn Sie ein NuGet-Paket eines Drittanbieters verwenden,：

- ✅ Erweitern Sie schnell die Mod-Funktionalität
- ✅ Vermeiden Sie es, das Rad neu zu erfinden
- ✅ Nutzen Sie bewährte und stabile Lösungen
- ✅ Nutzung von Community-Ressourcen

**Anmerkung：**

- ⚠️ Stellen Sie sicher, dass Ihre Bibliothek mit .NET Standard 2.1 kompatibel ist.
- ⚠️ Seien Sie sich der Größe von Abhängigkeiten und ihrer Auswirkungen auf die Leistung bewusst
- ⚠️ Versionskonflikte angemessen behandeln
- ⚠️ Einhaltung von Bibliothekslizenzen von Drittanbietern
