<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (README.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod exemplo mod

Breve descrição

Este exemplo mostra como desenvolver mods usando um padrão de arquitetura multicamadas para separar o código compartilhado em projetos de biblioteca separados para reutilização de código e design modular.Adequado para grandes mods ou cenários onde o código precisa ser compartilhado entre vários mods.

Antes de começar, certifique-se de que os requisitos do ambiente de pré-produção estão preparados: [Preparação do ambiente](../docs/Prequirement.md)

## 1. Introdução ao projeto

Este exemplo consiste em dois itens:：

- **Projeto Mod Principal** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Entrada Mod contendo arquivos de recursos
- **Projeto Biblioteca Pública** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Base de código compartilhada

Este padrão arquitetónico aplica-se：

- Grandes mods exigem gerenciamento hierárquico
- Vários mods compartilham lógica comum
- Desenvolvimento colaborativo em equipa
- A lógica de negócios precisa ser testada de forma independente

## 2. Estrutura do projeto

```
Ducky.EntranceMod/ # Projeto Mod Principal
├── Ducky.EntranceMod.csproj # Configuração do projeto
├── ModBehaviour.cs # Classe de entrada Mod
├── README.md
└── assets/ # Diretório de arquivos de recursos
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Localidades/
        ├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/ # Projeto Biblioteca Pública
├── Ducky.EntranceMod.Common.csproj # Configuração do Projeto de Biblioteca
├── LK.cs # Compartilhar chave de localização
└── MyModBase.cs # Classe base compartilhada
```

## 3. Configuração do Projeto Mod Principal

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1) Configuração da chave：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>verdadeiro</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>tudo</PrivateAssets>
      <IncludeAssets>tempo de execução; construir; nativo; arquivos de conteúdo; analisadores; construirtransitivo</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**Descrição da configuração principal：**

- \`<ExcludeSdkLib>verdadeiro</ExcludeSdkLib>- Evite o empacotamento duplicado de bibliotecas SDK no diretório de saída

## 4. Configuração do projeto de biblioteca pública

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1) Configuração da chave：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>verdadeiro</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/ativos</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>tudo</PrivateAssets>
      <IncludeAssets>tempo de execução; construir; nativo; arquivos de conteúdo; analisadores; construirtransitivo</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**Descrição da configuração principal：**

- \`<IsModLib>verdadeiro</IsModLib>' - Marque este item como uma biblioteca mod, o SDK irá lidar com isso especialmente
- \`<AssetsDir>' - Aponta para o diretório de ativos do projeto principal para que a chave de localização seja gerada corretamente

## 5. Partilhe exemplos de código

### Partilhar chaves de localização

['Ducky.EntranceMod.Common/LK.cs'] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
namespace Ducky.EntranceMod.Common;

classe estática pública LK
{
    interface do usuário de classe estática pública
    {
        public const string NiceWelcomeMessage = "ducky_entrancemod.common.ui.nicewelcomemessage";
    }
}
```

### Classes base compartilhadas

['Ducky.EntranceMod.Common/MyModBase.cs'] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
usando Ducky.Sdk.ModBehaviours;

namespace Ducky.EntranceMod.Common;

classe abstrata pública MyModBase : ModBehaviourBase
{
    Um método universal para todo o compartilhamento Mod é acessível para adicionar aqui
    vazio virtual protegido LogModInfo(mensagem string)
    {
        Log.Info($"[{GetType(). Nome}] {message}");
    }
}
```

### O mod principal usa um código compartilhado

['Ducky.EntranceMod/ModBehaviour.cs'] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
usando Ducky.Sdk.Logging;
usando Ducky.EntranceMod.Common;

namespace Ducky.EntranceMod;

Classe base compartilhada de herança
classe pública ModBehaviour : MyModBase
{
    protegido substituir void ModEnabled()
    {
        Log.Info("Mod Enabled");
        Usar uma chave de localização compartilhada
        var mensagem = LK. UI. NiceWelcomeMessage;
        LogModInfo($"Chave de mensagem de boas-vindas: {message}");
    }

    protegido substituir void ModDisabled()
    {
        Log.Info("Mod desativado");
    }
}
```

## 6. Vantagens da arquitetura multicamadas

### ✅ Reutilização de código

- Vários Mods podem compartilhar a biblioteca 'Ducky.EntranceMod.Common'
- Evite a duplicação de código e melhore a capacidade de manutenção

### ✅ Design modular

- A lógica de negócios é dissociada da entrada mod
- Teste unitário fácil
- Limpar dependências

### ✅ Colaboração em equipa

- Diferentes desenvolvedores podem desenvolver diferentes camadas de forma independente
- Reduzir conflitos de código
- Revisão de código fácil

### ✅ Partilha localizada

- As bibliotecas públicas podem definir chaves de localização compartilhadas
- Todos os mods que usam a biblioteca são automaticamente suportados para tradução

## 7. Construa o processo

O SDK lida automaticamente com dependências de vários projetos：

```bash
# Construa toda a solução (recomendado)
dotnet construir Docky.Sdk.Sample.slnx

# ou construir o projeto principal separadamente (que cria automaticamente o projeto de biblioteca dependente)
dotnet construir Ducky.EntranceMod/
```

Construa produtos：\*\*

- O assembly mod principal + o assembly da biblioteca pública são empacotados juntos
- O arquivo de recursos é obtido do diretório 'assets/' do projeto principal
- As bibliotecas SDK não são incluídas repetidamente (porque '<ExcludeSdkLib>verdadeiro</ExcludeSdkLib>\`）

## 8. Ativar mods

Uma vez construídos, os mods são automaticamente implantados no catálogo de jogos：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
├── Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── ativos/
    ├── info.ini
    ├── lkeys.json
    └── Localidades/</游戏目录>
```

Habilite o mod na interface de gerenciamento de mod do jogo.

## 9. Recomendações de extensão

### Criar mais bibliotecas públicas

Para projetos complexos, você pode criar várias bibliotecas públicas：

```
Ducky.EntranceMod/ # Mestre Mod
Ducky.EntranceMod.Common/ # Código Universal
Ducky.EntranceMod.Gameplay/ # Lógica de jogo
Ducky.EntranceMod.UI/ # UI relacionado
```

## 10. Perguntas frequentes

### P: Porquê definir '<ExcludeSdkLib>verdadeiro</ExcludeSdkLib>\`？

R: Evite o empacotamento duplicado dos arquivos da biblioteca do Ducky.Sdk no diretório de saída mod.A biblioteca SDK já existe no jogo e não precisa ser incluída novamente.

### Q: \`<AssetsDir>Você tem que configurá-lo?

R: Para projetos de bibliotecas públicas, se incluir uma chave de localização (LK.cs), tem de definir '<AssetsDir>Aponta para o diretório de ativos do projeto principal para que o SDK possa gerar metadados localizados corretamente.

### P: Vários projetos mod principais podem compartilhar a mesma biblioteca pública?

R: Sim!Esta é a vantagem das arquiteturas multicamadas.Vários mods podem fazer referência ao mesmo projeto de biblioteca pública.

### P: Onde será gerada a chave de localização para bibliotecas públicas?

R: Irá gerar para '<AssetsDir>' especificado diretório, ou seja, o arquivo 'lkeys.json' no diretório 'assets/' do projeto principal.

## 11. Recursos relacionados

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Referência de modo de item único
- [Ducky.Localização] (../Ducky.Localization/README.md- Explicação detalhada do sistema de localização
- [Documentação de Preparação do Ambiente] (../docs/Prequirement.md)

## 12. Resumo

O padrão de arquitetura multicamadas é adequado：

- ✅ Grandes projetos mod
- ✅ Cenários em que a reutilização de código é necessária
- ✅ Desenvolvimento colaborativo em equipa
- ✅ Série Mod Development

Se o seu mod é relativamente simples, recomenda-se começar com [Ducky.SingleProject](../Ducky.SingleProject/README.md) modelo de projeto único.
