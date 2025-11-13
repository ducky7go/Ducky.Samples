<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.PackageFromNuget/README.md) | [영어] (../../en/Ducky.PackageFromNuget/README_en.md) | [도이치] (../../de/Ducky.PackageFromNuget/README_de.md) | [프랑세] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [스페인어] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [일본어] (../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget образец мода

Краткое описание

В этом примере показано, как использовать сторонние пакеты NuGet в модах на примере YamlDotNet, включая управление зависимостями, доступ к файлам ресурсов и развертывание пакетов зависимостей.

Прежде чем начать, убедитесь, что требования к предварительной среде подготовлены: [Подготовка среды](../docs/Prequirement.md)

## 1. Введение в проект

Этот каталог (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) демонстрирует, как расширить функционал модов：

- ✅ Знакомство со сторонними пакетами NuGet
- ✅ Парсинг данных с помощью внешних библиотек (YAML)
- ✅ Доступ к файлу ресурсов Mod
- ✅ Автоматическая обработка упаковки зависимостей

\*\* Пример сценария：\*\* Используйте библиотеку YamlDotNet для чтения и анализа файла конфигурации YAML в папке Mod Resources.

## 2. Структура проекта

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Настройка проекта
├── ModBehaviour.cs # Класс входа в мод
├── README.md
└── активы/
    ├── info.ini # Мета информация о моде
    ├── preview.png # Превью изображение
    └── nice.yml # Пример файла YAML
```

## 3. Настройка проекта

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>все</PrivateAssets>
      <IncludeAssets>Среды выполнения; строить; родной; файлы содержимого; Анализаторы; 빌드전이적</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

Ключевые моменты：\*\*

- SDK использует PrivateAssets, чтобы избежать упаковки в выходные данные
- Сторонние библиотеки (YamlDotNet) автоматически упаковываются в директорию вывода мода

## 4. NuGet 다운로드

### Способ 1：Используйте интерфейс командной строки (рекомендуется)

```bash
cd Ducky.PackageFromNuget
dotnet 패키지 추가 YamlDotNet
```

### Способ 2：Ручное редактирование .csproj

В «<ItemGroup>' добавлено：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Способ 3：Использование Visual Studio

1. Щелкните правой кнопкой мыши проект → управления пакетами NuGet
2. Искать "YamlDotNet"
3. Нажмите "Установить"

## 5) Примеры реализации

### Файл ресурсов

['активы/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader 를 사용합니다.
  название: "Хорошая конфигурация YAML"
  설명: "Это демонстрация загрузки YAML из папки 자산 мода"
```

### Класс входа в мод

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget / ModBehaviour.cs : 1 ) :

```csharp
использование Ducky.Sdk.Logging;
использование ducky.Sdk.ModBehaviours;
с помощью YamlDotNet.Serialization;
использование YamlDotNet.Serialization.NamingConventions;

пространство имен Ducky.PackageFromNuget;

публичный класс ModBehaviour : ModBehaviourBase
{
    защищенное переопределение void ModEnabled()
    {
        Получите директорию, в которой находится сборка мода
        var dir = Path.GetDirectoryName(typeof(ModBehaviour)입니다. Assembly.Location)!;
        var ymlPath = Path.Combine(디렉토리, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Найдено nice.yml:");
            
            Использование YamlDotNet для десериализации файлов YAML
            var deserializer = new DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . 빌드();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = deserializer입니다. Десериализация<NiceData>(yml콘텐츠);
            
            Log.Info($"Название: {niceData.NiceHeader.Title}");
            Log.Info($"Описание: {niceData.NiceHeader.Description}");
        }
        еще
        {
            Log.Warn("nice.yml не найдено!");
        }
    }

    защищенное переопределение void ModDisabled()
    {
        Очистка ресурсов (при необходимости)
    }
}

Класс модели данных
публичный класс NiceData
{
    공개 NiceDateHeader NiceHeader { get; набор; } = новый();

    публичный класс NiceDateHeader
    {
        публичная строка Title { get; набор; } = строка. Пустой;
        공개 문자열 설명 { get; набор; } = строка. Пустой;
    }
}
```

## 6. Доступ к файлу ресурса

### Получить каталог модов

```csharp
Способ 1：По месту сборки (рекомендуется)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour)입니다. Assembly.Location)!;
```

### Доступ к файлу ресурсов

```csharp
assets/ будет скопирован в корневой каталог выходного каталога Mod
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK автоматически：**

- ✅ Копирование библиотеки DLL стороннего пакета NuGet
- ✅ Скопируйте файл ресурсов в выходной каталог
- ✅ Развернуть в каталог игровых модов

## 7. Включите моды

Как только сборка будет успешной, включите мод в интерфейсе управления модами игры：

1. Запустите игру
2. Перейдите в интерфейс управления модами
3. Найти "Ducky.PackageFromNuget"
4. Нажмите «Включить»
5. Проверьте логи игры и вы должны увидеть разобранное содержимое YAML

## 8) Лучшие практики

### ✅ Выберите подходящую библиотеку

- Отдавайте предпочтение библиотекам, совместимым с .NET Standard 2.0/2.1
- Избегайте использования библиотек, специфичных для платформы
- Проверьте, является ли дерево зависимостей библиотеки сложным

### ✅ Управление зависимыми версиями

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Релевантные примеры

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - Базовая структура проекта
- [Ducky.EntranceMod] (.. /Ducky.EntranceMod/README.md- Многоуровневая архитектура (если вам нужно совместно использовать сторонние библиотеки)
- [Документация по подготовке среды] (.. /docs/Prequirement.md)를 사용합니다.

## 10. Резюме

Использование стороннего пакета NuGet может：

- ✅ Быстрое расширение возможностей мода
- ✅ Не изобретайте велосипед
- ✅ Используйте проверенное и стабильное решение
- ✅ Используйте ресурсы сообщества

**Примечания：**

- ⚠️ Убедитесь, что библиотека совместима с .NET Standard 2.1
- ⚠️ Помните о размере зависимости и влиянии на производительность
- ⚠️ Хорошо обрабатывайте конфликты версий
- ⚠️ Соблюдение лицензии сторонней библиотеки
