<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.InstantKill/README.md) | [Englisch] (../../en/Ducky.InstantKill/README_en.md) | [English] (../../de/Ducky.InstantKill/README_de.md) | [Français] (../../fr/Ducky.InstantKill/README_fr.md) | [Español] (../../es-ES/Ducky.InstantKill/README_es.md) | [Japanisch] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Português] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Traditionelles Chinesisch] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill Beispiel-Mod

簡要說明

In diesem Beispiel wird ein einfacher Mod implementiert, der den Protagonisten tötet, wenn er einen Feind angreift.Wenn nach der Aktivierung ein Verletzungsereignis eintritt und die Schadensquelle der Protagonist ist, fügt es dem Ziel hohen Schaden zu und tötet es sofort.Zur Implementierung siehe ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

Dieses Verzeichnis ('Ducky. InstantKill/') demonstriert den Einzelprojekt-Mod-Modus：Der gesamte Code und die Ressourcen werden im selben Projekt platziert, und die Eingangsklasse erbt 'ModBehaviourBase', siehe ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. 初始化專案

- Klonen Sie das Warehouse, und öffnen Sie 'Ducky.InstantKill/'.
- Empfohlen in ". CSPROJ：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2.1</TargetFramework>
    <Nullable>ermöglichen</Nullable>
    <LangVersion>Vorschau</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.InstantKill</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. 安裝並配置 Ducky.Sdk

推薦通過 NuGet 添加 SDK：

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

4. ModBehaviour schreiben

Die Eingangsklasse muss 'ModBehaviourBase' erben und die Lebenszyklusmethoden 'ModEnabled()' und 'ModDisabled()' implementieren.In diesem Beispiel wird der Prozessor beim Ereignis "OnHurt" registriert, das dem Ziel eine große Menge an Schaden zufügt, wenn der Schaden von der Hauptfigur ausgeht.

Beispielcode：

```csharp
mit Ducky.Sdk;
mit Ducky.Sdk.Logging;

Namensraum Ducky.InstantKill;

öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Gesundheit.OnHurt += Health_OnHurt;
    }

    geschützte Überschreibung void ModDisabled()
    {
        Gesundheit.OnHurt -= Health_OnHurt;
    }

    private Ungültigkeit Health_OnHurt(Gesundheit h, SchadenInfo da)
    {
        if (da. Bis(h). IsFromMainToEnemy())
        {
            Log.Debug("Sofortiger Kill-Mod: Töten des Feindes.");
            h.(new DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000,
            });
        }
    }
}
```

5. Ausführen und Verpacken

常用構建命令：

```bash
# Erstellen Sie die gesamte Lösung
dotnet build Docky.Sdk.Sample.slnx

# Nur dieses Projekt erstellen
dotnet build Ducky.InstantKill/
```

6. 開啟 Mod（執行遊戲）

Nachdem der Build den Mod automatisch im Spielverzeichnis bereitgestellt hat, wird der Mod in der Spielmod-Verwaltungsoberfläche aktiviert und der Effekt kann getestet werden, nachdem das Spiel die Schlachtfeldszene betreten hat：Wenn der Protagonist den Feind angreift, sollte der Feind sofort sterben.
