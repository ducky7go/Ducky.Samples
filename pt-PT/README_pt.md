<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (README.md) | [Português] (en/README_en.md) | [Alemão] (de/README_de.md) | [Français] (fr/README_fr.md) | [Español] (es-ES/README_es.md) | [Japonês] (ja/README_ja.md) | [한국어] (ko/README_ko.md) | [Português] (pt-PT/README_pt.md) | [Русский] (ru/README_ru.md) | [Chinês tradicional] (zh-TW/README_zh.md) |

<!-- LANG_HEADER_END -->

# Coleção de projeto de exemplo do Ducky SDK

[! [Construir] (https://github.com/newbe36524/Samples/actions/workflows/build.yml/badge.svg)](https://github.com/newbe36524/Samples/actions/workflows/build.yml)
[! [.NET] (https://img.shields.io/badge/.NET-10.0-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[! [NuGet] (https://img.shields.io/nuget/v/Ducky.Sdk?logo=nuget&label=Ducky.Sdk)](https://www.nuget.org/packages/Ducky.Sdk)
[! [Licença] (https://img.shields.io/github/license/newbe36524/Samples?label=License)](LICENSE)
[! [Plataforma] (https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-blue)](#)
[! [Língua] (https://img.shields.io/badge/Language-C%23-239120?logo=csharp)](https://docs.microsoft.com/en-us/dotnet/csharp/)
[! [Público-alvo] (https://img.shields.io/badge/Target-.NET%20Standard%202.1-green)](#)
[! [Questões] (https://img.shields.io/github/issues/newbe36524/Samples)](https://github.com/newbe36524/Samples/issues)
[! [Pull Pedidos] (https://img.shields.io/github/issues-pr/newbe36524/Samples)](https://github.com/newbe36524/Samples/pulls)
[! [Última Comissão] (https://img.shields.io/github/last-commit/newbe36524/Samples)](https://github.com/newbe36524/Samples/commits)

Este repositório contém vários projetos de exemplo para demonstrar o desenvolvimento do mod "Escape from Duckov", usando [Ducky.Sdk](https://www.nuget.org/packages/Ducky.Sdk) quadro.

## 📋 Preparado

Antes de começar, certifique-se de que seu ambiente de desenvolvimento esteja pronto：

👉 [Ver documentação de preparação do ambiente](docs/Prequirement.md)\*\*

Principais requisitos:：

- SDK do .NET 10.x
- Ferramenta global：'dotnet-script'、'dotnet-ilrepack'
- Sistemas operativos suportados：Windows / Linux / macOS

## 🎯 Comece rapidamente

```bash
# Clone o repositório
clone git <repository-url>
Amostras de cd

# Crie todos os exemplos
dotnet construir Docky.Sdk.Sample.slnx

# ou crie um único exemplo
dotnet construir Ducky.SingleProject/
```

## 📚 Exemplo de tour do projeto

Este repositório organiza os exemplos em ordem de fácil a difícil, e recomenda-se estudar na seguinte ordem：

### 1️⃣ Nível de entrada - conceitos básicos

#### [Ducky.SingleProject] (Ducky.SingleProject/- O mod mais simples

**dificuldade：⭐**

O exemplo mais básico de mod de item único, adequado para novatos completos.

- ✅ Estrutura de item único
- ✅ Ciclo de vida do mod ('ModEnabled' / 'ModDisabled')
- ✅ Registo básico
- ✅ Configuração e construção do projeto

Pontos-chave a aprender：\*\*

- Como criar um mod mínimo viável
- ['ModBehaviour'] (Ducky.SingleProject/ModBehaviour.cs) Classe de ingresso
- A configuração básica do arquivo '.csproj'

**Adequado para pessoas：** Desenvolvedores novos no SDK do Ducky

👉 [Ver tutorial detalhado](Ducky.SingleProject/README.md)

---

#### [Ducky.InstantKill] (Ducky.InstantKill/- Manipulação de eventos de jogos

**dificuldade：⭐⭐**

Demonstra como subscrever eventos de jogo e implementar modificações simples na lógica do jogo.

- ✅ Subscrição de Eventos de Jogo ('Health.OnHurt')
- ✅ Implementação do manipulador de eventos
- ✅ Gestão de recursos ao longo do ciclo de vida

Pontos-chave a aprender：\*\*

- Como ouvir os eventos do jogo
- Como subscrever e cancelar a subscrição de eventos de forma segura
- ['DamageInfo'] (Ducky.InstantKill/ModBehaviour.cs) e outras APIs de jogos

**Adequado para pessoas：** Desenvolvedores que entendem a estrutura básica do mod e querem implementar a lógica do jogo

👉 [Ver tutorial detalhado](Ducky.InstantKill/README.md)

---

### 2️⃣ Nível Avançado - Principais Características

#### [Ducky.Localização] (Ducky.Localization/- Localização multilingue

**dificuldade：⭐⭐⭐**

Um exemplo completo de um sistema de localização com suporte multilíngue e tradução baseada em arquivos.

- ✅ Definição de chave localizada(['LK.cs'](Ducky.Localization/LK.cs)）
- ✅ Arquivo de tradução CSV
- ✅ Tradução de documentos (Markdown)
- ✅ Suporte multilingue (chinês e inglês simplificados)

Pontos-chave a aprender：\*\*

- Como organizar chaves de localização
- Utilização das funcionalidades '[LanguageSupport]' e '[TranslateFile]'
- SDK gerado automaticamente 'lkeys.json' e 'keys.hash.txt'
- Acesso em tempo de execução a cadeias de caracteres de tradução

**Adequado para pessoas：** Desenvolvedores que precisam desenvolver mods multilíngues

👉 [Ver tutorial detalhado](Ducky.Localization/README.md)

---

#### [Ducky.BuffRegistro] (Ducky.BuffRegistration/) - Entidades de jogo personalizadas

\*\*dificuldade：⭐⭐⭐

Demonstra como registrar Buffs personalizados e integrá-los ao seu sistema de jogo.

- ✅ Use 'Contract.Buffs.RegisterBuff' para registrar o buff
- ✅ Tratamento de eventos de cena ('SceneLoader.onAfterSceneInitialize')
- ✅ Criação e adição de instâncias de buff
- ✅ Localize o nome e a descrição do Buff

Pontos-chave a aprender：\*\*

- Como estender o sistema principal do jogo
- Padrões de uso da API de contrato
- Gerenciamento do ciclo de vida do cenário
- Configuração e registo de entidades do jogo

**Adequado para pessoas：** Desenvolvedores que desejam adicionar conteúdo de jogo personalizado

👉 [Ver tutorial detalhado](Ducky.BuffRegistration/README.md)

---

#### [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/- Gestão de dependência de terceiros

**dificuldade：⭐⭐⭐**

Demonstra como usar pacotes NuGet em mods (usando YamlDotNet como exemplo).

- ✅ Apresentando pacotes NuGet de terceiros
- ✅ Ler e analisar arquivos de recursos
- ✅ Empacotamento e implantação dependentes

Pontos-chave a aprender：\*\*

- Como usar bibliotecas externas em mods
- O caminho de acesso do arquivo de recurso
- Mecanismo de manipulação de dependência do SDK

**Adequado para pessoas：** Desenvolvedores que precisam estender a funcionalidade com bibliotecas de terceiros

---

### 3️⃣ Avançado - Modo complexo

#### [Ducky.EntranceMod] (Ducky.EntranceMod/) + [Ducky.EntranceMod.Common](Ducky.EntranceMod.Common/- Arquitetura multicamadas

**dificuldade：⭐⭐⭐⭐**

Demonstra como dividir mods em arquiteturas multicamadas para reutilização de código.

- ✅ O projeto mod principal é separado da biblioteca pública
- ✅ \`<ExcludeSdkLib>' e '<IsModLib>' configuração
- ✅ Compartilhar chaves de localização entre projetos
- ✅ Gestão de referência de projetos

Pontos-chave a aprender：\*\*

- Organização de soluções multi-projeto
- Como criar uma biblioteca mod reutilizável
- Compartilhamento entre projetos de arquivos de recursos
- Projeto de arquitetura para grandes mods

**Adequado para pessoas：** Equipas a desenvolver mods grandes ou em série

---

#### [Ducky.TryHarmony] (Ducky.TryHarmony/- Injeção de código de tempo de execução

**dificuldade：⭐⭐⭐⭐⭐**

Use o HarmonyLib para corrigir o código do jogo em tempo de execução para as modificações mais profundas do jogo.

- ✅ Sistema de correção Harmony
- ✅ prefixo/sufixo/substituição do método
- ✅ Registro e limpeza de patches
- ✅ Acesso à API no jogo

Pontos-chave a aprender：\*\*

- Uso básico do HarmonyLib
- Como escrever patches de prefixo/Postfix
- Práticas recomendadas para modificação de código de tempo de execução
- Gerenciamento do ciclo de vida dos patches

**exemplo：** ['SaveFilePatch'](Ducky.TryHarmony/SaveFilePatch.csDemonstra como intercetar operações de arquivamento

**Adequado para pessoas：** Desenvolvedores avançados que precisam modificar profundamente a lógica do jogo

⚠️ **Observação.：** Os patches Harmony são poderosos, mas devem ser usados com cuidado, e patches incorretos podem causar falhas no jogo

👉 [Ver tutorial detalhado](Ducky.TryHarmony/README.md)

---

## 🏗️ Arquitetura de Projetos

Todos os projetos de exemplo seguem as seguintes convenções principais:：

### Configuração do projeto (obrigatório)

```xml
<PropertyGroup>
  <TargetFramework>NetStandard2,1</TargetFramework>
  <Nullable>ativar</Nullable>
  <LangVersion>previsualizar</LangVersion>
  <ImplicitUsings>verdadeiro</ImplicitUsings>
  <ModName>YourModName</ModName>
</PropertyGroup>
```

### Ponto de entrada Mod

```csharp
classe pública ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Lógica de inicialização quando o mod está ativado
    }

    protegido substituir void ModDisabled()
    {
        Lógica de limpeza quando mod está desativado
    }
}
```

### Estrutura do arquivo de recursos

```
ativos/
├── info.ini # Mod meta informação
├── description.md # Descrição detalhada (opcional)
├── preview.png # Pré-visualização (opcional)
├── lkeys.json # Lista de verificação de localização (gerada automaticamente)
├── keys.hash.txt # Hash de Validação (Gerado Automaticamente)
└── Localidades/
    ├── zh.csv # Chinês Tradução simplificada
    ├── en.csv #tradução para o português
    └── pt/ # Tradução baseada em documentos
        └── *.md
```

## 📖 Recomendações de percursos de aprendizagem

### Caminho para iniciantes

1. [Ducky.SingleProject] (Ducky.SingleProject/- Compreender a infraestrutura
2. [Ducky.InstantKill] (Ducky.InstantKill/- Aprenda a lidar com incidentes
3. [Ducky.Localização] (Ducky.Localization/- Localização mestre
4. [Ducky.BuffRegistro] (Ducky.BuffRegistration/) - Expande o conteúdo do jogo

### Caminho avançado

1. [Ducky.PackageFromNuget] (Ducky.PackageFromNuget/) - Use bibliotecas de terceiros
2. [Ducky.EntranceMod] (Ducky.EntranceMod/- Projeto de arquitetura multicamadas
3. [Ducky.TryHarmony] (Ducky.TryHarmony/- Injeção de código de tempo de execução

## 🛠️ Criar e implantar

### Comandos de compilação

```bash
# Construir todos os projetos
dotnet construir Docky.Sdk.Sample.slnx

# Construa um único projeto
dotnet construir Ducky.SingleProject/

# Limpe a compilação
dotnet limpo
```

### Implantação automatizada

O SDK implanta automaticamente mods no diretório do jogo no momento da compilação (requer a configuração de 'local.props' ou a configuração de '.csproj')<SteamFolder>`/`<DuckovFolder>\`）：

```xml
<PropertyGroup>
  <SteamFolder>C:\Arquivos de programas (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
</PropertyGroup>
```

## 📝 Especificações do projeto

- **Formato da solução**：Use o novo formato XML '.slnx'
- **Análise de Código**：O analisador interno do SDK valida a estrutura do projeto
- **Geração Automática**：Os metadados localizados são gerados automaticamente em tempo de compilação

## 🔗 Recursos relacionados

- [Pacote NuGet Ducky.Sdk] (https://www.nuget.org/packages/Ducky.Sdk)
- [Página do jogo Steam] (https://store.steampowered.com/app/XXXXX(substituído pelo link real)
- [Documentação do desenvolvedor] (docs/)

## 🤝 Orientações para a contribuição

Sinta-se à vontade para enviar problemas e solicitações pull para melhorar o projeto de amostra!

## 📄 Licença.

Este projeto utiliza [LICENSE(LICENÇA).

---

**Feliz desenvolvimento!🎮**
