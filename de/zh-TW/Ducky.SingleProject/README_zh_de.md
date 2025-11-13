<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.SingleProject/README.md) | [Englisch] (../../en/Ducky.SingleProject/README_en.md) | [English] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japanisch] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Traditionelles Chinesisch] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject Beispiel-Mod

簡要說明

Dieses Beispiel zeigt, wie Sie mit Ducky.SDK einen Mod für ein einzelnes Projekt erstellen, einschließlich Projektinitialisierung, SDK-Einführung, Mod-Lebenszyklus und Paketierungsprozess.

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen vor der Umgebung bereit sind： [Vorbereitung der Umwelt](.. /docs/Prequirement.md)

1. 項目簡介

Dieser Katalog ('Ducky. SingleProject/') demonstriert den SingleProject Mod-Modus：Der gesamte Code und die Ressourcen werden im selben Projekt abgelegt, und die Eingangsklasse erbt 'ModBehaviourBase', die in ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1) implementiert werden kann.

2. 初始化專案

- Beginnen Sie mit einer Vorlage oder einem Lager：Klonen Sie das Beispielrepository und öffnen Sie "Ducky.SingleProject/".
- Erforderliche Elementeinstellungen (empfohlen, um in '.csproj' garantiert zu sein)：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2.1</TargetFramework>
    <Nullable>ermöglichen</Nullable>
    <LangVersion>Vorschau</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Programme (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

Beispiel：Stellen Sie sicher, dass der ModName mit dem Assembly-/Projektnamen konsistent ist.

1. 安裝並配置 Ducky.Sdk

Es wird empfohlen, Ducky.Sdk über NuGet zu installieren.Sie können die CLI verwenden, um schnell hinzuzufügen (Beispiel - durch die gewünschte Version ersetzen)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>alle</PrivateAssets>
    <IncludeAssets>Laufzeit; bauen; ursprünglich; content-Dateien; Analysatoren; buildtransitiv</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Schreiben Sie das erste ModBehaviour

- Die Eingangsklasse muss 'ModBehaviourBase' erben und die Lebenszyklusmethoden 'ModEnabled()' und 'ModDisabled()' implementieren.

Beispielcode：

```csharp
mit Ducky.Sdk;
mit Ducky.Sdk.Logging;

Namensraum Ducky.SingleProject;

öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Aufzeichnen von Informationen bei der Initialisierung
        Log.Info("Ducky.SingleProject Mod aktiviert");
    }

    geschützte Überschreibung void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod deaktiviert");
    }
}
```

5. Ausführen und Verpacken

常用構建命令：

```bash
# Erstellen der gesamten Lösung (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Erstellen Sie nur ein einzelnes Beispielprojekt
dotnet build Ducky.SingleProject/
```

6. 開啟 Mod（執行遊戲）

Build stellt Mods automatisch im Spielekatalog bereit und startet das Spiel, um die Mod in der Mod-Verwaltungsoberfläche oder im Spiel zu aktivieren.Nach der Aktivierung kannst du die Aktivierungsinformationen der Mod im Spielprotokoll sehen.
