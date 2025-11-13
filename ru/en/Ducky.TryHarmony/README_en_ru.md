<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.TryHarmony/README.md) | [Английский] (README_en.md) | [Дойч] (../../de/Ducky.TryHarmony/README_de.md) | [Франсе] (../../fr/Ducky.TryHarmony/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.TryHarmony/README_es.md) | [Японский] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Португес] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Традиционный китайский] (../../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony образец мода

Краткое описание

В этом примере демонстрируется мод, использующий HarmonyLib для исправления кода игры во время выполнения. Пример содержит простой патч Harmony (патч сохранения), который приводит к постоянному сбою операции сохранения (SaveFilePatch). Регистрация входа и патча по адресу ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1) реализовано.

Прежде чем начать, убедитесь, что требования к предварительной среде подготовлены: [Подготовка среды](../docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky.TryHarmony/') демонстрирует режим патча Harmony：Зарегистрируйте патч, вызвав PatchAll от Harmony в ModEnabled, и отмените патч в ModDisabled.Увидимся в ключевых реализациях：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Проектная документация：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Включение Harmony в csproj

Чтобы использовать патч Harmony, включите свойство IncludeHarmony в 'Ducky.TryHarmony.csproj'. Например：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>истинный</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. SaveFilePatch

Основная функция 'SaveFilePatch' заключается в том, чтобы операция сохранения постоянно завершалась сбоем, что облегчает демонстрацию эффекта патча и процесса обработки ошибок. Этот пример патча перехватывает метод, связанный с сохранением, и возвращает ошибку (см. ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. Эксплуатация и тестирование

- Сборка проекта：

```bash
dotnet build Ducky.TryHarmony/
```

- Включить моды (развернуть сборки в каталоге модов игры и включить их в игре)
- Попытка сохранить сохранение в игре приводит к ошибке «Сохранение не удалось», указывающей на то, что патч вступил в силу.

5. Общие соображения

- Убедитесь, что для параметра IncludeHarmony установлено значение true, в противном случае код, связанный с Harmony, не будет работать.
- При отладке патча вы можете добавить лог (используя Ducky.Sdk.Logging.Log) в 'ModBehaviour', чтобы убедиться, что вызывается 'PatchAll()'/'UnpatchAll()'.
