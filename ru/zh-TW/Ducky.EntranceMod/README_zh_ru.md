<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.EntranceMod/README.md) | [Английский] (../../en/Ducky.EntranceMod/README_en.md) | [Дойч] (../../de/Ducky.EntranceMod/README_de.md) | [Франсе] (../../fr/Ducky.EntranceMod/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.EntranceMod/README_es.md) | [Японский] (../../ja/Ducky.EntranceMod/README_ja.md) | [한국어] (../../ko/Ducky.EntranceMod/README_ko.md) | [Португес] (../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский] (../../ru/Ducky.EntranceMod/README_ru.md) | [Традиционный китайский] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod образец мода

Краткое объяснение

В этом примере показано, как разрабатывать моды с использованием шаблона многоуровневой архитектуры, разделяя общий код на независимые библиотечные проекты и добиваясь повторного использования кода и модульного дизайна.Подходит для больших модов или сценариев, в которых код должен быть общим для нескольких модов.

Прежде чем начать, убедитесь, что требования к среде фронтенда готовы： [Подготовка окружающей среды](.. /docs/Prequirement.md)

## 1. Введение в проект

Этот пример состоит из двух элементов：

- **Основной проект мода** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Запись мода, содержащая файлы ресурсов
- **Проект публичной библиотеки** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Общая кодовая база

Применяется этот архитектурный шаблон：

- Большие моды требуют иерархического управления
- Несколько модов имеют общую логику
- Совместная разработка в команде
- Бизнес-логику нужно тестировать самостоятельно

## 2. Структура проекта

```
Ducky.EntranceMod/ # Основной мод проект
├── Ducky.EntranceMod.csproj # Настройка проекта
├── ModBehaviour.cs # Мод вход
├── README.md
└── assets/ # каталог документов ресурсов
    «info.ini
    ├── description.md
    «lkeys.json
    «keys.hash.txt
    └── Локали/
        «zh.csv
        └── en.csv

ducky.EntranceMod.Common/ # проект публичной библиотеки
├── Ducky.EntranceMod.Common.csproj # Настройка проекта библиотеки
├── LK.cs # Поделиться ключом локализации
└── MyModBase.cs # Общий базовый класс
```

## 3. Основная конфигурация проекта мода

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1).：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>истинный</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>все</PrivateAssets>
      <IncludeAssets>Среды выполнения; строить; родной; файлы содержимого; Анализаторы; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**Описание конфигурации ядра：**

- \\`<ExcludeSdkLib>истинный</ExcludeSdkLib>- Избегайте многократной упаковки библиотек SDK в директорию вывода

## 4. Конфигурация проекта публичной библиотеки

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1).：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>истинный</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/активы</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>все</PrivateAssets>
      <IncludeAssets>Среды выполнения; строить; родной; файлы содержимого; Анализаторы; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**Описание конфигурации ядра：**

- \\`<IsModLib>истинный</IsModLib>' - Отметьте этот элемент как библиотеку модов, и SDK будет обрабатывать его специально
- \\`<AssetsDir>' - Указывает на каталог активов основного проекта, чтобы ключ локализации был сгенерирован корректно

## 5. Поделитесь примерами кода

### Общий доступ к ключам локализации

['Ducky.EntranceMod.Common/LK.cs'] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
пространство имен Ducky.EntranceMod.Common;

публичный статический класс LK
{
    Пользовательский интерфейс открытого статического класса
    {
        public const string NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### Общие базовые классы

['Ducky.EntranceMod.Common/MyModBase.cs'] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
использование Ducky.Sdk.ModBehaviours;

пространство имен Ducky.EntranceMod.Common;

публичный абстрактный класс MyModBase : ModBehaviourBase
{
    Здесь можно добавить общий метод, общий для всех модов
    защищенная виртуальная пустота LogModInfo(строковое сообщение)
    {
        Log.Info($"[{GetType(). Имя}] {message}");
    }
}
```

### Основной мод использует общий код

['Ducky.EntranceMod/ModBehaviour.cs'] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
использование Ducky.Sdk.Logging;
использование Ducky.EntranceMod.Common;

пространство имен Ducky.EntranceMod;

Наследование общего базового класса
публичный класс ModBehaviour : MyModBase
{
    защищенное переопределение void ModEnabled()
    {
        Log.Info("Мод включен");
        Использование общего ключа локализации
        var message = LK. Пользовательского интерфейса. NiceWelcomeMessage;
        LogModInfo($"Ключ приветственного сообщения: {message}");
    }

    защищенное переопределение void ModDisabled()
    {
        Log.Info("Мод отключен");
    }
}
```

## 6. Преимущества многослойной архитектуры

### ✅ Кодовое мультиплексирование

- Несколько модов могут совместно использовать библиотеку 'Ducky.EntranceMod.Common'
- Избегайте дублирования кода и повышайте удобство сопровождения

### ✅ Модульная конструкция

- Бизнес-логика отделена от ввода Mod
- Простое модульное тестирование
- Понятные зависимости

### ✅ Совместная работа в команде

- Разные разработчики могут разрабатывать разные слои независимо друг от друга
- Уменьшение количества конфликтов кода
- Простая проверка кода

### ✅ Локализованный общий доступ

- В публичных библиотеках можно определять общие ключи локализации
- Все моды, использующие библиотеку, автоматически поддерживаются для перевода

## 7. Постройте процесс

SDK автоматически обрабатывает зависимости из нескольких элементов：

```bash
# Соберите решение целиком (рекомендуется)
dotnet build Docky.Sdk.Sample.slnx

# или соберите основной проект отдельно (проект зависимой библиотеки будет собран автоматически)
dotnet build Ducky.EntranceMod/
```

\*\* Сборка продуктов：\*\*

- Основной набор модов + сборка публичной библиотеки будут упакованы вместе
- Файл ресурсов получается из директории 'assets/' основного проекта
- Библиотеки SDK не включаются повторно (потому что '<ExcludeSdkLib>истинный</ExcludeSdkLib>\\`）

## 8. Включите моды

После сборки моды автоматически развертываются в каталоге игр：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
«Ducky.EntranceMod.dll
«Ducky.EntranceMod.Common.dll
└── активы/
    «info.ini
    «lkeys.json
    └── Локали/</游戏目录>
```

Включите мод в интерфейсе управления модами игры.

## 9. Предложения по расширению

### Создание большего количества публичных библиотек

Для сложных проектов можно создать несколько публичных библиотек：

```
Ducky.EntranceMod/ # Мастер Мод
Ducky.EntranceMod.Common/ # Универсальный код
Ducky.EntranceMod.Геймплей/ # Логика геймплея
Ducky.EntranceMod.UI/ # Связанные с пользовательским интерфейсом
```

## 10. Часто задаваемые вопросы

### Q： Зачем ставить '<ExcludeSdkLib>истинный</ExcludeSdkLib>\\`？

A： Избегайте дублирования упаковки файлов библиотеки Ducky.Sdk в директорию вывода мода.Библиотека SDK уже существует в игре и не нуждается в повторном включении.

### Q: \\`<AssetsDir>Нужно ли его устанавливать?

A： Для проектов публичных библиотек, если включен ключ локализации (LK.cs), параметр «<AssetsDir>' в директорию активов основного проекта, чтобы SDK мог правильно генерировать локализованные метаданные.

### Q： Могут ли несколько основных проектов модов использовать одну и ту же публичную библиотеку?

A： ХОРОШО!В этом и заключается преимущество многоуровневых архитектур.Несколько модов могут ссылаться на один и тот же проект публичной библиотеки.

### Q： Где будет генерироваться ключ локализации для публичной библиотеки?

A： произведет '<AssetsDir>' в указанном каталоге, т.е. в файле 'lkeys.json' в каталоге 'assets/' мастер-проекта.

## 11. Связанные ресурсы

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - Справочник по шаблону для одного проекта
- [Ducky.Локализация] (.. /ducky.Localization/README.md) - Подробное объяснение системы локализации
- [Документ по подготовке к охране окружающей среды] (../docs/Prequirement.md)

## 12. Резюме

Подходит шаблон многоуровневой архитектуры：

- ✅ Большие мод проекты
- ✅ Сценарии, требующие повторного использования кода
- ✅ Совместная разработка в команде
- ✅ Серия Разработка модов

Если ваш мод относительно простой, мы рекомендуем использовать [Ducky.SingleProject](.. /Ducky.SingleProject/README.md) в режиме одного проекта.
