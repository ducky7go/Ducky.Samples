<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.BuffRegistration/README.md) | [Português] (../../en/Ducky.BuffRegistration/README_en.md) | [Alemão] (README_de.md) | [Français] (../../fr/Ducky.BuffRegistration/README_fr.md) | [Español] (../../es-ES/Ducky.BuffRegistration/README_es.md) | [Japonês] (../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어] (../../ko/Ducky.BuffRegistration/README_ko.md) | [Português] (../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский] (../../ru/Ducky.BuffRegistration/README_ru.md) | [Chinês tradicional] (../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.BuffRegistro Beispiel-Mod

Kurzbeschreibung

In diesem Beispiel wird gezeigt, wie Sie Ducky.Sdk verwenden, um einen benutzerdefinierten Buff zu registrieren, einschließlich lokalisierter Schlüssel und Objektlayouts.Einstieg und Implementierung siehe ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

1. Einführung em das Projekt

Dieses Verzeichnis (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1Veranschaulicht das Muster der Registrierung von Buffs über Contract.Buffs in einem Einzelprojekt-Mod.Dieses Projekt enthält auch Lokalisierungsschlüssel, siehe ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. Initialisieren des Projekts

- Klonen Sie das Repository und öffnen Sie 'Ducky.BuffRegistration/'.
- Es wird empfohlen, mindestens .csproj einzuschließen：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Netzstandard2,1</TargetFramework>
    <Nullable>Ermöglichen</Nullable>
    <LangVersion>Vorschau</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.BuffRegistrierung</ModName>
  </PropertyGroup>
</Project>
```

3. Installieren und Konfigurieren von Ducky.Sdk

Es wird empfohlen, ein SDK über NuGet hinzuzufügen：

```bash
dotnet adicionar pacote Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>alle</PrivateAssets>
    <IncludeAssets>Laufzeit; Bauen; Ursprünglich; conteúdo-Dateien; Analisador; buildtransitiv</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Registrieren eines benutzerdefinierten Buffs (Beispiel)

Verwenden Sie Contract.Buffs.RegisterBuff, um den Buff zu registrieren und den Anzeigenamen, die Beschreibung, das Symbol und die Lebensdauer im Rückruf festzulegen. Beispiel：

```csharp
mit Ducky.Sdk;

öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    _buffId internacional privado;

    geschützte Überschreibung void ModEnabled()
    {
        _buffId = Vertrag.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            Torcedor. SetDisplayName(LK. BENUTZEROBERFLÄCHE. DoNothingBuffName)
                . SetDescription(LK. BENUTZEROBERFLÄCHE. DoNothingBuffBeschreibung)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(wahr)
                . SetTotalLifeTime(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        Hören Sie sich die Initialisierung der Szene an：Gewährt diesen Buff automatisch dem Protagonisten, wenn er die Basis betritt (siehe ModBehaviour zur Implementierung)
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    geschützte Überschreibung vazio ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    vazio privado SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var principal = LevelManager.Instanz.MainCharacter;
            if (principal != nulo)
            {
                Erstellen und Hinzufügen einer registrierten Buff-Instanz beim Betreten der Basisszene
                Hauptsächlich. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. Lokalisierung

In diesem Beispiel wird ein Zeichenfolgenschlüssel bei [«Ducky.BuffRegistration/LK.cs»](Ducky.BuffRegistration/LK.cs:1)。Die Übersetzungsdatei befindet sich normalerweise unter «assets/locales/» (sichtbar im Quellverzeichnis), aber seien Sie vorsichtig：Übersetzungs-CSVs, Übersetzungsmetadaten ("assets/lkeys.json") und Validierungsdateien ("assets/keys.hash.txt") werden zur Kompilierzeit vom MSBuild-Analyse-/Generator des SDK automatisch gesammelt und in das Verzeichnis "assets/" geschrieben. Daher wird der Workflow wie folgt empfohlen:：

- Definieren oder Ändern von Schlüsseln im Code (empfohlen)：Bearbeiten ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1) und kompilieren, und das SDK generiert/aktualisiert die entsprechenden Übersetzungsmetadaten.
- Oder bearbeiten Sie "Ativos/Localidades/ direkt lokal" lokal{lang}.csv" und kompilieren Sie neu, damit das SDK die Änderungen integrieren kann.
- Wenn Sie eine dateibasierte Übersetzung verwenden (z. B. lange Texte in eine Markdown-Datei schreiben), können Sie «[TranslateFile("md")]» in «LK.cs» verwenden; Das SDK legt die entsprechende Datei in 'assets/locales/ ab.{lang}/" und verweisen Sie in CSV mit dem Dateinamen darauf.

Beispielschlüssel：

- "LK. BENUTZEROBERFLÄCHE. DoNothingBuffName"
- "LK. BENUTZEROBERFLÄCHE. DoNothingBuffBeschreibung»

Bemerkung："Assets/lkeys.json" und "Assets/keys.hash.txt" werden für die Laufzeitpositionierung und die Überprüfung des Pakets verwendet, und eine manuelle Änderung wird nicht empfohlen. Um eine Aktualisierung zu erzwingen, bereinigen Sie das Projekt, und kompilieren Sie es neu.

6. Erstellen und Verpacken

Allgemeine Buildbefehle：

```bash
dotnet construir Ducky.BuffRegistration/
```

6. Ativar Mod (Spiel starten)

Der Build stellt die Mod automatisch im Spielkatalog bereit, aktiviert die Mod in der Mod-Verwaltungsoberfläche des Spiels und startet das Spiel, um die Basisszene zu betreten und zu sehen, ob der Protagonista einen benutzerdefinierten Buff erhalten hat.
