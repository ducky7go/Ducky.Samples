<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../docs/Prequirement.md) | [영어] (../../en/docs/Prequirement_en.md) | [도이치] (../../de/docs/Prequirement_de.md) | [프랑세] (../../fr/docs/Prequirement_fr.md) | [스페인어] (Prequirement_es.md) | [일본어] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [포르투갈어] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [중국어 번체자] (../../zh-TW/docs/Prequirement_zh.md) |

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
./dotnet-install.sh --운하 10.0
```

```bash
# macOS (ejemplo de Homebrew)
brew install --cask dotnet-sdk # A continuación, compruebe las versiones disponibles a través de brew info o use el script dotnet-install
```

```bash
# 윈도우(PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -운하 10.0
```

Después de la instalación, agregue la ruta del SDK a la ruta de acceso o ejecútelo con la ruta de acceso completa en el terminal. Verifique la instalación：

```bash
dotnet --정보
```

La salida debe contener la versión del SDK que comienza con "10." , por ejemplo, 10.0.x.

## Herramientas globales (의무)

- Ejecutar dinámicamente scripts de C# (REPL/compilaciones con scripts/widgets)

```bash
dotnet tool install -g dotnet-script
```

- Colecciones de programas y/paquetes (para generar un único ensamblado o combinar dependencias de terceros)

```bash
dotnet 도구 설치 -g dotnet-ilrepack
```

Una vez completada la instalación, confirme que la herramienta está disponible：

```bash
dotnet-script --버전
ilrepack /?
```
