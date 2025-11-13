<!-- LANG_HEADER_START -->
| [简体中文](../../Ducky.InstantKill/README.md) | [English](../../en/Ducky.InstantKill/README_en.md) | [Deutsch](README_de.md) | [Français](../../fr/Ducky.InstantKill/README_fr.md) | [Español](../../es-ES/Ducky.InstantKill/README_es.md) | [日本語](../../ja/Ducky.InstantKill/README_ja.md) | [한국어](../../ko/Ducky.InstantKill/README_ko.md) | [Português](../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](../../ru/Ducky.InstantKill/README_ru.md) | [繁體中文](../../zh-TW/Ducky.InstantKill/README_zh.md) | 
<!-- LANG_HEADER_END -->

# Ducky.InstantKill Beispiel-Mod

Kurzbeschreibung

In diesem Beispiel wird eine einfache Mod implementiert, die den Protagonisten tötet, sobald er einen Feind angreift.Wenn diese Option aktiviert ist und die Schadensquelle der Hauptcharakter ist, fügt sie dem Ziel hohen Schaden zu und tötet es sofort.Implementierung siehe ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

1. Einführung in das Projekt

Dieses Verzeichnis ('Ducky.InstantKill/') demonstriert den Einzelprojekt-Mod-Modus：Der gesamte Code und die Ressourcen werden im selben Projekt abgelegt, und die Eingangsklasse erbt 'ModBehaviourBase', wie in ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Initialisieren des Projekts

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

3. Installieren und Konfigurieren von Ducky.Sdk

Es wird empfohlen, ein SDK über NuGet hinzuzufügen：

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

Die Ingress-Klasse erbt die ModBehaviourBase und implementiert die Lebenszyklusmethoden ModEnabled() und ModDisabled().In diesem Beispiel wird der Prozessor beim Ereignis "OnHurt" registriert, um dem Ziel großen Schaden zuzufügen, wenn der Schaden von der Hauptfigur ausgeht.

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

Allgemeine Buildbefehle：

```bash
# Erstellen Sie die gesamte Lösung
dotnet build Docky.Sdk.Sample.slnx

# Nur dieses Projekt erstellen
dotnet build Ducky.InstantKill/
```

6. Enable Mod (Spiel starten)

Build stellt die Mod automatisch im Spielekatalog bereit, aktiviert sie in der Mod-Verwaltungsoberfläche des Spiels und testet die Wirkung, sobald das Spiel und das Schlachtfeld gestartet sind：Wenn der Protagonist einen Feind angreift, sollte der Feind sofort sterben.
