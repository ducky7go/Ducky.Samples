<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.SingleProject/README.md) | [Английский] (../../en/Ducky.SingleProject/README_en.md) | [Дойч] (../../de/Ducky.SingleProject/README_de.md) | [Франсе] (../../fr/Ducky.SingleProject/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.SingleProject/README_es.md) | [Японский] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Португес] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Традиционный китайский] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject образец мода

Краткое объяснение

В этом примере показано, как создать мод для одного проекта с помощью Ducky.Sdk, включая инициализацию проекта, внедрение SDK, жизненный цикл мода и процесс упаковки.

Прежде чем начать, убедитесь, что предварительные требования к среде готовы： [Подготовка окружающей среды](.. /docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky. SingleProject/') демонстрирует режим SingleProject Mod：Весь код и ресурсы размещаются в одном проекте, а входной класс наследует 'ModBehaviourBase', который может быть реализован в ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1).

2. Инициализация проекта

- Начните с шаблона или склада：Клонируйте репозиторий образцов и откройте "Ducky.SingleProject/".
- Обязательные настройки товара (рекомендуется гарантировать в '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

пример：Убедитесь, что ModName согласуется с именем сборки/проекта.

1. Установка и настройка Ducky.Sdk

Рекомендуется установить Ducky.Sdk через NuGet.Вы можете использовать CLI для быстрого добавления (пример - замена на нужную версию)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>все</PrivateAssets>
    <IncludeAssets>Среды выполнения; строить; родной; файлы содержимого; Анализаторы; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Напишите первый ModBehaviour

- Входной класс должен наследовать 'ModBehaviourBase' и реализовывать методы жизненного цикла 'ModEnabled()' и 'ModDisabled()'.

Пример кода：

```csharp
использование Ducky.Sdk;
использование Ducky.Sdk.Logging;

пространство имен Ducky.SingleProject;

публичный класс ModBehaviour : ModBehaviourBase
{
    защищенное переопределение void ModEnabled()
    {
        Запись информации при инициализации
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    защищенное переопределение void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod отключен");
    }
}
```

5. Запуск и упаковка

Общие команды сборки：

```bash
# Соберите все решение (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Соберите только один пример проекта
dotnet build Ducky.SingleProject/
```

6. Открыть мод (запустить игру)

Build автоматически развернет моды в каталоге игр и запустит игру, чтобы включить мод в интерфейсе управления модами или в игре.После активации вы можете увидеть информацию об активации мода в журнале игры.
