<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.InstantKill/README.md) | [영어] (../../en/Ducky.InstantKill/README_en.md) | [도이치] (../../de/Ducky.InstantKill/README_de.md) | [프랑세] (../../fr/Ducky.InstantKill/README_fr.md) | [스페인어] (../../es-ES/Ducky.InstantKill/README_es.md) | [일본어] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill образец мода

Краткое описание

В этом примере реализован простой мод, который убивает главного героя, как только он атакует врага.При включении, если источником урона является главный герой, он нанесет большой урон цели и убьет ее мгновенно.Реализация см. ['Ducky.InstantKill/ModBehaviour.cs'] (Ducky.InstantKill/ModBehaviour.cs:1).

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
    <ModName>덕키.인스턴트 킬</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Установка и настройка Ducky.Sdk

Мы рекомендуем добавить SDK через NuGet：

```bash
dotnet 패키지 추가 Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>все</PrivateAssets>
    <IncludeAssets>Среды выполнения; строить; родной; файлы содержимого; Анализаторы; 빌드전이적</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Написать ModBehaviour

Входящий класс наследует базу ModBehaviourBase и реализует методы жизненного цикла ModEnabled() и ModDisabled().В этом примере процессор регистрирует событие 'OnHurt' для нанесения большого урона цели, когда урон исходит от главного героя.

Пример кода：

```csharp
использование Ducky.Sdk;
использование Ducky.Sdk.Logging;

Ducky.InstantKill 사용 설명서;

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

    개인 무효 Health_OnHurt(체력 h, DamageInfo da)
    {
        Если (da. То(ч). IsFromMainToEnemy())를 사용합니다.
        {
            Log.Debug("Мод на мгновенное убийство: Убийство врага.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                손상 값 = 1000,
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
