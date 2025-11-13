<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.Localization/README.md) | [Английский] (../../en/Ducky.Localization/README_en.md) | [Дойч] (../../de/Ducky.Localization/README_de.md) | [Франсе] (../../fr/Ducky.Localization/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.Localization/README_es.md) | [Японский] (README_ja.md) | [한국어] (../../ko/Ducky.Localization/README_ko.md) | [Португес] (../../pt-PT/Ducky.Localization/README_pt.md) | [Русский] (../../ru/Ducky.Localization/README_ru.md) | [Традиционный китайский] (../../zh-TW/Ducky.Localization/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.Локализация サンプル MOD

Краткое описание

В этом примере показано, как определить и организовать ключи локализации в автономном моде, а также как поместить переводы в ресурсы для использования во время выполнения.Определения входа и ключа определены в ['Ducky.Localization/ModBehaviour.cs'](Ducky.Localization/ModBehaviour.cs:1) を ['Ducky.Localization/LK.cs'](Ducky.Localization/LK.cs:1)。

Прежде чем начать

Для начала ознакомьтесь со средой разработки и подготовьте ее：['ドキュメント/Prequirement.md'] (docs/Prequirement.md:1)。

Структура проекта (точки)

- ['ダッキー.ローカライゼーション/ModBehaviour.cs'] (Ducky.Localization/ModBehaviour.cs:1— Запись мода, которая показывает, как ссылаться на локализованную строку.
- ['Ducky.Локализация/LK.cs'] (Ducky.Localization/LK.cs:1— Статически локализованные определения ключей (рекомендуется поддерживать в коде).
- ['Ducky.Локализация/активы/'] (Ducky.Localization/assets/:1— Включает такие ресурсы, как перевод CSV, переводы на основе документов и пояснения.

ローカライズキー(LK.cs)

- ['Ducky.Локализация/LK.cs'] (Ducky.Localization/LK.cs:1) с использованием ключа организации статической константы (например,：классификация пользовательского интерфейса).
- Длинный текст можно найти в аннотации '[TranslateFile("md)]]' ('assets/Locales/{lang}/') в виде файла.
- Чтобы объявить поддерживаемый язык, используйте атрибут LanguageSupport("en","en","en-hant")]' (если требуется).

Перевод и создание файлов

- Перевести CSV：'assets/ロケール/{lang}.csv», в виде ключей и значений.
- Документный перевод：「активы/локали/{lang}/', медиана CSV ссылается на имя файла (например,：'"ducky.singleproject.ui.longdescription.md"。
- 'assets/lkeys.json' и 'assets/keys.hash.txt' не следует редактировать вручную, так как они генерируются MSBuild SDK во время компиляции для проверки позиционирования и упаковки во время выполнения.

Рекомендуемый рабочий процесс

- Добавление или изменение ключей в коде (рекомендуется)：['Ducky.Локализация/LK.cs'] (Ducky.Localization/LK.cs:1), и SDK обновит метаданные перевода.
- Или редактируйте «активы/локали/напрямую»{lang}.csv» и перекомпилируйте его, чтобы SDK мог интегрировать изменения.

Примеры использования:

```csharp
Используйте Ducky.Sdk.Localizations.
var message = L.UI です。 ナイスウェルカムメッセージ; Он разрешается в перевод текущего языка во время выполнения
```

Сборка и запуск

```bash
dotnet build Ducky.Localization/
# или собрать решение целиком
dotnet build Docky.Sdk.Sample.slnx
```

Видеть

- Убедитесь, что для параметра '.csproj' установлено значение '.<ModName>' с атрибутом General project (см. другие примеры проектов).
- Для длинных текстов рекомендуется использовать перевод на основе файлов, чтобы улучшить обслуживание репозитория исходного кода.

Заканчивать
