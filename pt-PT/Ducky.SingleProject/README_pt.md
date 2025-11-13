<!-- LANG_HEADER_START -->

\| [简体中文](README.md) | [English](../en/Ducky.SingleProject/README_en.md) | [Deutsch](../de/Ducky.SingleProject/README_de.md) | [Français](../fr/Ducky.SingleProject/README_fr.md) | [Español](../es-ES/Ducky.SingleProject/README_es.md) | [日本語](../ja/Ducky.SingleProject/README_ja.md) | [한국어](../ko/Ducky.SingleProject/README_ko.md) | [Português](../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский](../ru/Ducky.SingleProject/README_ru.md) | [繁體中文](../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject exemplo mod

Breve descrição

Este exemplo mostra como usar Ducky.Sdk para criar um mod de projeto único, incluindo inicialização de projeto, introdução ao SDK, ciclo de vida do mod e processo de empacotamento.

Antes de começar, certifique-se de que os requisitos pré-ambiente estão prontos: [Preparação do ambiente](../docs/Prequirement.md)

1. Introdução ao Projeto

Este diretório ('Ducky.SingleProject/') demonstra o modo SingleProject Mod：Todos os códigos e recursos são colocados no mesmo projeto, e a classe de entrada herda o 'ModBehaviourBase', veja ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Inicializar o projeto

- Comece com um modelo ou repositório：Clone o repositório de exemplo e abra 'Ducky.SingleProject/'.
- Configuração necessária do projeto (recomendado para ser garantido em '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.SingleProject</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Arquivos de programas (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

Exemplo：Verifique se o ModName corresponde ao nome do assembly/projeto.

1. Instalar e configurar o Ducky.Sdk

Recomenda-se a instalação do Ducky.Sdk via NuGet.Você pode usar a CLI para adicionar rapidamente (exemplo - substitua pela versão desejada)：

```bash
dotnet adicionar pacote Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>tudo</PrivateAssets>
    <IncludeAssets>tempo de execução; construir; nativo; arquivos de conteúdo; analisadores; construirtransitivo</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Escreva o primeiro ModBehaviour

- A classe ingress herda o ModBehaviourBase e implementa os métodos de ciclo de vida ModEnabled() e ModDisabled().

Código de exemplo：

```csharp
usando Ducky.Sdk;
usando Ducky.Sdk.Logging;

namespace Ducky.SingleProject;

classe pública ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Registrar informações na inicialização
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    protegido substituir void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Desativado");
    }
}
```

5. Executar e empacotar

Comandos de compilação comuns：

```bash
# Construa toda a solução (.slnx)
dotnet construir Docky.Sdk.Sample.slnx

# Crie apenas um único projeto de exemplo
dotnet construir Ducky.SingleProject/
```

6. Ativar Mod (Executar o jogo)

Build implanta automaticamente mods no catálogo de jogos e inicia o jogo para habilitar o mod na interface de gerenciamento de mods ou no jogo.Uma vez ativado, você pode ver as informações de ativação do mod no log do jogo.
