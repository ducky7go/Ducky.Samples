<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.TryHarmony/README.md) | [Português] (../../en/Ducky.TryHarmony/README_en.md) | [Alemão] (../../de/Ducky.TryHarmony/README_de.md) | [Français] (../../fr/Ducky.TryHarmony/README_fr.md) | [Español] (../../es-ES/Ducky.TryHarmony/README_es.md) | [Japonês] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Português] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Chinês tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony exemplo mod

Brevemente explicado

Este exemplo demonstra o uso do HarmonyLib para corrigir um mod para o código do jogo em tempo de execução.O exemplo contém um patch Harmony simples (salvar patch) com o efeito de fazer a operação de salvamento falhar consistentemente (SaveFilePatch).O registro de entrada e patch é implementado em ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1).

Antes de começar, verifique se os requisitos do ambiente front-end estão prontos： [Preparação Ambiental](.. /docs/Prequirement.md)

1. Introdução ao Projeto

Este catálogo ('Ducky. TryHarmony/') demonstra o modo de patch Harmony：Registe o patch chamando PatchAll do Harmony em ModEnabled e cancele o patch em ModDisabled.Vemo-nos nas principais realizações：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Ficheiro de projeto：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Habilite o Harmony no csproj

Para usar o patch Harmony, habilite a propriedade IncludeHarmony em 'Ducky.TryHarmony.csproj'.Por exemplo：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>verdadeiro</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. SaveFilePatch

A principal função de 'SaveFilePatch' é fazer com que as operações de salvamento (salvar jogo) falhem consistentemente, tornando mais fácil demonstrar o efeito de patch e o processo de tratamento de erros.O exemplo de patch interceta o método relacionado a salvar e retorna uma falha (veja ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)).

4. Execução e teste

- Construir projetos：

```bash
dotnet construir Ducky.TryHarmony/
```

- Open mods (implantar compilações no catálogo de mods do jogo e abri-las no jogo)
- A tentativa de salvar um save no jogo resulta em um "Save Failed" indicando que o patch está ativo.

5. Precauções frequentes

- Confirme se 'IncludeHarmony' está definido como 'true', caso contrário, o código relacionado ao Harmony não funcionará corretamente.
- Ao depurar patches, o log pode ser adicionado a 'ModBehaviour' (usando 'Ducky.Sdk.Logging.Log') para verificar se 'PatchAll()'/'UnpatchAll()' é chamado.
