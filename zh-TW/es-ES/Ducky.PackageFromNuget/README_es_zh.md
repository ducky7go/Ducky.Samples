<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.PackageFromNuget/README.md) | [English](../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch](../../de/Ducky.PackageFromNuget/README_de.md) | [Français](../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español](README_es.md) | [日本語](../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português](../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский](../../ru/Ducky.PackageFromNuget/README_ru.md) | [繁體中文](../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra Ducky.PackageFromNuget

Breve descripción

En este ejemplo se muestra cómo usar paquetes NuGet de terceros en mods, usando YamlDotNet como ejemplo, incluida la administración de dependencias, el acceso a archivos de recursos y la implementación de paquetes de dependencias.

Antes de comenzar, asegúrese de que los requisitos del entorno de preproducción estén preparados: [Preparación del entorno](../docs/Prequirement.md)

## 1. Introducción del proyecto

Este directorio (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) demuestra cómo ampliar la funcionalidad de los mods：

- ✅ Introducción a paquetes NuGet de terceros
- ✅ Análisis de datos mediante bibliotecas externas (YAML)
- ✅ Acceder al archivo de recursos de Mod
- ✅ Controlar automáticamente el empaquetado de dependencias

**Escenario de ejemplo：** Use la biblioteca YamlDotNet para leer y analizar el archivo de configuración de YAML en la carpeta Mod Resources.

## 2. Estructura del proyecto

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Configuración del proyecto
├── ModBehaviour.cs # Clase de entrada Mod
├── README.md
└── activos/
    ├── info.ini # Meta información del mod
    ├── preview.png # Vista previa de la imagen
    └── nice.yml # Archivo YAML de muestra
```

## 3. Configuración del proyecto

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>todo</PrivateAssets>
      <IncludeAssets>Ejecución; construir; nativo; archivos de contenido; Analizadores; buildtransitive</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

Puntos clave：\*\*

- El SDK usa "PrivateAssets" para evitar el empaquetado en la salida
- Las bibliotecas de terceros (YamlDotNet) se empaquetan automáticamente en el directorio de salida del mod

## 4. Agregar el paquete NuGet

### Método 1：Uso de CLI (recomendado)

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### Método 2：Editar manualmente .csproj

En '<ItemGroup>' añadido：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Método 3：Uso de Visual Studio

1. Haga clic con el botón derecho en el proyecto → administrar paquetes NuGet
2. Buscar "YamlDotNet"
3. Haga clic en "Instalar"

## 5) Ejemplos de implementación

### Archivo de recursos

['activos/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  title: "Buena configuración de YAML"
  description: "Esta es una demostración de la carga de YAML desde la carpeta de activos de un mod"
```

### Clase de entrada Mod

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
usando Ducky.Sdk.Logging;
usando Ducky.Sdk.ModBehaviours;
usando YamlDotNet.Serialization;
usando YamlDotNet.Serialization.NamingConventions;

espacio de nombres Ducky.PackageFromNuget;

ModBehaviour de clase pública : ModBehaviourBase
{
    anulación protegida void ModEnabled()
    {
        Obtener el directorio donde se encuentra el ensamblado de mods
        var dir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
        var ymlPath = Path.Combine(dir, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Encontrado nice.yml:");
            
            Uso de YamlDotNet para deserializar archivos YAML
            var deserializer = new DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . Construir();

            var ymlContent = Archivo.LeerTodoTexto(ymlPath);
            var niceData = deserializador. Deserializar<NiceData>(ymlContent);
            
            Log.Info($"Título: {niceData.NiceHeader.Title}");
            Log.Info($"Descripción: {niceData.NiceHeader.Description}");
        }
        más
        {
            Log.Warn("¡nice.yml no encontrado!");
        }
    }

    anulación protegida void ModDisabled()
    {
        Limpiar recursos (si es necesario)
    }
}

Clase de modelo de datos
clase pública NiceData
{
    public NiceDateHeader NiceHeader { get; poner; } = nuevo();

    clase pública NiceDateHeader
    {
        public string Title { get; poner; } = cadena. Vacío;
        public string Descripción { get; poner; } = cadena. Vacío;
    }
}
```

## 6. Acceso a archivos de recursos

### Obtén el catálogo de mods

```csharp
Método 1：Por lugar de montaje (recomendado)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
```

### Acceso al archivo de recursos

```csharp
assets/ se copiará en el directorio raíz del directorio de salida del Mod
var configPath = Ruta.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK automáticamente：**

- ✅ Copia del archivo DLL de un paquete NuGet de terceros
- ✅ Copie el archivo de recursos en el directorio de salida
- ✅ Implementar en el directorio de mods del juego

## 7. Habilitar mods

Una vez que la compilación sea exitosa, habilite el mod en la interfaz de administración de mods del juego：

1. Inicia el juego
2. Ir a la interfaz de gestión de mods
3. Busque "Ducky.PackageFromNuget"
4. Haga clic en Habilitar
5. Comprueba los registros del juego y deberías ver el contenido de YAML analizado

## 8) Mejores prácticas

### ✅ Elige la biblioteca adecuada

- Prefiera bibliotecas compatibles con .NET Standard 2.0/2.1
- Evite el uso de bibliotecas específicas de la plataforma
- Compruebe si el árbol de dependencias de la biblioteca es complejo

### ✅ Administrar versiones dependientes

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Ejemplos relevantes

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Estructura básica del proyecto
- [Ducky.EntranceMod] (../Ducky.EntranceMod/README.md- Arquitectura de varios niveles (si necesita compartir bibliotecas de terceros)
- [Documentación de preparación del entorno] (../docs/Prequirement.md)

## 10. Resumen

El uso de un paquete NuGet de terceros puede：

- ✅ Amplíe rápidamente las funciones de modificación
- ✅ Evita reinventar la rueda
- ✅ Utilice una solución probada y estable
- ✅ Aproveche los recursos de la comunidad

**Notas：**

- ⚠️ Asegúrese de que la biblioteca es compatible con .NET Standard 2.1
- ⚠️ Tenga en cuenta el tamaño de la dependencia y el impacto en el rendimiento
- ⚠️ Manejar bien los conflictos de versiones
- ⚠️ Cumplir con la licencia de la biblioteca de terceros
