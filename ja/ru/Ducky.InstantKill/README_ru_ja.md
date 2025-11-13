<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.InstantKill/README.md) | [日本語](../../en/Ducky.InstantKill/README_en.md) | [ドイツ語](../../de/Ducky.InstantKill/README_de.md) | [フランセ](../../fr/Ducky.InstantKill/README_fr.md) | [スペイン語](../../es-ES/Ducky.InstantKill/README_es.md) | [日本語](../../ja/Ducky.InstantKill/README_ja.md) | [한국어](../../ko/Ducky.InstantKill/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский](README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill のリリース

Краткое описание

В этом примере реализован простой мод, который убивает главного героя, как только он атакует врага.При включении, если источником урона является главный герой, он нанесет большой урон цели и убьет ее мгновенно.Реализация см. ['ダッキー・インスタントキル/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Прежде чем начать, убедитесь, что требования к предварительной среде подготовлены: [Подготовка среды](../docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky.InstantKill/') демонстрирует режим модификации одного проекта：Весь код и ресурсы размещаются в одном проекте, а входной класс наследует 'ModBehaviourBase', как показано в ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Инициализация проекта

- Клонируйте репозиторий и откройте 'Ducky.InstantKill/'.
- Рекомендуется включать как минимум в '.csproj'：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>ダッキー・インスタントキル</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Установка и настройка Ducky.Sdk

Мы рекомендуем добавить SDK через NuGet：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>все</PrivateAssets>
    <IncludeAssets>Среды выполнения; строить; родной; файлы содержимого; Анализаторы; ビルド推移的</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Написать ModBehaviour

Входящий класс наследует базу ModBehaviourBase и реализует методы жизненного цикла ModEnabled() и ModDisabled().В этом примере процессор регистрирует событие 'OnHurt' для нанесения большого урона цели, когда урон исходит от главного героя.

Пример кода：

```csharp
использование Ducky.Sdk;
использование Ducky.Sdk.Logging;

Ducky.InstantKill を更新します。

Публичный класс ModBehaviour : ModBehaviourBase
{
    защищенное переопределение void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    Защищенное переопределение void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    プライベートボイドHealth_OnHurt(ヘルスh、ダメージインフォメーションda)
    {
        Если (da. То(ч). IsFromMainToEnemy())
        {
            Log.Debug("Мод на мгновенное убийство: Убийство врага.");
            h.Hurt(新しい DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000、
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

6. Включить мод (запустить игру)

Build автоматически развернет мод в каталоге игр, включит его в интерфейсе управления модами игры и протестирует эффект после запуска игры и начала боя：Когда протагонист атакует врага, враг должен мгновенно умереть.
