<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../Ducky.PackageFromNuget/README.md) | [Inglés] (../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch] (../../de/Ducky.PackageFromNuget/README_de.md) | [Français] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [English] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japonés] (README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Chino tradicional] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル MOD

簡単な説明

En este ejemplo se muestra cómo usar paquetes NuGet de terceros en mods, usando YamlDotNet como ejemplo, como administración de dependencias, acceso a archivos de recursos e implementación de paquetes de dependencias.

開始する前に、実稼働前の環境要件が準備されていることを確認してください: [環境の準備](../docs/Prequirement.md)

## 1. プロジェクト紹介

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) muestra cómo ampliar la funcionalidad de los mods：

- ✅ Introducción a paquetes NuGet de terceros
- ✅ Análisis de datos mediante bibliotecas externas (YAML)
- ✅ Mod リソース ファイルにアクセスする
- ✅ Controlar automáticamente los paquetes de dependencias

Escenario de ejemplo：\*\* Use la biblioteca YamlDotNet para leer y analizar el archivo de configuración de YAML en la carpeta Mod Resources.

## 2. プロジェクト構造

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Configuración del proyecto
├── ModBehaviour.cs #モードエントリークラス
├── README.md
└── アセット/
    ├── info.ini #モードメタ情報
    ├── preview.png #プレビュー画像
    └── nice.yml # サンプルYAMLファイル
```

## 3. Estructura del proyecto

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>corriente; Construir; ネイティブ; contenidoファイル; アナライザー; Compilación transicional</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

キーポイント：\*\*

- El SDK usa "PrivateAssets" para evitar el empaquetado en la salida
- Las bibliotecas de terceros (YamlDotNet) se empaquetan automáticamente en el directorio de salida del mod

## 4. Adición de un paquete NuGet

### Método 1：Uso de la CLI (recomendado)

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### Método 2：Editar manualmente el archivo .csproj

で '<ItemGroup>' .：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Método 3：Uso de Visual Studio

1. Haga clic con el botón derecho en el proyecto → administrar paquetes NuGet
2. Buscar "YamlDotNet"
3. 「インストール」をクリックします

## 5) Ejemplos de implementación

### リソースファイル

['activo/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  title: "Buena configuración de YAML"
  description: "これは、MOD の assets フォルダーから YAML をロードするデモンストレーションです"
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Use ducky.Sdk.Logging.
Ducky.Sdk.ModComportamientos.
YamlDotNet.Serialization.
Use YamlDotNet.Serialization.NamingConventions.

espacio de nombres Ducky.PackageFromNuget;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    anulación protegida void ModEnabled()
    {
        Obtener el directorio donde se encuentra el ensamblado mod
        var dir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
        var ymlPath = Path.Combine(ディレクトリ, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Encontrado nice.yml:");
            
            Uso de YamlDotNet para deserializar archivos YAML
            var deserializer = new DeserializerBuilder()
                . Convenciones de nomenclatura (convenciones de nomenclatura de mayúsculas y minúsculas de camello.
                . ビルド();

            var ymlContent = Archivo.LeerTodoTexto(ymlPath);
            var niceData = デシリアライザー。 Deserialización<NiceData>(ymlコンテンツ);
            
            Log.Info($"タイトル: {niceData.NiceHeader.Title}");
            Log.Info($" Descripción: {niceData.NiceHeader.Description}");
        }
        Si no
        {
            Log.Warn("¡nice.yml no encontrado!");
        }
    }

    anulación protegida void ModDisabled()
    {
        Limpiar recursos (si es necesario)
    }
}

データモデルクラス
public クラス NiceData
{
    public NiceDateHeader NiceHeader { get; セット; } = nuevo();

    パブリック・クラス NiceDateHeader
    {
        public string Title { get; セット; } = cadena. Vacío;
        cadena pública explicada { get; } セット; } = cadena. Vacío;
    }
}
```

## 6. リソースファイルへのアクセス

### Obtén el catálogo de mods

```csharp
Método 1：Por lugar de montaje (recomendado)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
```

### リソースファイルにアクセスする

```csharp
El directorio assets/ se copia en el directorio raíz del directorio de salida del Mod
var configPath = Ruta.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK Automático：**

- ✅ サード パーティの NuGet パッケージの DLL をコピーする
- ✅ Copie el archivo de recursos en el directorio de salida
- ✅ ゲーム mods ディレクトリにデプロイする

## 7. Habilitar mods

Una vez que la compilación sea exitosa, habilite el mod en la interfaz de administración de mods del juego：

1. Inicia el juego
2. Ir a la interfaz de administración de mods
3. Busque "Ducky.PackageFromNuget".
4. Haga clic en Habilitar
5. Si revisas los registros del juego, verás el contenido del YAML analizado

## 8) ベストプラクティス

### ✅ Elige la biblioteca adecuada

- Priorice las bibliotecas compatibles con .NET Standard 2.0/2.1
- Evite el uso de bibliotecas específicas de la plataforma
- Compruebe si el árbol de dependencias de la biblioteca es complejo

### ✅ Gestión de versiones dependientes

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Caso relacionado

- [ダッキー・シングルプロジェクト] (../Ducky.SingleProject/README.md) - estructura básica del proyecto
- [ダッキー・エントランス・モッド] (.. /Ducky.EntranceMod/README.md: arquitectura de varios niveles (si necesita compartir bibliotecas de terceros)
- [環境準備ドキュメント](../docs/Prequirement.md)

## 10. プロット

Al usar un paquete NuGet de terceros,：

- ✅ Amplíe rápidamente la funcionalidad de mod
- ✅ Evita reinventar la rueda
- ✅ Utilice soluciones probadas y estables
- ✅ Aprovechar los recursos de la comunidad

**Nota：**

- ⚠️ Asegúrese de que la biblioteca es compatible con .NET Standard 2.1
- ⚠️ Tenga en cuenta el tamaño de las dependencias y su impacto en el rendimiento
- ⚠️ Manejar los conflictos de versiones de manera adecuada
- ⚠️ Cumplir con las licencias de biblioteca de terceros
