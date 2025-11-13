<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../docs/Prequirement.md) | [Português] (../../en/docs/Prequirement_en.md) | [Alemão] (../../de/docs/Prequirement_de.md) | [Français] (../../fr/docs/Prequirement_fr.md) | [Español] (../../es-ES/docs/Prequirement_es.md) | [Japonês] (../../ja/docs/Prequirement_ja.md) | [한국어] (../../ko/docs/Prequirement_ko.md) | [Português] (../../pt-PT/docs/Prequirement_pt.md) | [Русский] (../../ru/docs/Prequirement_ru.md) | [Chinês tradicional] (Prequirement_zh.md) |

<!-- LANG_HEADER_END -->

# Preparação do Ambiente de Desenvolvimento (Projeto .NET / Ducky.Sdk)

Este documento descreve os requisitos mínimos e as configurações recomendadas necessárias para configurar um ambiente de desenvolvimento .NET para este repositório.

## Visão geral

- SDK do .NET de destino：.NET 10(SDK 10.x)
- Ferramentas globais necessárias：
  - Usado para executar dinamicamente documentos em C#：'dotnet-script'
  - Usado para coleções de programas e/ou embalagens：'dotnet-ilrepack'

## Requisitos do sistema

- Sistemas operativos suportados：Linux / macOS / Windows (use o gerenciamento de pacotes de distribuição ou o script de instalação oficial para instalar o SDK do .NET)
- Espaço em disco e memória recomendados：Pelo menos 2 GB de disco livre e 4 GB de memória

## Instalar o .NET SDK 10

Instale o SDK do .NET 10 usando o método de instalação oficial ou o gerenciador de pacotes, exemplo：

```bash
# Linux (usando scripts da Microsoft)
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x dotnet-install.sh
./dotnet-install.sh --canal 10.0
```

```bash
# macOS (exemplo Homebrew)
brew install --cask dotnet-sdk # Em seguida, verifique as versões disponíveis via brew info ou use o script dotnet-install
```

```bash
# Windows (PowerShell)
iwr https://dot.net/v1/dotnet-install.ps1 -OutFile dotnet-install.ps1
.\dotnet-install.ps1 -Canal 10.0
```

Após a instalação, adicione o caminho do SDK ao PATH ou execute-o com o caminho completo no terminal.Verifique a instalação：

```bash
dotnet --info
```

A saída deve incluir uma versão do SDK que comece com "10.", como 10.0.x.

## Ferramentas globais (obrigatório)

- Execute dinamicamente scripts C# (REPL/Documented Build/Widgets)

```bash
dotnet tool install -g dotnet-script
```

- Coleção e/ou pacote de programas (usado para gerar um único assembly ou mesclar dependências de terceiros)

```bash
dotnet ferramenta instalar -g dotnet-ilrepack
```

Quando a instalação estiver concluída, confirme se a ferramenta está disponível：

```bash
dotnet-script --versão
ilrepack /?
```
