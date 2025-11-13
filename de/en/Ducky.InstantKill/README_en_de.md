<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.InstantKill/README.md) | [Englisch] (README_en.md) | [English] (../../de/Ducky.InstantKill/README_de.md) | [Français] (../../fr/Ducky.InstantKill/README_fr.md) | [Español] (../../es-ES/Ducky.InstantKill/README_es.md) | [Japanisch] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Português] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Traditionelles Chinesisch] (../../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill Beispiel-Mod

Brief description

In diesem Beispiel wird eine einfache Mod implementiert, die den Protagonisten tötet, sobald er einen Feind angreift. Wenn diese Option aktiviert ist und die Schadensquelle der Hauptcharakter ist, fügt sie dem Ziel hohen Schaden zu und tötet es sofort. Implementierung siehe ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Before you begin, make sure that the pre-production environment requirements are prepared: [Environment Preparation](../docs/Prequirement.md)

1. Project Introduction

Dieses Verzeichnis ('Ducky.InstantKill/') demonstriert den Einzelprojekt-Mod-Modus：Der gesamte Code und die Ressourcen werden im selben Projekt abgelegt, und die Eingangsklasse erbt 'ModBehaviourBase', wie in ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Initialize the project

- Klonen Sie das Repository und öffnen Sie 'Ducky.InstantKill/'.
- Es wird empfohlen, mindestens in ".csproj"：

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

3. Install and configure Ducky.Sdk

We recommend adding an SDK via NuGet：

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

Die Ingress-Klasse erbt die ModBehaviourBase und implementiert die Lebenszyklusmethoden ModEnabled() und ModDisabled(). In diesem Beispiel wird der Prozessor beim Ereignis "OnHurt" registriert, um dem Ziel großen Schaden zuzufügen, wenn der Schaden von der Hauptfigur ausgeht.

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

Common build commands：

```bash
# Erstellen Sie die gesamte Lösung
dotnet build Docky.Sdk.Sample.slnx

# Nur dieses Projekt erstellen
dotnet build Ducky.InstantKill/
```

6. Enable Mod (Run the Game)

Build stellt die Mod automatisch im Spielekatalog bereit, aktiviert sie in der Mod-Verwaltungsoberfläche des Spiels und testet die Wirkung, sobald das Spiel und das Schlachtfeld gestartet sind：Wenn der Protagonist einen Feind angreift, sollte der Feind sofort sterben.
