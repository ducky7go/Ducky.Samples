<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../docs/Prequirement.md) | [영어] (../../en/docs/Prequirement_en.md) | [도이치] (../../de/docs/Prequirement_de.md) | [프랑세] (Prequirement_fr.md) | [스페인어] (../../es-ES/docs/Prequirement_es.md) | [일본어] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [포르투갈어] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [중국어 번체자] (../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Préparation de l'environnement de développement (projet .NET / Ducky.Sdk)

Ce document décrit la configuration minimale requise et les configurations recommandées requises pour configurer un environnement de développement .NET pour ce référentiel.

## 아페르수

- Kit de développement logiciel (SDK) .NET cible：.NET 10(SDK 10.x)
- Outils mondiaux nécessaires：
  - Utilisé pour exécuter dynamiquement des scripts C #：'dotnet-script'
  - Utilisé pour les collections de programmes et/ou l'emballage：'dotnet-ilrepack'

## 구성 요구 사항:

- Systèmes d'exploitation pris en charge：Linux / macOS / Windows (veuillez installer le SDK .NET à l'aide de la gestion des paquets de distribution ou du script d'installation officiel)
- L'espace disque et la mémoire sont recommandés：Au moins 2 Go de disque libre et 4 Go de mémoire

## Installer le SDK .NET 10

Installez le SDK .NET 10 à l'aide de la méthode d'installation officielle ou du gestionnaire de packages, par exemple：

```bash
# Linux (à l'aide de scripts Microsoft)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --운하 10.0
```

```bash
# macOS(예: Homebrew)
brew install --cask dotnet-sdk # Vérifiez ensuite les versions disponibles via brew info ou utilisez le script dotnet-install
```

```bash
# 윈도우(PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -운하 10.0
```

Après l'installation, ajoutez le chemin d'accès du SDK au PATH ou exécutez-le avec le chemin d'accès complet dans le terminal. Vérifiez l'installation：

```bash
dotnet --정보
```

La sortie doit contenir la version du SDK commençant par « 10 », par exemple, 10.0.x.

## Outils globaux (obligatoire)

- Exécuter dynamiquement des scripts C# (REPL/builds scriptées/widgets)

```bash
dotnet tool install -g dotnet-script
```

- Collections de programmes et/ou packages (pour générer un assembly unique ou fusionner des dépendances tierces)

```bash
dotnet 도구 설치 -g dotnet-ilrepack
```

Une fois l'installation terminée, vérifiez que l'outil est disponible：

```bash
dotnet-script --버전
일레팩 / ?
```
