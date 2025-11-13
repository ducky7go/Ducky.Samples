<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.PackageFromNuget/README.md) | [Português] (../../en/Ducky.PackageFromNuget/README_en.md) | [Alemão] (../../de/Ducky.PackageFromNuget/README_de.md) | [Français] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japonês] (README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Chinês tradicional] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル MOD

Breve descrição

Este exemplo mostra como usar pacotes NuGet de terceiros em mods, usando o YamlDotNet como exemplo, como gerenciamento de dependência, acesso a arquivos de recursos e implantação de pacotes de dependência.

Antes de começar, certifique-se de ter preparado os requisitos do ambiente de pré-produção: Prepare seu ambiente (../docs/Prequirement.md)

## 1. Introdução ao projeto

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) mostra como estender a funcionalidade de mods：

- ✅ Apresentando pacotes NuGet de terceiros
- ✅ Analisando dados usando bibliotecas externas (YAML)
- ✅ Mod リソース ファイルにアクセスする
- ✅ Manipular automaticamente pacotes de dependência

Cenário de exemplo：\*\* Use a biblioteca YamlDotNet para ler e analisar o arquivo de configuração YAML na pasta Recursos Mod.

## 2. Estrutura do projeto

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Configuração do Projeto
├── ModBehaviour.cs #モードエントリークラス
├── README.md
└── アセット/
    ├── info.ini #モードメタ情報
    ├── preview.png #プレビュー画像
    └── nice.yml # サンプルYAMLファイル
```

## 3. Estrutura do Projeto

['Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>corrida; Construir; ネイティブ; conteúdoファイル; アナライザー; Construir transição</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

キーポイント：\*\*

- O SDK usa 'PrivateAssets' para evitar empacotamento na saída
- Bibliotecas de terceiros (YamlDotNet) são empacotadas automaticamente no diretório de saída mod

## 4. Adicionar um pacote NuGet

### Método 1：Usar a CLI (recomendado)

```bash
cd Ducky.PackageFromNuget
dotnet adicionar pacote YamlDotNet
```

### Método 2：Editar manualmente o arquivo .csproj

で '<ItemGroup>' foi adicionado.：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Método 3：Usar o Visual Studio

1. Clique com o botão direito do mouse no projeto → gerenciar pacotes NuGet
2. Pesquisar por "YamlDotNet"
3. 「インストール」をクリックします

## 5) Exemplos de aplicação

### リソースファイル

['ativo/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  título: "Nice YAML Configuration"
  Descrição: "これは、MOD の assets フォルダーから YAML をロードするデモンストレーションです"
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Use ducky.Sdk.Logging.
Ducky.Sdk.ModBehaviours.
YamlDotNet.Serialização.
Use YamlDotNet.Serialization.NamingConventions.

namespace Ducky.PackageFromNuget;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Obter o diretório onde o assembly mod está localizado
        var dir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
        var ymlPath = Path.Combine(ディレクトリ, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Encontrado nice.yml:");
            
            Use YamlDotNet para desserializar arquivos YAML
            var deserializer = novo DeserializerBuilder()
                . Convenções de nomenclatura (convenções de nomenclatura de casos Camel.
                . ビルド();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = デシリアライザー。 Desserialização<NiceData>(ymlコンテンツ);
            
            Log.Info($"タイトル: {niceData.NiceHeader.Title}");
            Log.Info($" Descrição: {niceData.NiceHeader.Description}");
        }
        Caso contrário,
        {
            Log.Warn("nice.yml não encontrado!");
        }
    }

    protegido substituir void ModDisabled()
    {
        Limpar recursos (se necessário)
    }
}

データモデルクラス
público クラス NiceData
{
    public NiceDateHeader NiceHeader { get; セット; } = novo();

    パブリック・クラス NiceDateHeader
    {
        public string Title { get; セット; } = cadeia de caracteres. Vazio;
        string pública explicada { get; } セット; } = cadeia de caracteres. Vazio;
    }
}
```

## 6. リソースファイルへのアクセス

### Obter o catálogo mod

```csharp
Método 1：Por local de montagem (recomendado)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location)!;
```

### リソースファイルにアクセスする

```csharp
O diretório assets/ é copiado para o diretório raiz do diretório de saída Mod
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK Automático：**

- ✅ サード パーティの NuGet パッケージの DLL をコピーする
- ✅ Copie o arquivo de recurso para o diretório de saída
- ✅ ゲーム mods ディレクトリにデプロイする

## 7. Ativar mods

Quando a compilação for bem-sucedida, habilite o mod na interface de gerenciamento de mod do jogo：

1. Inicie o jogo
2. Ir para a interface de gerenciamento mod
3. Procure por "Ducky.PackageFromNuget".
4. Clique em Ativar
5. Se você verificar os logs do jogo, você verá o conteúdo do YAML analisado

## 8) ベストプラクティス

### ✅ Escolha a biblioteca certa

- Priorizar bibliotecas compatíveis com o .NET Standard 2.0/2.1
- Evite usar bibliotecas específicas da plataforma
- Verifique se a árvore de dependência da biblioteca é complexa

### ✅ Gerenciamento de versão dependente

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Caso conexo

- [ダッキー・シングルプロジェクト] (../Ducky.SingleProject/README.md) - estrutura básica do projeto
- [ダッキー・エントランス・モッド] (.. /Ducky.EntranceMod/README.md - Arquitetura multicamadas (se você precisar compartilhar bibliotecas de terceiros)
- Documentação de prontidão do ambiente (../docs/Prequirement.md)

## 10. プロット

Ao usar um pacote NuGet de terceiros,：

- ✅ Expanda rapidamente a funcionalidade mod
- ✅ Evite reinventar a roda
- ✅ Utilize soluções comprovadas e estáveis
- ✅ Aproveitando os recursos da comunidade

**Observação：**

- ⚠️ Verifique se sua biblioteca é compatível com o .NET Standard 2.1
- ⚠️ Esteja ciente do tamanho das dependências e seu impacto no desempenho
- ⚠️ Lidar com conflitos de versão adequadamente
- ⚠️ Cumprir com licenças de bibliotecas de terceiros
