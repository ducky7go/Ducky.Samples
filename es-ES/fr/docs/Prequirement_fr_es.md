<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../docs/Prequirement.md) | [Inglés] (../../en/docs/Prequirement_en.md) | [Deutsch] (../../de/docs/Prequirement_de.md) | [Français] (Prequirement_fr.md) | [English] (../../es-ES/docs/Prequirement_es.md) | [Japonés] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [Português] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [Chino tradicional] (../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Préparation de l'environnement de développement (projet .NET / Ducky.Sdk)

Ce document décrit la configuration minimale requise et les configurations recommandées requises pour configurer un environnement de développement .NET pour ce référentiel.

## Aperçu

- Kit de développement logiciel (SDK) .NET cible：.NET 10(SDK 10.x)
- Outils mondiaux nécessaires：
  - Utilisé pour exécuter dynamiquement des scripts C #：'dotnet-script'
  - Utilisé pour les collections de programmes et/ou l'emballage：'dotnet-ilrepack'

## Requisito de configuración :

- Systèmes d'exploitation pris en charge：Linux / macOS / Windows (veuillez installer le SDK .NET à l'aide de la gestion des paquets de distribution ou du script d'installation officiel)
- L'espace disque et la mémoire sont recommandés：Au moins 2 Go de disque libre et 4 Go de mémoire

## Installer le SDK .NET 10

Installez le SDK .NET 10 à l'aide de la méthode d'installation officielle ou du gestionnaire de packages, par exemple：

```bash
# Linux (à l'aide de scripts Microsoft)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --canal 10.0
```

```bash
# macOS (por ejemplo, Homebrew)
brew install --cask dotnet-sdk # Vérifiez ensuite les versions disponibles via brew info ou utilisez le script dotnet-install
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Canal 10.0
```

Après l'installation, ajoutez le chemin d'accès du SDK au PATH ou exécutez-le avec le chemin d'accès complet dans le terminal. Vérifiez l'installation：

```bash
dotnet --info
```

La sortie doit contenir la version du SDK commençant par « 10 », par exemple, 10.0.x.

## Outils globaux (obligatoire)

- Exécuter dynamiquement des scripts C# (REPL/builds scriptées/widgets)

```bash
dotnet tool install -g dotnet-script
```

- Collections de programmes et/ou packages (pour générer un assembly unique ou fusionner des dépendances tierces)

```bash
dotnet tool install -g dotnet-ilrepack
```

Une fois l'installation terminée, vérifiez que l'outil est disponible：

```bash
dotnet-script --version
ilrepack / ?
```
