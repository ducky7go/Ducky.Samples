<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.SingleProject/README.md) | [English](../../en/Ducky.SingleProject/README_en.md) | [Deutsch](../../de/Ducky.SingleProject/README_de.md) | [Français](../../fr/Ducky.SingleProject/README_fr.md) | [Español](../../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../../ja/Ducky.SingleProject/README_ja.md) | [한국어](../../ko/Ducky.SingleProject/README_ko.md) | [Português](../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](README_ru.md) | [繁體中文](../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject образец мода

Краткое описание

В этом примере показано, как использовать Ducky.Sdk для создания мода для одного проекта, включая инициализацию проекта, внедрение SDK, жизненный цикл мода и процесс упаковки.

Прежде чем начать, убедитесь, что требования к предварительной среде готовы: [Подготовка среды](../docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky.SingleProject/') демонстрирует режим SingleProject Mod：Весь код и ресурсы размещаются в одном проекте, а входной класс наследует 'ModBehaviourBase', см. ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Инициализация проекта

- Начните с шаблона или репозитория：Клонируйте репозиторий образцов и откройте 'Ducky.SingleProject/'.
- Необходимая настройка проекта (рекомендуется гарантировать в '.csproj')：

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

пример：Убедитесь, что ModName совпадает с именем сборки/проекта.

1. Установка и настройка Ducky.Sdk

Рекомендуется установить Ducky.Sdk через NuGet.Вы можете использовать интерфейс командной строки для быстрого добавления (пример - пожалуйста, замените на нужную версию)：

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

- Входящий класс наследует базу ModBehaviourBase и реализует методы жизненного цикла ModEnabled() и ModDisabled().

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
# Сборка всего решения (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# Соберите только один пример проекта
dotnet build Ducky.SingleProject/
```

6. Включить мод (запустить игру)

Build автоматически развертывает моды в каталоге игр и запускает игру, чтобы включить мод в интерфейсе управления модами или в игре.После включения вы можете увидеть информацию об активации мода в журнале игры.
