<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.SingleProject/README.md) | [Английский] (../../en/Ducky.SingleProject/README_en.md) | [Дойч] (../../de/Ducky.SingleProject/README_de.md) | [Франсе] (../../fr/Ducky.SingleProject/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.SingleProject/README_es.md) | [Японский] (README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Португес] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Традиционный китайский] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

Краткое описание

В этом примере показано, как использовать Ducky.Sdk для создания модов для одного проекта, включая инициализацию проекта, развертывание SDK, жизненный цикл мода и процесс упаковки.

Прежде чем начать, убедитесь, что вы подготовили предварительные требования к среде: Подготовьте среду (../docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky.SingleProject/') показывает режим SingleProject Mod：Весь код и ресурсы размещаются в одном проекте, а входной класс наследует 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Инициализация проекта

- Начните с шаблона или репозитория：Клонируйте репозиторий образцов и откройте "Ducky.SingleProject/".
- Необходимая конфигурация проекта (мы рекомендуем убедиться в этом с помощью '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Program Files (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

пример：Убедитесь, что ModName совпадает с именем сборки/проекта.

1. Установка и настройка Ducky.Sdk

Мы рекомендуем устанавливать Ducky.Sdk через NuGet.Вы можете использовать интерфейс командной строки, чтобы быстро добавить его (например, заменить его на нужную версию)：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>бег; Строить; ネイティブ; contentファイル; アナライザー; Переходная сборка</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Создайте свой первый ModBehaviour

- Входящий класс наследует от ModBehaviourBase и реализует методы жизненного цикла ModEnabled() и ModDisabled().

サンプルコード：

```csharp
Ducky.Sdk.
Используйте ducky.Sdk.Logging.

пространство имен Ducky.SingleProject;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    защищенное переопределение void ModEnabled()
    {
        Запись информации на момент инициализации
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    защищенное переопределение void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod отключен");
    }
}
```

5. Исполнение и упаковка

Общие команды сборки：

```bash
# Соберите все решение (.slnx)
dotnet build Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet build Ducky.SingleProject/
```

6. Включение модов (запуск игры)

Сборка автоматически развертывает мод в каталоге игр, запускает игру и включает мод в интерфейсе управления модами или в игре.После включения вы можете проверить информацию об активации мода в журнале игры.
