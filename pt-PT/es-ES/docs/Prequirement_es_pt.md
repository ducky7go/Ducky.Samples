<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../docs/Prequirement.md) | [Português] (../../en/docs/Prequirement_en.md) | [Alemão] (../../de/docs/Prequirement_de.md) | [Français] (../../fr/docs/Prequirement_fr.md) | [Español] (Prequirement_es.md) | [Japonês] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [Português] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [Chinês tradicional] (../../zh-TW/docs/Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Preparación del entorno de desarrollo (proyecto .NET / Ducky.Sdk)

En este documento se describen los requisitos mínimos y las configuraciones recomendadas necesarias para configurar un entorno de desarrollo de .NET para este repositório.

## Visibilidade geral

- SDK de .NET de destino：.NET 10(SDK 10.x)
- Herramientas globales necesarias：
  - Se usa para ejecutar dinámicamente scripts de C #：'dotnet-script'
  - Se utiliza para coleciones de programas y/o empaquetado：'dotnet-ilrepack'

## Requisitos del sistema:

- Sistemas operativos compatíveis：Linux / macOS / Windows (instale el SDK de .NET mediante la administración de paquetes de distribución o el script de instalación oficial)
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
# macOS (exemplo de Homebrew)
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

La salida debe contener la versión del SDK que comienza con "10." , por exemplo, 10.0.x.

## Herramientas globales (obrigatório)

- Ejecutar dinámicamente scripts de C# (REPL/compilaciones con scripts/widgets)

```bash
dotnet tool install -g dotnet-script
```

- Coleciones de programas y/paquetes (para generar un único ensamblado o combinar dependências de terceros)

```bash
dotnet ferramenta instalar -g dotnet-ilrepack
```

Una vez completada la instalación, confirme que la herramienta está disponible：

```bash
dotnet-script --versão
ilrepack /?
```
