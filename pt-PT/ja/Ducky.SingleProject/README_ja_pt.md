<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.SingleProject/README.md) | [Português] (../../en/Ducky.SingleProject/README_en.md) | [Alemão] (../../de/Ducky.SingleProject/README_de.md) | [Français] (../../fr/Ducky.SingleProject/README_fr.md) | [Español] (../../es-ES/Ducky.SingleProject/README_es.md) | [Japonês] (README_ja.md) | [한국어] (../../ko/Ducky.SingleProject/README_ko.md) | [Português] (../../pt-PT/Ducky.SingleProject/README_pt.md) | [Русский] (../../ru/Ducky.SingleProject/README_ru.md) | [Chinês tradicional] (../../zh-TW/Ducky.SingleProject/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.SingleProject サンプル MOD

Breve descrição

Este exemplo mostra como usar Ducky.Sdk para criar mods para um único projeto, incluindo inicialização de projeto, implantação de SDK, ciclo de vida de mod e processo de empacotamento.

Antes de começar, certifique-se de ter preparado os requisitos pré-ambiente: Preparar o ambiente (../docs/Prequirement.md)

1. Introdução ao Projeto

Este diretório ('Ducky.SingleProject/') mostra o modo SingleProject Mod：Todos os códigos e recursos são colocados no mesmo projeto, e a classe de entrada herda 'ModBehaviourBase' (['Ducky.SingleProject/ModBehaviour.cs'](Ducky.SingleProject/ModBehaviour.cs:1)。

2. Inicializar o projeto

- Comece com um modelo ou repositório：Clone o repositório de exemplo e abra "Ducky.SingleProject/".
- Configuração de projeto necessária (recomendamos garantir com '.csproj')：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <!-- ModName 是必须项，建议与程序集名称一致（确保 .csproj 中的 <ModName> 与程序集/项目名相同） -->
    <ModName>Ducky.Singleプロジェクト</ModName>
    <!-- 本地游戏路径示例，这是必须的-->
    <SteamFolder>C:\Arquivos de programas (x86)\Steam\steamapps\common\Escape from Duckov</SteamFolder>
    <!-- SteamFolder 或者 DuckovFolder-->
    <!-- <DuckovFolder>C:\Games\Duckov</DuckovFolder> -->
  </PropertyGroup>
</Project>
```

Exemplo：Certifique-se de que o ModName corresponde ao nome do assembly/projeto.

1. Instalar e configurar o Ducky.Sdk

Recomendamos instalar o Ducky.Sdk via NuGet.Você pode usar a CLI para adicioná-la rapidamente (por exemplo, substituí-la pela versão desejada)：

```bash
dotnet adicionar pacote Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>すべての</PrivateAssets>
    <IncludeAssets>corrida; Construir; ネイティブ; conteúdoファイル; アナライザー; Construir transição</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Crie o seu primeiro ModBehaviour

- A classe ingress herda de ModBehaviourBase e implementa os métodos de ciclo de vida ModEnabled() e ModDisabled().

サンプルコード：

```csharp
Ducky.Sdk.
Use ducky.Sdk.Logging.

namespace Ducky.SingleProject;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Registro de informações no momento da inicialização
        Log.Info("Ducky.SingleProject Mod Enabled");
    }

    protegido substituir void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Desativado");
    }
}
```

5. Execução e embalagem

Comandos gerais de compilação：

```bash
# Crie toda a solução (.slnx)
dotnet construir Docky.Sdk.Sample.slnx

# サンプルプロジェクトを1つだけビルドする
dotnet construir Ducky.SingleProject/
```

6. Ativar mods (executar o jogo)

A compilação implanta automaticamente o mod no catálogo de jogos, inicia o jogo e habilita o mod na interface de gerenciamento de mod ou no jogo.Uma vez ativado, você pode verificar as informações de ativação do mod no log do jogo.
