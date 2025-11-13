<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.TryHarmony/README.md) | [Английский] (../../en/Ducky.TryHarmony/README_en.md) | [Дойч] (../../de/Ducky.TryHarmony/README_de.md) | [Франсе] (../../fr/Ducky.TryHarmony/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.TryHarmony/README_es.md) | [Японский] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Португес] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Традиционный китайский] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony образец мода

Краткое объяснение

В этом примере демонстрируется использование HarmonyLib для исправления мода для кода игры во время выполнения.Пример содержит простой патч Harmony (патч сохранения), в результате которого операция сохранения постоянно завершается сбоем (SaveFilePatch).Регистрация входа и патча реализована в ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1).

Прежде чем начать, убедитесь, что требования к среде фронтенда готовы： [Подготовка окружающей среды](.. /docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky. TryHarmony/') демонстрирует режим патча Harmony：Зарегистрируйте патч, вызвав PatchAll от Harmony в ModEnabled, и отмените патч в ModDisabled.Увидимся в ключевых реализациях：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Файл проекта：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Включение Harmony в csproj

Чтобы использовать патч Harmony, включите свойство IncludeHarmony в 'Ducky.TryHarmony.csproj'.Например：

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

Основная функция 'SaveFilePatch' заключается в том, чтобы операции сохранения (сохранения игры) завершались сбоем, что облегчает демонстрацию эффекта патча и процесса обработки ошибок.Пример патча перехватывает метод, связанный с сохранением, и возвращает ошибку (см. ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)).

4. Обкатка и тестирование

- Сборка проектов：

```bash
dotnet build Ducky.TryHarmony/
```

- Открывайте моды (размещайте сборки в каталоге модов игры и открывайте их в игре)
- Попытка сохранить сохранение в игре приводит к ошибке «Не удалось сохраниться», указывающей на то, что патч активен.

5. Общие меры предосторожности

- Убедитесь, что для параметра 'IncludeHarmony' установлено значение 'true', в противном случае код, связанный с Harmony, не будет работать должным образом.
- При отладке патчей лог может быть добавлен в 'ModBehaviour' (используя 'Ducky.Sdk.Logging.Log'), чтобы убедиться, что вызывается 'PatchAll()'/'UnpatchAll()'.
