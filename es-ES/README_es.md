<!-- LANG_HEADER_START -->

\| [Chino simplificado] (README.md) |

<!-- LANG_HEADER_END -->

# Colección de proyectos de ejemplo del SDK de Ducky

[! [Construir] (https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.NET] (https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [NuGet] (https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [Licencia] (https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [Plataforma] (https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [Idioma] (https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! [Objetivo] (https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [Problemas] (https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [Solicitudes de incorporación de cambios] (https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [Último compromiso] (https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

Este repositorio contiene varios proyectos de muestra para demostrar el desarrollo del mod "Escape from Duckov", usando [Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk).

## 📋 Preparado

Antes de comenzar, asegúrese de que su entorno de desarrollo esté listo：

👉 [Ver documentación de preparación del entorno](docs/Prequirement.md)\*\*

Requisitos principales:：

- SDK de .NET 10.x
- Herramienta global：'dotnet-script'、'dotnet-ilrepack'
- Sistemas operativos compatibles：Windows / Linux / macOS

## 🎯 Comience rápidamente

```bash
# Clonar el repositorio
clonar git <repository-url>
Muestras de cd

# Construir todos los ejemplos
dotnet build Docky.Sdk.Sample.slnx

# o construir un solo ejemplo
dotnet build Ducky.SingleProject/
```

## 📚 Ejemplo de recorrido por el proyecto

Este repositorio organiza los ejemplos en orden de fácil a difícil, y se recomienda estudiar en el siguiente orden：

### 1️⃣ Nivel de entrada: conceptos básicos

#### [Ducky.SingleProject] (Ducky.SingleProject/- El mod más simple

**dificultad：⭐**

El ejemplo de mod de un solo elemento más básico, adecuado para principiantes completos.

- ✅ Estructura de un solo artículo
- ✅ Ciclo de vida del mod ('ModEnabled' / 'ModDisabled')
- ✅ Registro básico
- ✅ Configuración y construcción del proyecto

Puntos clave para aprender：\*\*

- Cómo crear un mod mínimo viable
- ['ModBehaviour'] (Ducky.SingleProject/ModBehaviour.cs)
- La configuración básica del archivo '.csproj'

**Apto para personas：** Desarrolladores nuevos en el SDK de Ducky

👉 [Ver tutorial detallado](Ducky.SingleProject/README.md)

---

#### [Ducky.Muerte instantánea] (Ducky.InstantKill/- Manejo de eventos de juego

**dificultad：⭐⭐**

Muestra cómo suscribirse a eventos de juego e implementar modificaciones sencillas de lógica de juego.

- ✅ Suscripción a eventos de juego ('Health.OnHurt')
- ✅ Implementación del controlador de eventos
- ✅ Gestión de recursos a lo largo del ciclo de vida

Puntos clave para aprender：\*\*

- Cómo escuchar eventos en el juego
- Cómo suscribirse y darse de baja de eventos de forma segura
- ['Información de daños'] (Ducky.InstantKill/ModBehaviour.cs) y otras API de juegos

**Apto para personas：** Desarrolladores que entienden la estructura básica del mod y quieren implementar la lógica del juego

👉 [Ver tutorial detallado](Ducky.InstantKill/README.md)

---

### 2️⃣ Nivel avanzado - Características principales

#### [Ducky.Localización] (Ducky.Localization/- Localización multilingüe

**dificultad：⭐⭐⭐**

Un ejemplo completo de un sistema de localización con soporte multilingüe y traducción basada en archivos.

- ✅ Definición de clave localizada(['LK.cs'](Ducky.Localization/LK.cs)）
- ✅ Archivo de traducción CSV
- ✅ Traducción de documentos (Markdown)
- ✅ Soporte multilingüe (chino simplificado e inglés)

Puntos clave para aprender：\*\*

- Cómo organizar las claves de localización
- Uso de las funciones '[LanguageSupport]' y '[TranslateFile]'
- SDK generado automáticamente 'lkeys.json' y 'keys.hash.txt'
- Acceso en tiempo de ejecución a cadenas de traducción

**Apto para personas：** Desarrolladores que necesitan desarrollar mods multilingües

👉 [Ver tutorial detallado](Ducky.Localization/README.md)

---

#### [Ducky.BuffRegistration] (Ducky.BuffRegistration/) - Entidades de juego personalizadas

\*\*dificultad：⭐⭐⭐

Demuestra cómo registrar mejoras personalizadas e integrarlas con tu sistema de juego.

- ✅ Usa 'Contract.Buffs.RegisterBuff' para registrar el buff
- ✅ Control de eventos de escena ('SceneLoader.onAfterSceneInitialize')
- ✅ Creación y adición de instancias de buff
- ✅ Localiza el nombre y la descripción del buff

Puntos clave para aprender：\*\*

- Cómo extender el sistema central del juego
- Patrones de uso de la API de contrato
- Gestión del ciclo de vida de los escenarios
- Configuración y registro de entidades de juego

**Apto para personas：** Desarrolladores que quieran añadir contenido de juego personalizado

👉 [Ver tutorial detallado](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/- Gestión de dependencias de terceros

**dificultad：⭐⭐⭐**

Muestra cómo usar paquetes NuGet en mods (usando YamlDotNet como ejemplo).

- ✅ Introducción a paquetes NuGet de terceros
- ✅ Leer y analizar archivos de recursos
- ✅ Empaquetado e implementación dependientes

Puntos clave para aprender：\*\*

- Cómo usar bibliotecas externas en mods
- La ruta de acceso del archivo de recursos
- Mecanismo de manejo de dependencias del SDK

**Apto para personas：** Desarrolladores que necesitan ampliar la funcionalidad con bibliotecas de terceros

---

### 3️⃣ Avanzado - Modo complejo

#### [Ducky.EntranceMod] (Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/- Arquitectura de varios niveles

**dificultad：⭐⭐⭐⭐**

Muestra cómo dividir mods en arquitecturas multicapa para la reutilización de código.

- ✅ El proyecto principal de mods está separado de la biblioteca pública
- ✅ \`<ExcludeSdkLib>' y '<IsModLib>'
- ✅ Compartir claves de localización entre proyectos
- ✅ Gestión de referencias de proyectos

Puntos clave para aprender：\*\*

- Organización de soluciones multiproyecto
- Cómo crear una biblioteca de mods reutilizable
- Uso compartido entre proyectos de archivos de recursos
- Diseño de arquitectura para grandes mods

**Apto para personas：** Equipos que desarrollan mods grandes o en serie

---

#### [Ducky.TryHarmony] (Ducky.TryHarmony/- Inyección de código en tiempo de ejecución

**dificultad：⭐⭐⭐⭐⭐**

Use HarmonyLib para parchear el código del juego en tiempo de ejecución para las modificaciones más profundas del juego.

- ✅ Sistema de parcheo Harmony
- ✅ método prefijo/sufijo/reemplazo
- ✅ Registro y limpieza de parches
- ✅ Acceso a la API en el juego

Puntos clave para aprender：\*\*

- Uso básico de HarmonyLib
- Cómo escribir parches de prefijo/sufijo
- Prácticas recomendadas para la modificación del código en tiempo de ejecución
- Gestión del ciclo de vida de los parches

**ejemplo：** ['SaveFilePatch'](Ducky.TryHarmony/SaveFilePatch.csMuestra cómo interceptar operaciones de archivo

**Apto para personas：** Desarrolladores avanzados que necesitan modificar profundamente la lógica del juego

⚠️ **Nota.：** Los parches de Harmony son potentes, pero deben usarse con precaución, y los parches incorrectos pueden hacer que el juego se bloquee

👉 [Ver tutorial detallado](Ducky.TryHarmony/README.md)

---

## 🏗️ Arquitectura del proyecto

Todos los proyectos de muestra siguen las siguientes convenciones básicas：

### Configuración del proyecto (obligatorio)

```xml
<PropertyGroup>
  <TargetFramework>estándar de red2.1</TargetFramework>
  <Nullable>habilitar</Nullable>
  <LangVersion>Vista previa</LangVersion>
  <ImplicitUsings>verdadero</ImplicitUsings>
  <ModName>YourModName</ModName>
</PropertyGroup>
```

### Punto de entrada del mod

```csharp
ModBehaviour de clase pública : ModBehaviourBase
{
    anulación protegida void ModEnabled()
    {
        Lógica de inicialización cuando el mod está habilitado
    }

    anulación protegida void ModDisabled()
    {
        Lógica de limpieza cuando el mod está desactivado
    }
}
```

### Estructura del archivo de recursos

```
activo/
├── info.ini # Meta información del mod
├── description.md # Descripción detallada (opcional)
├── preview.png # Vista previa (opcional)
├── lkeys.json # Lista de verificación de localización (generada automáticamente)
├── keys.hash.txt # Hash de validación (generado automáticamente)
└── Locales/
    ├── zh.csv # Traducción al chino simplificado
    ├── en.csv # Traducción al inglés
    └── es/ # Traducción basada en documentos
        └── *.md
```

## 📖 Recomendaciones de rutas de aprendizaje

### Camino para principiantes

1. [Ducky.SingleProject] (Ducky.SingleProject/- Comprender la infraestructura
2. [Ducky.Muerte instantánea] (Ducky.InstantKill/- Aprender a manejar incidentes
3. [Ducky.Localización] (Ducky.Localization/- Localización maestra
4. [Ducky.BuffRegistration] (Ducky.BuffRegistration/) - Expande el contenido del juego

### Ruta avanzada

1. [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/) - Usar bibliotecas de terceros
2. [Ducky.EntranceMod] (Ducky.EntranceMod/- Diseño de arquitectura multicapa
3. [Ducky.TryHarmony] (Ducky.TryHarmony/- Inyección de código en tiempo de ejecución

## 🛠️ Compilación e implementación

### Comandos de compilación

```bash
# Construir todos los proyectos
dotnet build Docky.Sdk.Sample.slnx

# Construir un solo proyecto
dotnet build Ducky.SingleProject/

# Limpiar la compilación
dotnet limpio
```

### Implementación automatizada

El SDK implementa automáticamente mods en el directorio del juego en el momento de la compilación (requiere configurar 'local.props' o establecer '.csproj')<SteamFolder>`/`<DuckovFolder>\`）：

```xml
<PropertyGroup>
  <SteamFolder>C: \ Archivos de programa (x86) \ Steam \ steamapps \ common \ Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 Especificaciones del proyecto

- **Formato de solución**：Utilice el nuevo formato XML '.slnx'
- **Análisis de código**：El analizador integrado del SDK valida la estructura del proyecto
- **Generación automática**：Los metadatos localizados se generan automáticamente en tiempo de compilación

## 🔗 Recursos relacionados

- [Paquete NuGet de Ducky.Sdk] (https://www.nuget.org/packages/Ducky.Sdk)
- [Página de Steam del juego] (https://store.steampowered.com/app/XXXXX(reemplazado por enlace real)
- [Documentación para desarrolladores] (docs/)

## 🤝 Pautas de contribución

¡No dude en enviar problemas y solicitudes de extracción para mejorar el proyecto de muestra!

## 📄 Permitir.

Este proyecto utiliza [LICENSE(LICENCIA).

---

**¡Feliz desarrollo!🎮**
