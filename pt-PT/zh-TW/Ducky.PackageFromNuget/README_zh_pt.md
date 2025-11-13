<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.PackageFromNuget/README.md) | [Português] (../../en/Ducky.PackageFromNuget/README_en.md) | [Alemão] (../../de/Ducky.PackageFromNuget/README_de.md) | [Français] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japonês] (../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Chinês tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget exemplo mod

Brevemente explicado

Este exemplo mostra como usar pacotes NuGet de terceiros em Mod (usando YamlDotNet como exemplo), incluindo gerenciamento de dependência, acesso a arquivos de recursos e implantação de pacotes de dependência.

Antes de começar, verifique se os requisitos do ambiente front-end estão prontos： [Preparação Ambiental](.. /docs/Prequirement.md)

## 1. Introdução ao Projeto

Este diretório (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) demonstra como estender a funcionalidade dos mods：

- ✅ Apresentando pacotes NuGet de terceiros
- ✅ Analisando dados usando bibliotecas externas (YAML)
- ✅ Acesse o arquivo de recurso mod
- ✅ Manipule automaticamente o empacotamento de dependência

**Exemplos de cenários：** Use a biblioteca YamlDotNet para ler e resolver perfis YAML na pasta de recursos Mod.

## 2. Estrutura do projeto

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Configuração do projeto
├── ModBehaviour.cs # Entrada Mod
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

**Pontos principais:：**

- O SDK usa 'PrivateAssets' para evitar empacotamento para a saída
- A biblioteca de terceiros (YamlDotNet) será automaticamente empacotada no diretório de saída Mod

## 4. Adicione o pacote NuGet

### Método 1：Usando CLI (recomendado)

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

1. Clique com o botão direito do mouse no projeto → Gerenciar pacotes NuGet
2. Pesquisar por "YamlDotNet"
3. Clique em "Instalar"

## 5) Exemplos de aplicação

### arquivo de recurso

['ativos/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  título: "Nice YAML Configuration"
  descrição: "Esta é uma demonstração do carregamento do YAML da pasta de ativos de um mod"
```

### Classe de entrada Mod

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

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
        Obter o diretório onde o assembly mod está localizado
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

## 6. Acesso ao Arquivo de Recursos

### Obter o catálogo mod

```csharp
Método 1：Passar o local de montagem (recomendado)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour). Assembly.Location)!;
```

### Acessar o arquivo de recurso

```csharp
assets/ diretório será copiado para o diretório raiz do diretório de saída mod
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**Processamento automático SDK：**

- ✅ Copie a DLL de um pacote NuGet de terceiros
- ✅ Copie o arquivo de recurso para o diretório de saída
- ✅ Implantar no diretório Game Mods

## 7. Ativar mods

Quando a compilação for bem-sucedida, habilite o mod na interface de gerenciamento de mod do jogo：

1. Inicie o jogo
2. Entre na interface de gerenciamento mod
3. Encontre "Ducky.PackageFromNuget"
4. Clique em Ativar
5. Olhando para os logs do jogo, você deve ser capaz de ver o conteúdo YAML analisado

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

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - A estrutura subjacente do projeto
- [Ducky.EntranceMod] (.. /Ducky.EntranceMod/README.md) - Arquitetura multicamadas (se você precisar compartilhar bibliotecas de terceiros)
- [Documento de Preparação Ambiental] (../docs/Prequirement.md)

## 10. Resumo

Usar um pacote NuGet de terceiros pode：

- ✅ Expanda rapidamente as funções mod
- ✅ Evite reinventar a roda
- ✅ Utilize uma solução madura e estável
- ✅ Aproveite os recursos da comunidade

**Notas：**

- ⚠️ Verifique se a biblioteca é compatível com o .NET Standard 2.1
- ⚠️ Esteja ciente do tamanho da dependência e do impacto no desempenho
- ⚠️ Lidar bem com conflitos de versão
- ⚠️ Cumprir com licenças de bibliotecas de terceiros
