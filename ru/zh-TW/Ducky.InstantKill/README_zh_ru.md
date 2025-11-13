<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.InstantKill/README.md) | [Английский] (../../en/Ducky.InstantKill/README_en.md) | [Дойч] (../../de/Ducky.InstantKill/README_de.md) | [Франсе] (../../fr/Ducky.InstantKill/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.InstantKill/README_es.md) | [Японский] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Португес] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Традиционный китайский] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill образец мода

Краткое объяснение

В этом примере реализован простой мод, который убивает главного героя, когда тот атакует врага.После активации, когда происходит событие ранения, если источником урона является главный герой, он нанесет большой урон цели и мгновенно убьет ее.Для реализации смотрите ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Прежде чем начать, убедитесь, что требования к среде фронтенда готовы： [Подготовка окружающей среды](.. /docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky. InstantKill/') демонстрирует режим мода для одного проекта：Весь код и ресурсы размещаются в одном проекте, а входной класс наследует 'ModBehaviourBase', см. ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Инициализация проекта

- Клонируйте склад и откройте 'Ducky.InstantKill/'.
- Рекомендуется в ». КСПРОЖ：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.InstantKill</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Установка и настройка Ducky.Sdk

Рекомендуется добавить SDK через NuGet：

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

4. Написать ModBehaviour

Входной класс должен наследовать 'ModBehaviourBase' и реализовывать методы жизненного цикла 'ModEnabled()' и 'ModDisabled()'.В этом примере процессор регистрируется по событию "OnHurt", которое наносит большое количество урона цели, когда урон исходит от основного героя.

Пример кода：

```csharp
использование Ducky.Sdk;
использование Ducky.Sdk.Logging;

пространство имен Ducky.InstantKill;

публичный класс ModBehaviour : ModBehaviourBase
{
    защищенное переопределение void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    защищенное переопределение void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    private void Health_OnHurt(Health h, DamageInfo da)
    {
        Если (da. То(ч). IsFromMainToEnemy())
        {
            Log.Debug("Мод на мгновенное убийство: Убийство врага.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000,
            });
        }
    }
}
```

5. Запуск и упаковка

Общие команды сборки：

```bash
# Соберите решение целиком
dotnet build Docky.Sdk.Sample.slnx

# Соберите только этот проект
dotnet build Ducky.InstantKill/
```

6. Открыть мод (запустить игру)

После того как сборка автоматически развернет мод в каталоге игры, мод будет включен в интерфейсе управления игровыми модами, а эффект можно будет протестировать после того, как игра выйдет на сцену поля боя：Когда протагонист атакует врага, враг должен мгновенно умереть.
