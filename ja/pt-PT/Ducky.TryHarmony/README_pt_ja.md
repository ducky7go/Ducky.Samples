<!-- LANG_HEADER_START -->

\| [中国語(簡体字)](../../Ducky.TryHarmony/README.md) | [日本語](../../en/Ducky.TryHarmony/README_en.md) | [ドイツ語](../../de/Ducky.TryHarmony/README_de.md) | [フランセ](../../fr/Ducky.TryHarmony/README_fr.md) | [スペイン語](../../es-ES/Ducky.TryHarmony/README_es.md) | [日本語](../../ja/Ducky.TryHarmony/README_ja.md) | [한국어](../../ko/Ducky.TryHarmony/README_ko.md) | [ポルトガル語](README_pt.md) | [Русский](../../ru/Ducky.TryHarmony/README_ru.md) | [繁体字中国語](../../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.TryHarmony の例 mod

Breve descrição

Este exemplo demonstra um mod que usa HarmonyLib para corrigir o código do jogo em tempo de execução. O exemplo contém um patch Harmony simples (save patch) que tem o efeito de fazer a operação de salvamento falhar consistentemente (SaveFilePatch). Entrada e registro de patch em ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1) é realizada.

Antes de começar, certifique-se de que os requisitos do ambiente de pré-produção estão preparados: [Preparação do ambiente](../docs/Prequirement.md)

1. Introdução ao Projeto

Este diretório ('Ducky.TryHarmony/') demonstra o modo de patch Harmony：Registe o patch chamando PatchAll do Harmony em ModEnabled e cancele o patch em ModDisabled.Vemo-nos nas principais realizações：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Documentos do projeto：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Habilite o Harmony no csproj

Para usar o patch Harmony, habilite a propriedade IncludeHarmony em 'Ducky.TryHarmony.csproj'. 例示：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2,1</TargetFramework>
    <Nullable>アティバール</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>ヴェルダデイロ</ImplicitUsings>
    <ModName>ダッキー・トライハーモニー</ModName>
    <IncludeHarmony>ヴェルダデイロ</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. ファイルパッチの保存

A principal função do 'SaveFilePatch' é fazer com que a operação de salvamento falhe consistentemente, tornando mais fácil demonstrar o efeito do patch e o processo de tratamento de erros. Este exemplo de patch interceta o método relacionado ao salvamento e retorna uma falha (consulte ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. Operação e testes

- Construa o projeto：

```bash
dotnet construir Ducky.TryHarmony/
```

- Ativar Mods (implantar compilações no catálogo de mods do jogo e habilitá-las no jogo)
- A tentativa de salvar um save no jogo resulta em um "save failed", indicando que o patch está em vigor.

5. Considerações comuns

- Confirme se 'IncludeHarmony' está definido como 'true', caso contrário, o código relacionado ao Harmony não funcionará.
- Ao depurar um patch, você pode adicionar um log (usando Ducky.Sdk.Logging.Log) a 'ModBehaviour' para verificar se 'PatchAll()'/'UnpatchAll()' é chamado.
