<!-- LANG_HEADER_START -->

\| [Китайский упрощенный] (../../Ducky.PackageFromNuget/README.md) | [Английский] (../../en/Ducky.PackageFromNuget/README_en.md) | [Дойч] (../../de/Ducky.PackageFromNuget/README_de.md) | [Франсе] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Эспаньол] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Японский] (README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Португес] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Традиционный китайский] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル MOD

Краткое описание

В этом примере показано, как использовать сторонние пакеты NuGet в модах на примере YamlDotNet, например для управления зависимостями, доступа к файлам ресурсов и развертывания пакетов зависимостей.

Прежде чем начать, убедитесь, что вы подготовили требования к предпроизводственной среде: Подготовьте среду (../docs/Prequirement.md)

## 1. Введение в проект

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) показывает, как расширить функциональность модов：

- ✅ Знакомство со сторонними пакетами NuGet
- ✅ Парсинг данных с помощью внешних библиотек (YAML)
- ✅ Mod リソース ファイルにアクセスする
- ✅ Автоматическая обработка пакетов зависимостей

Пример сценария：\*\* Используйте библиотеку YamlDotNet для чтения и анализа файла конфигурации YAML в папке Mod Resources.

## 2. Структура проекта

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Конфигурация проекта
«ModBehaviour.cs #モードエントリークラス
├── README.md
└── アセット/
    ├── info.ini #モードメタ情報
    «preview.png #プレビュー画像
    └── nice.yml # サンプルYAMLファイル
```

## 3. Структура проекта

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>истинный</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>бег; Строить; ネイティブ; contentファイル; アナライザー; Переходная сборка</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

キーポイント：\*\*

- SDK использует PrivateAssets, чтобы избежать упаковки в выходные данные
- Сторонние библиотеки (YamlDotNet) автоматически упаковываются в директорию вывода мода

## 4. Добавьте пакет NuGet

### Способ 1：Используйте интерфейс командной строки (рекомендуется)

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### Способ 2：Ручное редактирование файла .csproj

で '<ItemGroup>».：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Способ 3：Использование Visual Studio

1. Щелкните правой кнопкой мыши проект → управления пакетами NuGet
2. Искать "YamlDotNet"
3. 「インストール」をクリックします

## 5) Примеры реализации

### リソースファイル

['актив/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  название: "Хорошая конфигурация YAML"
  description: "これは、MOD の assets フォルダーから YAML をロードするデモンストレーションです"
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Используйте ducky.Sdk.Logging.
Ducky.Sdk.ModBehaviours.
YamlDotNet.Сериализация.
Используйте YamlDotNet.Serialization.NamingConventions.

пространство имен Ducky.PackageFromNuget;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    защищенное переопределение void ModEnabled()
    {
        Получите директорию, в которой находится сборка мода
        var dir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
        var ymlPath = Path.Combine(ディレクトリ, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Найдено nice.yml:");
            
            Использование YamlDotNet для десериализации файлов YAML
            var deserializer = new DeserializerBuilder()
                . Соглашения об именовании (Camel case naming conventions.
                . ビルド();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = デシリアライザー。 Десериализация<NiceData>(ymlコンテンツ);
            
            Log.Info($"タイトル: {niceData.NiceHeader.Title}");
            Log.Info($" Описание: {niceData.NiceHeader.Description}");
        }
        Если нет
        {
            Log.Warn("nice.yml не найдено!");
        }
    }

    защищенное переопределение void ModDisabled()
    {
        Очистка ресурсов (при необходимости)
    }
}

データモデルクラス
public クラス NiceData
{
    public NiceDateHeader NiceHeader { get; セット; } = новый();

    パブリック・クラス NiceDateHeader
    {
        публичная строка Title { get; セット; } = строка. Пустой;
        Объяснение публичной строки { get; } セット; } = строка. Пустой;
    }
}
```

## 6. リソースファイルへのアクセス

### Получить каталог модов

```csharp
Способ 1：По месту сборки (рекомендуется)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
```

### リソースファイルにアクセスする

```csharp
Директория assets/ копируется в корневую директорию выходной директории Mod
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK автоматически：**

- ✅ サード パーティの NuGet パッケージの DLL をコピーする
- ✅ Скопируйте файл ресурсов в выходной каталог
- ✅ ゲーム mods ディレクトリにデプロイする

## 7. Включите моды

Как только сборка будет успешной, включите мод в интерфейсе управления модами игры：

1. Запустите игру
2. Перейдите в интерфейс управления модами
3. Выполните поиск по запросу "Ducky.PackageFromNuget".
4. Нажмите «Включить»
5. Если вы проверите логи игры, то увидите содержимое разобранного YAML

## 8) ベストプラクティス

### ✅ Выберите подходящую библиотеку

- Отдайте приоритет библиотекам, совместимым с .NET Standard 2.0/2.1
- Избегайте использования библиотек, специфичных для платформы
- Проверьте, является ли дерево зависимостей библиотеки сложным

### ✅ Зависимое управление версиями

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Связанное дело

- [ダッキー・シングルプロジェクト] (../Ducky.SingleProject/README.md) - базовая структура проекта
- [ダッキー・エントランス・モッド] (.. /Ducky.EntranceMod/README.md - Многоуровневая архитектура (если вам нужно поделиться сторонними библиотеками)
- Документация по подготовке среды (../docs/Prequirement.md)

## 10. プロット

При использовании стороннего пакета NuGet,：

- ✅ Быстрое расширение функционала мода
- ✅ Не изобретайте велосипед
- ✅ Используйте проверенные и стабильные решения
- ✅ Использование ресурсов сообщества

**Заметка：**

- ⚠️ Убедитесь, что ваша библиотека совместима с .NET Standard 2.1
- ⚠️ Помните о размере зависимостей и их влиянии на производительность
- ⚠️ Обрабатывайте конфликты версий надлежащим образом
- ⚠️ Соответствие требованиям сторонних библиотечных лицензий
