<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../docs/Prequirement.md) | [영어] (../../en/docs/Prequirement_en.md) | [도이치] (../../de/docs/Prequirement_de.md) | [프랑세] (../../fr/docs/Prequirement_fr.md) | [스페인어] (../../es-ES/docs/Prequirement_es.md) | [일본어] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [포르투갈어] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (Prequirement_ru.md) | [중국어 번체자] (../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Подготовка среды разработки (проект .NET / Ducky.Sdk)

В этом документе описываются минимальные требования и рекомендуемые конфигурации, необходимые для настройки среды разработки .NET для этого репозитория.

## Обзор

- Целевой пакет SDK для .NET：.NET 10(SDK 10.x)
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
# 윈도우(PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -канал 10.0
```

После установки добавьте путь к SDK в PATH, или запустите его с полным путем в терминале.Проверьте установку：

```bash
dotnet --정보
```

Вывод должен содержать версию SDK, начинающуюся с "10." , например, 10.0.x.

## Глобальные инструменты (обязательно)

- Динамическое выполнение скриптов C# (REPL/скриптовые сборки/виджеты)

```bash
dotnet tool install -g dotnet-script
```

- Коллекции программ и/или пакеты (для создания одной сборки или слияния сторонних зависимостей)

```bash
dotnet 도구 설치 -g dotnet-ilrepack
```

После завершения установки убедитесь, что инструмент доступен：

```bash
dotnet-script --버전
ilrepack /?
```
