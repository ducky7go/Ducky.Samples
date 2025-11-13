<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.EntranceMod/README.md) | [Português] (../../en/Ducky.EntranceMod/README_en.md) | [Alemão] (../../de/Ducky.EntranceMod/README_de.md) | [Français] (../../fr/Ducky.EntranceMod/README_fr.md) | [Español] (../../es-ES/Ducky.EntranceMod/README_es.md) | [Japonês] (../../ja/Ducky.EntranceMod/README_ja.md) | [한국어] (../../ko/Ducky.EntranceMod/README_ko.md) | [Português] (../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский] (../../ru/Ducky.EntranceMod/README_ru.md) | [Chinês tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod exemplo mod

Brevemente explicado

Este exemplo demonstra como desenvolver mods usando um padrão de arquitetura multicamadas, separando código compartilhado em projetos de biblioteca independentes e obtendo reutilização de código e design modular.Adequado para grandes mods ou cenários onde o código precisa ser compartilhado entre vários mods.

Antes de começar, verifique se os requisitos do ambiente front-end estão prontos： [Preparação Ambiental](.. /docs/Prequirement.md)

## 1. Introdução ao Projeto

Este exemplo consiste em dois itens:：

- **Main Mod Project** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Entrada Mod contendo arquivos de recursos
- **Projeto Biblioteca Pública** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Base de código compartilhada

Este padrão arquitetónico aplica-se：

- Grandes mods exigem gerenciamento hierárquico
- Vários Mods compartilham uma lógica comum
- Desenvolvimento colaborativo em equipa
- A lógica de negócios precisa ser testada de forma independente

## 2. Estrutura do projeto

```
Ducky.EntranceMod/ # Projeto Mod Principal
├── Ducky.EntranceMod.csproj # Configuração do projeto
├── ModBehaviour.cs # Entrada Mod
├── README.md
└── assets/ # diretório de documentos de recursos
    ├── info.ini
    ├── description.md
    ├── lkeys.json
    ├── keys.hash.txt
    └── Localidades/
        ├── zh.csv
        └── en.csv

ducky.EntranceMod.Common/ # projeto de biblioteca pública
├── Ducky.EntranceMod.Common.csproj # Configuração do Projeto de Biblioteca
├── LK.cs # Compartilhar chave de localização
└── MyModBase.cs # Classe base compartilhada
```

## 3. Configuração do Projeto Mod Principal

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1).：

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

- \\`<ExcludeSdkLib>verdadeiro</ExcludeSdkLib>- Evite empacotar repetidamente bibliotecas SDK no diretório de saída

## 4. Configuração do projeto de biblioteca pública

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1).：

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

- \\`<IsModLib>verdadeiro</IsModLib>' - Marque este item como uma biblioteca mod, e o SDK irá lidar com isso especialmente
- \\`<AssetsDir>' - Aponta para o diretório de ativos do projeto principal para que a chave de localização seja gerada corretamente

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
    Um método comum compartilhado por todos os mods pode ser adicionado aqui
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

Herdar a classe base comum
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

### ✅ Multiplexação de código

- Vários Mods podem compartilhar a biblioteca 'Ducky.EntranceMod.Common'
- Evite a duplicação de código e melhore a capacidade de manutenção

### ✅ Design modular

- A lógica de negócios é separada da entrada Mod
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

O SDK lida automaticamente com dependências de vários itens：

```bash
# Construa toda a solução (recomendado)
dotnet construir Docky.Sdk.Sample.slnx

# ou construir o projeto principal separadamente (o projeto de biblioteca dependente será construído automaticamente)
dotnet construir Ducky.EntranceMod/
```

**Construir produtos：**

- O conjunto principal de mod + montagem da biblioteca pública será empacotado em conjunto
- O arquivo de recursos é obtido do diretório 'assets/' do projeto principal
- As bibliotecas SDK não são incluídas repetidamente (porque o '<ExcludeSdkLib>verdadeiro</ExcludeSdkLib>\\`）

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

## 9. Sugestões de extensão

### Criar mais bibliotecas públicas

Para projetos complexos, várias bibliotecas públicas podem ser criadas：

```
Ducky.EntranceMod/ # Mestre Mod
Ducky.EntranceMod.Common/ # Código Universal
Ducky.EntranceMod.Gameplay/ # Lógica de jogo
Ducky.EntranceMod.UI/ # UI relacionado
```

## 10. Perguntas Frequentes

### Q： Porquê definir '<ExcludeSdkLib>verdadeiro</ExcludeSdkLib>\\`？

Um： Evite o empacotamento duplicado dos arquivos da biblioteca do Ducky.Sdk no diretório de saída mod.A biblioteca SDK já existe no jogo e não precisa ser incluída novamente.

### Q: \\`<AssetsDir>É necessário defini-lo?

Um： Para projetos de bibliotecas públicas, se uma chave de localização (LK.cs) estiver incluída, o '<AssetsDir>' para o diretório de ativos do projeto principal para que o SDK possa gerar adequadamente metadados localizados.

### Q： Vários projetos mod principais podem compartilhar a mesma biblioteca pública?

Um： OK!Esta é a vantagem das arquiteturas multicamadas.Vários mods podem fazer referência ao mesmo projeto de biblioteca pública.

### Q： Onde será gerada a chave de localização da biblioteca pública?

Um： produzirá »<AssetsDir>' no diretório especificado, ou seja, o arquivo 'lkeys.json' no diretório 'assets/' do projeto mestre.

## 11. Recursos relacionados

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - Uma referência de padrão de projeto único
- [Ducky.Localização] (.. /Ducky.Localization/README.md) - Explicação detalhada do sistema de localização
- [Documento de Preparação Ambiental] (../docs/Prequirement.md)

## 12. Resumo

O padrão de arquitetura multicamadas é adequado：

- ✅ Grandes projetos mod
- ✅ Cenários que exigem reutilização de código
- ✅ Desenvolvimento colaborativo em equipa
- ✅ Série Mod desenvolvimento

Se o seu mod é relativamente simples, recomendamos usar [Ducky.SingleProject](.. /Ducky.SingleProject/README.md) modo de projeto único.
