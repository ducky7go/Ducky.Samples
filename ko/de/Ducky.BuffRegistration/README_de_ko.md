<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.BuffRegistration/README.md) | [영어] (../../en/Ducky.BuffRegistration/README_en.md) | [도이치] (README_de.md) | [프랑세] (../../fr/Ducky.BuffRegistration/README_fr.md) | [스페인어] (../../es-ES/Ducky.BuffRegistration/README_es.md) | [일본어] (../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어] (../../ko/Ducky.BuffRegistration/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский] (../../ru/Ducky.BuffRegistration/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Buff등록 Beispiel-Mod

쿠르츠베슈라이붕

In diesem Beispiel wird gezeigt, wie Sie Ducky.Sdk verwenden, um einen benutzerdefinierten Buff zu registrieren, einschließlich lokalisierter Schlüssel und Objektlayouts.Einstieg und 구현 siehe ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

Bevor Sie beginnen, stellen Sie sicher, dass die Anforderungen für die Vorproduktionsumgebung vorbereitet sind: [Vorbereitung der Umgebung](../docs/Prequirement.md)

1. Einführung in das Projekt

Dieses Verzeichnis (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1Veranschaulicht das Muster der Registrierung von Buffs über Contract.Buffs in einem Einzelprojekt-Mod.Dieses Projekt enthält auch Lokalisierungsschlüssel, siehe ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. Initialisieren des Projekts

- Klonen Sie das Repository und öffnen Sie 'Ducky.BuffRegistration/'.
- Es wird empfohlen, mindestens .csproj einzuschließen：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷츠스탠다드2.1</TargetFramework>
    <Nullable>에르뫼글리헨</Nullable>
    <LangVersion>보르샤우</LangVersion>
    <ImplicitUsings>스팀트</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.Buff등록</ModName>
  </PropertyGroup>
</Project>
```

3. Installieren und Konfigurieren von Ducky.Sdk

Es wird empfohlen, ein SDK über NuGet hinzuzufügen：

```bash
dotnet 패키지 추가 Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>알레</PrivateAssets>
    <IncludeAssets>라우프자이트; 바우엔; 우르스프륀글리히; 내용-Dateien; 분석기; 빌드트랜지티브</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Registrieren eines benutzerdefinierten Buffs (Beispiel)

Verwenden Sie Contract.Buffs.RegisterBuff, um den Buff zu registrieren und den Anzeigenamen, die Beschreibung, das Symbol und die Lebensdauer im Rückruf festzulegen. 베이스피엘：

```csharp
mit Ducky.Sdk;

Öffentliche Klasse ModBehaviour : ModBehaviourBase
{
    개인 int _buffId;

    geschützte Überschreibung void ModEnabled()
    {
        _buffId = Vertrag.Buffs.RegisterBuff<DoNothingBuff>(버프 =>
        {
            팬. SetDisplayName(LK. BENUTZEROBERFLÄCHE. DoNothingBuffName)을 사용합니다.
                . SetDescription(LK. BENUTZEROBERFLÄCHE. DoNothingBuffBeschreibung)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(와르)
                . TotalLifeTime 설정(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        Hören Sie sich die Initialisierung der Szene an：Gewährt diesen Buff automatisch dem Protagonisten, wenn er die Basis betritt (siehe ModBehaviour zur Implementierung)
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    geschützte Überschreibung void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instanz.MainCharacter;
            if (메인 != null)
            {
                Erstellen und Hinzufügen einer registrierten Buff-Instanz beim Betreten der Basisszene
                hauptsächlich. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. Lokalisierung

In diesem Beispiel wird ein Zeichenfolgenschlüssel bei ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。Die Übersetzungsdatei befindet sich normalerweise unter 'assets/locales/' (sichtbar im Quellverzeichnis), aber seien Sie vorsichtig：Übersetzungs-CSVs, Übersetzungsmetadaten ("assets/lkeys.json") und Validierungsdateien ("assets/keys.hash.txt") werden zur Kompilierzeit vom MSBuild-Analyse-/Generator des SDK automatisch gesammelt und in das Verzeichnis "assets/" geschrieben. Daher wird der Workflow wie folgt empfohlen:：

- Definieren oder Ändern von Schlüsseln im Code (empfohlen)：베어베이텐 ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1) und kompilieren, und das SDK generiert/aktualisiert die entsprechenden Übersetzungsmetadaten.
- Oder bearbeiten Sie "Assets/Locales/ direkt lokal" lokal{lang}.csv" und kompilieren Sie neu, damit das SDK die Änderungen integrieren kann.
- Wenn Sie eine dateibasierte Übersetzung verwenden (z. B. lange Texte in eine Markdown-Datei schreiben), können Sie '[TranslateFile("md")]' in 'LK.cs' verwenden; Das SDK legt die entsprechende Datei in 'assets/locales/ ab.{lang}/" und verweisen Sie in CSV mit dem Dateinamen darauf.

Beispielschlüssel：

- "LK. BENUTZEROBERFLÄCHE. DoNothingBuffName"
- "LK. BENUTZEROBERFLÄCHE. 아무것도 하지 않는 버프베슈라이벙'

베메르쿵："Assets/lkeys.json" und "Assets/keys.hash.txt" werden für die Laufzeitpositionierung und die Überprüfung des Pakets verwendet, und eine manuelle Änderung wird nicht empfohlen. Um eine Aktualisierung zu erzwingen, bereinigen Sie das Projekt, und kompilieren Sie es neu.

6. Erstellen und Verpacken

Allgemeine Buildbefehle：

```bash
dotnet build Ducky.BuffRegistration/
```

6. 모드 활성화(Spiel starten)

Der Build stellt die Mod automatisch im Spielkatalog bereit, aktiviert die Mod in der Mod-Verwaltungsoberfläche des Spiels und startet das Spiel, um die Basisszene zu betreten und zu sehen, ob der Protagonist einen benutzerdefinierten Buff erhalten hat.
