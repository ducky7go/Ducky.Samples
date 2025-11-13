<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../Ducky.SingleProject/README.md) | [Englisch] (../../en/Ducky.SingleProject/README_en.md) | [English] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japanisch] (README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Traditionelles Chinesisch] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

簡単な説明

Dieses Beispiel zeigt, wie Sie Ducky.Sdk verwenden, um Mods für ein einzelnes Projekt zu erstellen, einschließlich Projektinitialisierung, SDK-Bereitstellung, Mod-Lebenszyklus und Paketierungsprozess.

Bevor Sie beginnen, stellen Sie sicher, dass Sie die Anforderungen vor der Umgebung vorbereitet haben: Vorbereiten der Umgebung (../docs/Prequirement.md)

1. プロジェクト紹介

Dieses Verzeichnis ('Ducky.SingleProject/') zeigt den SingleProject Mod Modus：Der gesamte Code und die Ressourcen werden im selben Projekt abgelegt, und die Eintragsklasse erbt 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. プロジェクトを初期化する

- Beginnen Sie mit einer Vorlage oder einem Repository：Klonen Sie das Beispielrepository und öffnen Sie "Ducky.SingleProject/".
- Erforderliche Projektkonfiguration (wir empfehlen, dies mit '.csproj' sicherzustellen)：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>STIMMT</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Programme (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

Beispiel：Stellen Sie sicher, dass ModName mit dem Assembly-/Projektnamen übereinstimmt.

1. Ducky.Sdk をインストールして構成する

Es wird empfohlen, Ducky.Sdk über NuGet zu installieren.Sie können die CLI verwenden, um es schnell hinzuzufügen (z. B. - ersetzen Sie es durch die gewünschte Version)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>実行中; 建てる; ネイティブ; contentファイル; アナライザー; ビルド推移的</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Erstelle dein erstes ModBehaviour

- イングレスクラスは ModBehaviourBase を継承し、ライフサイクルメソッド ModEnabled() と ModDisabled() を実装します。

サンプルコード：

```csharp
Ducky.SDK verwenden.
Verwenden Sie ducky.Sdk.Logging.

Namensraum Ducky.SingleProject;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    geschützte Überschreibung void ModEnabled()
    {
        Aufzeichnung von Informationen zum Zeitpunkt der Initialisierung
        Log.Info("Ducky.SingleProject Mod aktiviert");
    }

    geschützte Überschreibung void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod deaktiviert");
    }
}
```

5. 実行とパッケージ化

一般的なビルドコマンド：

```bash
# Erstellen der gesamten Lösung (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet build Ducky.SingleProject/
```

6. Modを有効にする(ゲームを実行する)

Der Build stellt die Mod automatisch im Spielekatalog bereit, startet das Spiel und aktiviert die Mod in der Mod-Verwaltungsoberfläche oder im Spiel.Nach der Aktivierung können Sie die Aktivierungsinformationen des Mods im Spielprotokoll überprüfen.
