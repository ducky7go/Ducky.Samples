<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.PackageFromNuget/README.md) | [English](../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch](../../de/Ducky.PackageFromNuget/README_de.md) | [Français](../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español](../../es-ES/Ducky.PackageFromNuget/README_es.md) | [日本語](../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어](../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português](README_pt.md) | [Русский](../../ru/Ducky.PackageFromNuget/README_ru.md) | [繁體中文](../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget exemplo mod

Breve descrição

Este exemplo mostra como usar pacotes NuGet de terceiros em mods, usando o YamlDotNet como exemplo, incluindo gerenciamento de dependência, acesso a arquivos de recursos e implantação de pacotes de dependência.

Antes de começar, certifique-se de que os requisitos do ambiente de pré-produção estão preparados: [Preparação do ambiente](../docs/Prequirement.md)

## 1. Introdução ao projeto

Este diretório (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) demonstra como estender a funcionalidade de mods：

- ✅ Apresentando pacotes NuGet de terceiros
- ✅ Analisando dados usando bibliotecas externas (YAML)
- ✅ Acessar o arquivo de recursos Mod
- ✅ Manipule automaticamente o empacotamento de dependência

**Cenário de exemplo：** Use a biblioteca YamlDotNet para ler e analisar o arquivo de configuração YAML na pasta Recursos Mod.

## 2. Estrutura do projeto

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Configuração do projeto
├── ModBehaviour.cs # Classe de entrada Mod
├── README.md
└── ativos/
    ├── info.ini # Mod meta informação
    ├── preview.png # Visualizar imagem
    └── nice.yml # Exemplo de arquivo YAML
```

## 3. Configuração do projeto

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>tudo</PrivateAssets>
      <IncludeAssets>tempo de execução; construir; nativo; arquivos de conteúdo; analisadores; construirtransitivo</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

Pontos principais:：\*\*

- O SDK usa 'PrivateAssets' para evitar empacotamento para saída
- Bibliotecas de terceiros (YamlDotNet) são empacotadas automaticamente no diretório de saída mod

## 4. Adicione o pacote NuGet

### Método 1：Usar CLI (recomendado)

```bash
cd Ducky.PackageFromNuget
dotnet adicionar pacote YamlDotNet
```

### Método 2：Editar manualmente .csproj

Em '<ItemGroup>» adicionado：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Método 3：Usar o Visual Studio

1. Clique com o botão direito do mouse no projeto → gerenciar pacotes NuGet
2. Pesquisar por "YamlDotNet"
3. Clique em "Instalar"

## 5) Exemplos de aplicação

### Arquivo de recurso

['ativos/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  título: "Nice YAML Configuration"
  descrição: "Esta é uma demonstração do carregamento do YAML da pasta de ativos de um mod"
```

### Classe de entrada Mod

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget / ModBehaviour.cs:1):

```csharp
usando Ducky.Sdk.Logging;
usando Ducky.Sdk.ModBehaviours;
usando YamlDotNet.Serialization;
usando YamlDotNet.Serialization.NamingConventions;

namespace Ducky.PackageFromNuget;

classe pública ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Obter o diretório onde o Mod Assembly está localizado
        var dir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
        var ymlPath = Caminho.Combine(dir, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Encontrado nice.yml:");
            
            Use YamlDotNet para desserializar arquivos YAML
            var deserializer = novo DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . Construir();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = desserializador. Desserializar<NiceData>(ymlContent);
            
            Log.Info($"Título: {niceData.NiceHeader.Title}");
            Log.Info($"Descrição: {niceData.NiceHeader.Description}");
        }
        senão
        {
            Log.Warn("nice.yml não encontrado!");
        }
    }

    protegido substituir void ModDisabled()
    {
        Limpar recursos (se necessário)
    }
}

Classe de modelo de dados
classe pública NiceData
{
    public NiceDateHeader NiceHeader { get; conjunto; } = novo();

    classe pública NiceDateHeader
    {
        public string Title { get; conjunto; } = cadeia de caracteres. Vazio;
        public string Description { get; conjunto; } = cadeia de caracteres. Vazio;
    }
}
```

## 6. Acesso ao arquivo de recursos

### Obter o catálogo mod

```csharp
Método 1：Por local de montagem (recomendado)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
```

### Acessar o arquivo de recurso

```csharp
assets/ diretório será copiado para o diretório raiz do diretório de saída Mod
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK automaticamente：**

- ✅ Copie a DLL de um pacote NuGet de terceiros
- ✅ Copie o arquivo de recurso para o diretório de saída
- ✅ Implantar no diretório de mods do jogo

## 7. Ativar mods

Quando a compilação for bem-sucedida, habilite o mod na interface de gerenciamento de mod do jogo：

1. Inicie o jogo
2. Vá para a interface de gerenciamento de mod
3. Encontre "Ducky.PackageFromNuget"
4. Clique em Ativar
5. Verifique os logs do jogo e você deve ver o conteúdo YAML analisado

## 8) Melhores práticas

### ✅ Escolha a biblioteca certa

- Prefira bibliotecas compatíveis com o .NET Standard 2.0/2.1
- Evite usar bibliotecas específicas da plataforma
- Verifique se a árvore de dependência da biblioteca é complexa

### ✅ Gerenciar versões dependentes

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Exemplos relevantes

- [Ducky.SingleProject] (../Ducky.SingleProject/README.md) - Estrutura básica do projeto
- [Ducky.EntranceMod] (../Ducky.EntranceMod/README.md- Arquitetura multicamadas (se você precisar compartilhar bibliotecas de terceiros)
- [Documentação de Preparação do Ambiente] (../docs/Prequirement.md)

## 10. Resumo

Usar um pacote NuGet de terceiros pode：

- ✅ Expanda rapidamente os recursos do mod
- ✅ Evite reinventar a roda
- ✅ Use uma solução comprovada e estável
- ✅ Aproveite os recursos da comunidade

**Notas：**

- ⚠️ Verifique se a biblioteca é compatível com o .NET Standard 2.1
- ⚠️ Esteja ciente do tamanho da dependência e do impacto no desempenho
- ⚠️ Lidar bem com conflitos de versão
- ⚠️ Cumprir com a licença da biblioteca de terceiros
