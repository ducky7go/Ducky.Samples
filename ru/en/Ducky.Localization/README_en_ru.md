<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.Localization/README.md) | [Английский] (README_en.md) | [Дойч] (../../de/Ducky.Localization/README_de.md) | [Франсе] (../../fr/Ducky.Localization/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.Localization/README_es.md) | [Японский] (../../ja/Ducky.Localization/README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [Португес] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [Традиционный китайский] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Пример мода на локализацию

Краткое описание

В этом примере показано, как определить и упорядочить ключи локализации в автономном моде и как поместить переводы в ресурсы для использования во время выполнения. Определения входов и ключей отображаются в ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) с ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Прежде чем начать

Пожалуйста, сначала прочтите и подготовьте свою среду разработки：['docs/Prequirement.md'] (docs/Prequirement.md:1)。

Структура проекта (ключевые моменты)

- ['Ducky.Локализация/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1) — Запись мода, которая демонстрирует, как ссылаться на локализованные строки.
- ['Ducky.Локализация/LK.cs'] (Ducky.Localization/LK.cs:1) — Статические локализованные определения ключей (рекомендуется поддерживать в коде).
- ['Ducky.Локализация/активы/'] (Ducky.Localization/assets/:1) — Содержит такие ресурсы, как перевод CSV, переводы на основе документов и описания.

Ключ локализации (LK.cs)

- В ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) с использованием статических ключей организации констант (например,：классификация пользовательского интерфейса).
- Длинный текст может быть переведен в файл с помощью аннотации '[TranslateFile("md)]]' (которая генерирует 'assets/Locales/{lang}/' в файле).
- Чтобы объявить поддерживаемый язык, используйте атрибут [LanguageSupport("en","en","zh-hant")]' (при желании).

Переводите файлы и генерируйте

- Перевести CSV：\'активы/Языковые стандарты/{lang}.csv', в формате Ключ, Значение.
- Документный перевод：Размещено в разделе «активы/локали/{lang}/', медиана CSV ссылается по имени файла, например：'"ducky.singleproject.ui.longdescription.md"。
- 'assets/lkeys.json' и 'assets/keys.hash.txt' будут сгенерированы MSBuild SDK во время компиляции для проверки позиционирования и упаковки во время выполнения, поэтому, пожалуйста, не редактируйте их вручную.

Рекомендуемые рабочие процессы

- Добавление или изменение ключей в коде (рекомендуется)：Редактировать ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1) и скомпилирует, а SDK обновит метаданные перевода.
- Или редактируйте «активы/локали/напрямую»{lang}.csv» и перекомпилировать, чтобы позволить SDK интегрировать изменения.

Примеры использования

```csharp
использование Ducky.Sdk.Localizations;
var message = L.UI. NiceWelcomeMessage; Преобразуется в перевод текущего языка во время выполнения
```

Сборка и запуск

```bash
dotnet build Ducky.Localization/
# или собрать решение целиком
dotnet build Docky.Sdk.Sample.slnx
```

замечание

- Убедитесь, что для параметра '.csproj' установлено значение '<ModName>' с общим атрибутом project (см. другие примеры проектов).
- Для длинных текстов рекомендуется использовать перевод на основе файлов для лучшего сопровождения в репозиториях исходного кода.

заканчивать
