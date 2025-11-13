<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](../en/Ducky.EntranceMod/README_en.md) | [Deutsch](../de/Ducky.EntranceMod/README_de.md) | [Français](../fr/Ducky.EntranceMod/README_fr.md) | [Español](../es-ES/Ducky.EntranceMod/README_es.md) | [日本語](../ja/Ducky.EntranceMod/README_ja.md) | [한국어](../ko/Ducky.EntranceMod/README_ko.md) | [Português](../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский](../ru/Ducky.EntranceMod/README_ru.md) | [繁體中文](../zh-TW/Ducky.EntranceMod/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod de muestra

Breve descripción

En este ejemplo se muestra cómo desarrollar mods mediante un patrón de arquitectura multicapa para separar el código compartido en proyectos de biblioteca independientes para la reutilización del código y el diseño modular.Adecuado para mods grandes o escenarios en los que el código debe compartirse entre varios mods.

Antes de comenzar, asegúrese de que los requisitos del entorno de preproducción estén preparados: [Preparación del entorno](../docs/Prequirement.md)

## 1. Introducción del proyecto

Este ejemplo consta de dos elementos：

- **Proyecto de mod principal** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Entrada de mod que contiene archivos de recursos
- **Proyecto de Biblioteca Pública** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Base de código compartida

Este patrón arquitectónico se aplica：

- Los mods grandes requieren una gestión jerárquica
- Múltiples mods comparten lógica común
- Desarrollo colaborativo en equipo
- La lógica empresarial debe probarse de forma independiente

## 2. Estructura del proyecto

```
Ducky.EntranceMod/ # Proyecto Mod Principal
├── Ducky.EntranceMod.csproj # Configuración del proyecto
├── ModBehaviour.cs # Clase de entrada Mod
├── README.md
└── assets/ # Directorio de archivos de recursos
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Locales/
        ├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/ # Proyecto de biblioteca pública
├── Ducky.EntranceMod.Common.csproj # Configuración del proyecto de biblioteca
├── LK.cs # Compartir clave de localización
└── MyModBase.cs # Clase base compartida
```

## 3. Configuración del proyecto de mod principal

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1)：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>verdadero</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>todo</PrivateAssets>
      <IncludeAssets>Ejecución; construir; nativo; archivos de contenido; Analizadores; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**Descripción de la configuración del núcleo：**

- \`<ExcludeSdkLib>verdadero</ExcludeSdkLib>- Evite el empaquetado duplicado de las bibliotecas del SDK en el directorio de salida

## 4. Configuración del proyecto de biblioteca pública

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1)：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>verdadero</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/assets</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>todo</PrivateAssets>
      <IncludeAssets>Ejecución; construir; nativo; archivos de contenido; Analizadores; buildtransitive</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**Descripción de la configuración del núcleo：**

- \`<IsModLib>verdadero</IsModLib>' - Marque este elemento como una biblioteca de mods, el SDK lo manejará especialmente
- \`<AssetsDir>' - Apunta al directorio de activos del proyecto principal para que la clave de localización se genere correctamente

## 5. Comparte ejemplos de código

### Compartir claves de localización

['Ducky.EntranceMod.Common/LK.cs'] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
espacio de nombres Ducky.EntranceMod.Common;

clase estática pública LK
{
    Interfaz de usuario de clase estática pública
    {
        public const string NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### Clases base compartidas

['Ducky.EntranceMod.Common/MyModBase.cs'] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
usando Ducky.Sdk.ModBehaviours;

espacio de nombres Ducky.EntranceMod.Common;

public abstract class MyModBase : ModBehaviourBase
{
    Se puede agregar un método universal para compartir todos los mods aquí
    void virtual protegido LogModInfo(string message)
    {
        Log.Info($"[{GetType(). Nombre}] {message}");
    }
}
```

### El mod principal usa un código compartido

['Ducky.EntranceMod/ModBehaviour.cs'] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
usando Ducky.Sdk.Logging;
usando Ducky.EntranceMod.Common;

espacio de nombres Ducky.EntranceMod;

Clase base compartida de herencia
clase pública ModBehaviour : MyModBase
{
    anulación protegida void ModEnabled()
    {
        Log.Info("Mod habilitado");
        Uso de una clave de localización compartida
        var mensaje = LK. UI. Buen mensaje de bienvenida;
        LogModInfo($"Tecla del mensaje de bienvenida: {message}");
    }

    anulación protegida void ModDisabled()
    {
        Log.Info("Mod desactivado");
    }
}
```

## 6. Ventajas de la arquitectura multicapa

### ✅ Reutilización de código

- Varios mods pueden compartir la biblioteca 'Ducky.EntranceMod.Common'
- Evite la duplicación de código y mejore la capacidad de mantenimiento

### ✅ Diseño modular

- La lógica de negocio se desacopla de la entrada del mod
- Prueba unitaria fácil de usar
- Borrar dependencias

### ✅ Colaboración en equipo

- Diferentes desarrolladores pueden desarrollar diferentes capas de forma independiente
- Reducir los conflictos de código
- Fácil revisión de código

### ✅ Uso compartido localizado

- Las bibliotecas públicas pueden definir claves de localización compartidas
- Todos los mods que usan la biblioteca son compatibles automáticamente para la traducción

## 7. Construye el proceso

El SDK controla automáticamente las dependencias de varios proyectos：

```bash
# Construir la solución completa (recomendado)
dotnet build Docky.Sdk.Sample.slnx

# o compilar el proyecto principal por separado (que compila automáticamente el proyecto de biblioteca dependiente)
dotnet build Ducky.EntranceMod/
```

Construir productos：\*\*

- El ensamblado de mod principal + el ensamblado de biblioteca pública se empaquetan juntos
- El archivo de recursos se obtiene del directorio 'assets/' del proyecto principal
- Las bibliotecas del SDK no se incluyen repetidamente (porque '<ExcludeSdkLib>verdadero</ExcludeSdkLib>\`）

## 8. Habilitar mods

Una vez construidos, los mods se implementan automáticamente en el catálogo de juegos：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── activos/
    ├── info.ini
    ├── lkeys.json
    └── Locales/</游戏目录>
```

Habilita el mod en la interfaz de administración de mods del juego.

## 9. Recomendaciones de extensión

### Crear más bibliotecas públicas

Para proyectos complejos, puede crear varias bibliotecas públicas：

```
Ducky.EntranceMod/ # Mod maestro
Ducky.EntranceMod.Common/ # Código universal
Ducky.EntranceMod.Gameplay/ # Lógica de juego
Ducky.EntranceMod.UI/ # Relacionado con la interfaz de usuario
```

## 10. Preguntas Frecuentes

### P: ¿Por qué establecer '<ExcludeSdkLib>verdadero</ExcludeSdkLib>\`？

R: Evite el empaquetado duplicado de los archivos de biblioteca de Ducky.Sdk en el directorio de salida del mod.La biblioteca SDK ya existe en el juego y no es necesario volver a incluirla.

### Q: \`<AssetsDir>¿Tienes que configurarlo?

R: Para proyectos de bibliotecas públicas, si incluye una clave de localización (LK.cs), debe establecer '<AssetsDir>Apunta al directorio de recursos del proyecto principal para que el SDK pueda generar correctamente metadatos localizados.

### P: ¿Pueden varios proyectos de mods principales compartir la misma biblioteca pública?

R: ¡Sí!Esta es la ventaja de las arquitecturas de varios niveles.Varios mods pueden hacer referencia al mismo proyecto de biblioteca pública.

### P: ¿Dónde se generará la clave de localización para las bibliotecas públicas?

R: Generará '<AssetsDir>' especificado, es decir, el archivo 'lkeys.json' en el directorio 'assets/' del proyecto principal.

## 11. Recursos relacionados

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Referencia del modo de un solo elemento
- [Ducky.Localización] (../Ducky.Localization/README.md- Explicación detallada del sistema de localización
- [Documentación de preparación del entorno] (../docs/Prequirement.md)

## 12. Resumen

El patrón de arquitectura multicapa es adecuado：

- ✅ Grandes proyectos de mods
- ✅ Escenarios en los que se requiere la reutilización de código
- ✅ Desarrollo colaborativo en equipo
- ✅ Desarrollo de mods en serie

Si su mod es relativamente simple, se recomienda comenzar con [Ducky.SingleProject](../Ducky.SingleProject/README.md) de un solo proyecto.
