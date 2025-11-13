<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../docs/Prequirement.md) | [Traduction] (../../en/docs/Prequirement_en.md) | [Deutsch] (../../de/docs/Prequirement_de.md) | [English] (../../fr/docs/Prequirement_fr.md) | [Español] (../../es-ES/docs/Prequirement_es.md) | [Japonais] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [Português] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (Prequirement_ru.md) | [Chinois traditionnel] (../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Подготовка среды разработки (проект .NET / Ducky.Sdk)

В этом документе описываются минимальные требования и рекомендуемые конфигурации, необходимые для настройки среды разработки .NET для этого репозитория.

## Обзор

- Целевой пакет SDK для .NET：.NET 10 (SDK 10.x)
- Необходимые глобальные инструменты：
  - Используется для динамического выполнения скриптов C #：'dotnet-script'
  - Используется для коллекций программ и/или упаковки：'dotnet-ilrepack'

## Требования к системе:

- Поддерживаемые операционные системы：Linux / macOS / Windows (пожалуйста, установите .NET SDK с помощью управления дистрибутивными пакетами или официального скрипта установки)
- Рекомендуется использовать дисковое пространство и память：Не менее 2 ГБ свободного места на диске и 4 ГБ памяти

## Установка пакета SDK для .NET 10

Установите .NET 10 SDK с помощью официального способа установки или диспетчера пакетов, пример：

```bash
# Linux (с использованием скриптов Microsoft)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --канал 10.0
```

```bash
# macOS (пример Homebrew)
brew install --cask dotnet-sdk # Затем проверьте доступные версии через brew info или используйте скрипт dotnet-install
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -канал 10.0
```

После установки добавьте путь к SDK в PATH, или запустите его с полным путем в терминале.Проверьте установку：

```bash
dotnet --info
```

Вывод должен содержать версию SDK, начинающуюся с "10." , например, 10.0.x.

## Глобальные инструменты (обязательно)

- Динамическое выполнение скриптов C# (REPL/скриптовые сборки/виджеты)

```bash
dotnet tool install -g dotnet-script
```

- Коллекции программ и/или пакеты (для создания одной сборки или слияния сторонних зависимостей)

```bash
dotnet tool install -g dotnet-ilrepack
```

После завершения установки убедитесь, что инструмент доступен：

```bash
dotnet-script --version
ilrepack / ?
```
