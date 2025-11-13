<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.BuffRegistration/README.md) | [English](../../en/Ducky.BuffRegistration/README_en.md) | [Deutsch](../../de/Ducky.BuffRegistration/README_de.md) | [Français](../../fr/Ducky.BuffRegistration/README_fr.md) | [Español](../../es-ES/Ducky.BuffRegistration/README_es.md) | [日本語](../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어](../../ko/Ducky.BuffRegistration/README_ko.md) | [Português](README_pt.md) | [Русский](../../ru/Ducky.BuffRegistration/README_ru.md) | [繁體中文](../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.BuffRegistration exemplo mod

Breve descrição

Este exemplo mostra como usar Ducky.Sdk para registrar um buff personalizado, incluindo chaves localizadas e layouts de ativos.Entrada e implementação ver ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

Antes de começar, certifique-se de que os requisitos do ambiente de pré-produção estão preparados: [Preparação do ambiente](../docs/Prequirement.md)

1. Introdução ao Projeto

Este diretório (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1Demonstra o padrão de registro de Buffs via Contract.Buffs em um mod de projeto único.Este projeto também contém chaves de localização, consulte ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. Inicializar o projeto

- Clone o repositório e abra 'Ducky.BuffRegistration/'.
- Recomenda-se incluir pelo menos .csproj：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.BuffRegisto</ModName>
  </PropertyGroup>
</Project>
```

3. Instalar e configurar o Ducky.Sdk

Recomendamos adicionar um SDK via NuGet：

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

4. Registrar um buff personalizado (exemplo)

Use Contract.Buffs.RegisterBuff para registrar o Buff e definir o nome para exibição, a descrição, o ícone e o tempo de vida no retorno de chamada.Exemplo：

```csharp
usando Ducky.Sdk;

classe pública ModBehaviour : ModBehaviourBase
{
    _buffId internacional privado;

    protegido substituir void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            buff. SetDisplayName(LK. UI. DoNothingBuffName)
                . SetDescription(LK. UI. DoNothingBuffDescrição)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(verdadeiro)
                . SetTotalLifeTime(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        Ouça a inicialização da cena：Concede automaticamente este buff ao protagonista ao entrar na base (veja ModBehaviour para implementação)
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    protegido substituir void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
    }

    vazio privado SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter;
            if (principal != nulo)
            {
                Criar e adicionar uma instância de Buff registrada ao entrar na cena base
                principal. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }
}
```

5. localização

Este exemplo define uma chave string em ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。O arquivo de tradução geralmente está localizado em 'assets/locales/' (visível no diretório de origem), mas tenha cuidado：CSVs de tradução, metadados de tradução ('assets/lkeys.json') e arquivos de validação ('assets/keys.hash.txt') são coletados automaticamente e gravados no diretório 'assets/' pelo analisador/gerador MSBuild do SDK em tempo de compilação.Portanto, o fluxo de trabalho recomendado é:：

- Definir ou modificar chaves no código (recomendado)：Editar ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1) e compilar, e o SDK gera/atualiza os metadados de tradução correspondentes.
- Ou edite 'ativos/localidades/ diretamente localmente" localmente{lang}.csv' e recompile para permitir que o SDK integre as alterações.
- Se utilizar a tradução baseada em ficheiros (por exemplo, escrever texto longo num ficheiro Markdown), pode utilizar '[TranslateFile("md")]' em 'LK.cs'; O SDK colocará o arquivo correspondente em 'assets/locales/{lang}/' e faça referência a ele em CSV com o nome do arquivo.

Exemplo de chave：

- «LK. UI. DoNothingBuffName»
- «LK. UI. DoNothingBuffDescrição»

Observação：'assets/lkeys.json' e 'assets/keys.hash.txt' são usados para posicionamento em tempo de execução e verificação de embalagem, e a modificação manual não é recomendada. Para forçar uma atualização, limpe e recompile o projeto.

6. Construir e empacotar

Comandos de compilação comuns：

```bash
dotnet construir Ducky.BuffRegistration/
```

6. Ativar Mod (Executar o jogo)

A compilação implantará automaticamente o mod no catálogo do jogo, habilitará o mod na interface de gerenciamento de mods do jogo e iniciará o jogo para entrar na cena base para ver se o protagonista recebeu um buff personalizado.
