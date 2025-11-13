<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../docs/Prequirement.md) | [Inglés] (../../en/docs/Prequirement_en.md) | [Deutsch] (../../de/docs/Prequirement_de.md) | [Français] (../../fr/docs/Prequirement_fr.md) | [English] (Prequirement_es.md) | [Japonés] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [Português] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [Chino tradicional] (../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Preparación del entorno de desarrollo (proyecto .NET / Ducky.Sdk)

En este documento se describen los requisitos mínimos y las configuraciones recomendadas necesarias para configurar un entorno de desarrollo de .NET para este repositorio.

## Visión general

- SDK de .NET de destino：.NET 10(SDK 10.x)
- Herramientas globales necesarias：
  - Se usa para ejecutar dinámicamente scripts de C #：'dotnet-script'
  - Se utiliza para colecciones de programas y/o empaquetado：'dotnet-ilrepack'

## Requisitos del sistema:

- Sistemas operativos compatibles：Linux / macOS / Windows (instale el SDK de .NET mediante la administración de paquetes de distribución o el script de instalación oficial)
- Se recomienda espacio en disco y memoria：Al menos 2 GB de disco libre y 4 GB de memoria

## Instalación del SDK de .NET 10

Instalación del SDK de .NET 10 mediante el método de instalación oficial o el administrador de paquetes, ejemplo：

```bash
# Linux (usando scripts de Microsoft)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --canal 10.0
```

```bash
# macOS (ejemplo de Homebrew)
brew install --cask dotnet-sdk # A continuación, compruebe las versiones disponibles a través de brew info o use el script dotnet-install
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Canal 10.0
```

Después de la instalación, agregue la ruta del SDK a la ruta de acceso o ejecútelo con la ruta de acceso completa en el terminal. Verifique la instalación：

```bash
dotnet --info
```

La salida debe contener la versión del SDK que comienza con "10." , por ejemplo, 10.0.x.

## Herramientas globales (obligatorio)

- Ejecutar dinámicamente scripts de C# (REPL/compilaciones con scripts/widgets)

```bash
dotnet tool install -g dotnet-script
```

- Colecciones de programas y/paquetes (para generar un único ensamblado o combinar dependencias de terceros)

```bash
dotnet tool install -g dotnet-ilrepack
```

Una vez completada la instalación, confirme que la herramienta está disponible：

```bash
dotnet-script --version
ilrepack /?
```
