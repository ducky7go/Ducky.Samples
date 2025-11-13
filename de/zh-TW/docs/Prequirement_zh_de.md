<!-- LANG_HEADER_START -->

\| [Vereinfachtes Chinesisch] (../../docs/Prequirement.md) | [Englisch] (../../en/docs/Prequirement_en.md) | [English] (../../de/docs/Prequirement_de.md) | [Français] (../../fr/docs/Prequirement_fr.md) | [Español] (../../es-ES/docs/Prequirement_es.md) | [Japanisch] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [Português] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [Traditionelles Chinesisch] (Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Vorbereitung der Entwicklungsumgebung (.NET / Ducky.Sdk-Projekt)

In diesem Dokument werden die Mindestanforderungen und empfohlenen Konfigurationen beschrieben, die zum Einrichten einer .NET-Entwicklungsumgebung für dieses Repository erforderlich sind.

## Überblick

- Ziel-.NET SDK：.NET 10 (SDK 10.x)
- Erforderliche globale Tools：
  - Wird verwendet, um C#-Dokumente dynamisch auszuführen：'dotnet-script'
  - Wird für Programmsammlungen und/oder -verpackungen verwendet：'dotnet-ilrepack'

## Systemanforderungen

- Unterstützte Betriebssysteme：Linux / macOS / Windows (bitte verwenden Sie die Paketverwaltung oder das offizielle Installationsskript, um das .NET SDK zu installieren)
- Empfohlener Speicherplatz und Arbeitsspeicher：Mindestens 2 GB freie Festplatte und 4 GB Arbeitsspeicher

## Installieren des .NET SDK 10

Installieren Sie das .NET 10 SDK mit der offiziellen Installationsmethode oder dem Paket-Manager, Beispiel：

```bash
# Linux (mit Microsoft-Skripten)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --Kanal 10.0
```

```bash
# macOS (Homebrew-Beispiel)
brew install --cask dotnet-sdk # Überprüfen Sie dann die verfügbaren Versionen über brew info oder verwenden Sie das dotnet-install-Skript
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Kanal 10.0
```

Fügen Sie nach der Installation den Pfad des SDK zum PATH hinzu, oder führen Sie es mit dem vollständigen Pfad im Terminal aus.Überprüfen der Installation：

```bash
dotnet --info
```

Die Ausgabe sollte eine SDK-Version enthalten, die mit "10." beginnt, z. B. 10.0.x.

## Globale Tools (erforderlich)

- Dynamisches Ausführen von C#-Skripten (REPL/Documented Build/Widgets)

```bash
dotnet tool install -g dotnet-script
```

- Programmsammlung und/oder -paket (wird zum Generieren einer einzelnen Assembly oder zum Zusammenführen von Abhängigkeiten von Drittanbietern verwendet)

```bash
dotnet tool install -g dotnet-ilrepack
```

Sobald die Installation abgeschlossen ist, vergewissern Sie sich, dass das Tool verfügbar ist：

```bash
dotnet-script --version
ilrepack /?
```
