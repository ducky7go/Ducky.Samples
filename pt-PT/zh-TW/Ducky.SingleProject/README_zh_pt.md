<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.SingleProject/README.md) | [Português] (../../en/Ducky.SingleProject/README_en.md) | [Alemão] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japonês] (../../ja/Ducky.SingleProject/README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Chinês tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject exemplo mod

Brevemente explicado

Este exemplo mostra como criar um mod de projeto único usando Ducky.Sdk, incluindo inicialização de projeto, introdução ao SDK, ciclo de vida do mod e processo de empacotamento.

Antes de começar, certifique-se de que os requisitos pré-ambiente estão prontos： [Preparação Ambiental](.. /docs/Prequirement.md)

1. Introdução ao Projeto

Este catálogo ('Ducky. SingleProject/') demonstra o modo SingleProject Mod：Todos os códigos e recursos são colocados no mesmo projeto, e a classe de entrada herda 'ModBehaviourBase', que pode ser implementado em ['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1).

2. Inicializar o projeto

- Comece com um modelo ou armazém：Clone o repositório de exemplo e abra "Ducky.SingleProject/".
- Configurações de item necessárias (recomendado para ser garantido em '.csproj')：

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

Exemplo：Certifique-se de que o ModName é consistente com o nome do assembly/projeto.

1. Instalar e configurar o Ducky.Sdk

Recomenda-se a instalação do Ducky.Sdk via NuGet.Você pode usar a CLI para adicionar rapidamente (exemplo - substituir pela versão desejada)：

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

- A classe de entrada precisa herdar 'ModBehaviourBase' e implementar os métodos de ciclo de vida 'ModEnabled()' e 'ModDisabled()'.

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
# Crie toda a solução (.slnx)
dotnet construir Docky.Sdk.Sample.slnx

# Crie apenas um único projeto de exemplo
dotnet construir Ducky.SingleProject/
```

6. Open Mod (Executar Jogo)

Build irá implantar automaticamente mods para o catálogo de jogos, e iniciar o jogo para ativar o mod na interface de gerenciamento de mod ou no jogo.Após a ativação, você pode ver as informações de ativação do mod no log do jogo.
