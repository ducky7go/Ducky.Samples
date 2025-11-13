<!-- LANG_HEADER_START -->

\| [簡體中文](../../Ducky.BuffRegistration/README.md) | [English](../../en/Ducky.BuffRegistration/README_en.md) | [Deutsch](../../de/Ducky.BuffRegistration/README_de.md) | [Français](../../fr/Ducky.BuffRegistration/README_fr.md) | [Español](../../es-ES/Ducky.BuffRegistration/README_es.md) | [日本語](../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어](../../ko/Ducky.BuffRegistration/README_ko.md) | [Português](../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский](README_ru.md) | [繁體中文](../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.BuffРегистрация образец мода

Краткое описание

В этом примере показано, как использовать Ducky.Sdk для регистрации пользовательского усиления, включая локализованные ключи и макеты активов.Ввод и реализация см. ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

Прежде чем начать, убедитесь, что требования к предварительной среде подготовлены: [Подготовка среды](../docs/Prequirement.md)

1. Введение в проект

Этот каталог (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1Демонстрирует шаблон регистрации баффов через Contract.Buffs в моде на один проект.Этот проект также содержит ключи локализации, см. ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. Инициализация проекта

- Клонируйте репозиторий и откройте 'Ducky.BuffRegistration/'.
- Рекомендуется включить как минимум .csproj：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.BuffРегистрация</ModName>
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
    <IncludeAssets>Среды выполнения; строить; родной; файлы содержимого; Анализаторы; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Регистрация пользовательского баффа (пример)

Используйте Contract.Buffs.RegisterBuff для регистрации баффа и установки отображаемого имени, описания, значка и времени жизни в обратном вызове.пример：

```csharp
использование Ducky.Sdk;

публичный класс ModBehaviour : ModBehaviourBase
{
    частный int _buffId;

    защищенное переопределение void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(бафф =>
        {
            полировать. SetDisplayName(ЛК. Пользовательского интерфейса. DoNothingBuffName)
                . SetDescription(LK. Пользовательского интерфейса. DoNothingBuffDescription)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(true)
                . SetTotalLifeTime(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        Прослушивание инициализации сцены：Автоматически дает этот бафф протагонисту при входе на базу (см. ModBehaviour для реализации)
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    защищенное переопределение void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter;
            if (main != null)
            {
                Создание и добавление зарегистрированного экземпляра Buff при входе в базовую сцену
                главный. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. локализация

В этом примере определяется строковый ключ в ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。Файл перевода обычно находится в 'assets/locales/' (доступен для просмотра в исходном каталоге), но будьте осторожны：CSV-файлы перевода, метаданные перевода ('assets/lkeys.json') и файлы проверки ('assets/keys.hash.txt') автоматически собираются и записываются в каталог 'assets/' анализатором/ генератором MSBuild пакета SDK во время компиляции.Таким образом, рекомендуемый рабочий процесс выглядит следующим образом:：

- Определение или изменение ключей в коде (рекомендуется)：Редактировать ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1) и компилирует, а SDK генерирует/обновляет соответствующие метаданные перевода.
- Или редактируйте «активы/локали/непосредственно локально» локально{lang}.csv» и перекомпилировать, чтобы позволить SDK интегрировать изменения.
- Если вы используете перевод на основе файлов (например, запись длинного текста в файл Markdown), вы можете использовать '[TranslateFile("md")]' в 'LK.cs'; SDK поместит соответствующий файл в 'assets/locales/{lang}/' и сошлитесь на него в CSV с именем файла.

Пример ключа：

- «ЛК. Пользовательского интерфейса. DoNothingBuffName»
- «ЛК. Пользовательского интерфейса. DoNothingBuffDescription'

замечание："assets/lkeys.json" и "assets/keys.hash.txt" используются для позиционирования во время выполнения и проверки упаковки, поэтому ручное изменение не рекомендуется. Чтобы принудительно выполнить обновление, очистите и перекомпилируйте проект.

6. Сборка и упаковка

Общие команды сборки：

```bash
dotnet build Ducky.BuffRegistration/
```

6. Включить мод (запустить игру)

Сборка автоматически развернет мод в каталоге игр, включит мод в интерфейсе управления модами игры и запустит игру, чтобы войти на базовую сцену, чтобы увидеть, получил ли протагонист пользовательский бафф.
