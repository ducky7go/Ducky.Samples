<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.TryHarmony/README.md) | [日本語](../../en/Ducky.TryHarmony/README_en.md) | [ドイツ語](../../de/Ducky.TryHarmony/README_de.md) | [フランセ](../../fr/Ducky.TryHarmony/README_fr.md) | [スペイン語](../../es-ES/Ducky.TryHarmony/README_es.md) | [日本語](../../ja/Ducky.TryHarmony/README_ja.md) | [한국어](../../ko/Ducky.TryHarmony/README_ko.md) | [ポルトガル語](../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский](README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony は、

Краткое описание

В этом примере демонстрируется мод, использующий HarmonyLib для исправления кода игры во время выполнения.Пример содержит простой патч Harmony (патч сохранения), который приводит к постоянному сбою операции сохранения (SaveFilePatch).Регистрация входа и патча по адресу ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1) реализовано.

Прежде чем начать, убедитесь, что требования к предварительной среде подготовлены: [Подготовка среды](../docs/Prequirement.md)

1. Введение в проект

Этот каталог ('Ducky.TryHarmony/') демонстрирует режим патча Harmony：Зарегистрируйте патч, вызвав PatchAll от Harmony в ModEnabled, и отмените патч в ModDisabled.Увидимся в ключевых реализациях：

- ['ダッキー・トライハーモニー/ModBehaviour.cs'] (ダッキー・トライハーモニー/ModBehaviour.cs:1)
- ['ダッキー・トライハーモニー/SaveFilePatch.cs'] (ダッキー・トライハーモニー/SaveFilePatch.cs:1)
- Проектная документация：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Включение Harmony в csproj

Чтобы использовать патч Harmony, включите свойство IncludeHarmony в 'Ducky.TryHarmony.csproj'.Например：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>Нетстандарт2.1</TargetFramework>
    <Nullable>давать возможность</Nullable>
    <LangVersion>Предварительный просмотр</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <ModName>ダッキー・トライハーモニー</ModName>
    <IncludeHarmony>истинный</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. ファイルパッチの保存

Основная функция 'SaveFilePatch' заключается в том, чтобы операция сохранения постоянно завершалась сбоем, что облегчает демонстрацию эффекта патча и процесса обработки ошибок.Этот пример патча перехватывает метод, связанный с сохранением, и возвращает ошибку (см. ['ダッキー・トライハーモニー/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

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
