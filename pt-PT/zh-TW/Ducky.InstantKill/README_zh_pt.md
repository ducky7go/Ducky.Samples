<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.InstantKill/README.md) | [Português] (../../en/Ducky.InstantKill/README_en.md) | [Alemão] (../../de/Ducky.InstantKill/README_de.md) | [Français] (../../fr/Ducky.InstantKill/README_fr.md) | [Español] (../../es-ES/Ducky.InstantKill/README_es.md) | [Japonês] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Português] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Chinês tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill exemplo mod

Brevemente explicado

Este exemplo implementa um mod simples que mata o protagonista quando ele ataca um inimigo.Após a ativação, quando ocorre um evento de lesão, se a fonte do dano for o protagonista, ele infligirá alto dano ao alvo e o matará instantaneamente.Para implementação, consulte ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Antes de começar, verifique se os requisitos do ambiente front-end estão prontos： [Preparação Ambiental](.. /docs/Prequirement.md)

1. Introdução ao Projeto

Este diretório ('Ducky. InstantKill/') demonstra o modo Mod de projeto único：Todos os códigos e recursos são colocados no mesmo projeto, e a classe de entrada herda 'ModBehaviourBase', veja ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Inicializar o projeto

- Clone o armazém e abra 'Ducky.InstantKill/'.
- Recomendado em ". CSPROJ：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>ativar</Nullable>
    <LangVersion>previsualizar</LangVersion>
    <ImplicitUsings>verdadeiro</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.InstantKill</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Instalar e configurar o Ducky.Sdk

Recomenda-se adicionar um SDK via NuGet：

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

4. Escrever ModBehaviour

A classe de entrada precisa herdar 'ModBehaviourBase' e implementar os métodos de ciclo de vida 'ModEnabled()' e 'ModDisabled()'.Este exemplo registra o processador no evento "OnHurt", que causa uma grande quantidade de dano ao alvo quando o dano vem do personagem principal.

Código de exemplo：

```csharp
usando Ducky.Sdk;
usando Ducky.Sdk.Logging;

namespace Ducky.InstantKill;

classe pública ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    protegido substituir void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    vazio privado Health_OnHurt(Saúde h, DamageInfo da)
    {
        se (da. Para(h). IsFromMainToEnemy())
        {
            Log.Debug("Instant Kill Mod: Matar inimigo.");
            h.Hurt(novo DamageInfo(h.TryGetCharacter())
            {
                danoValor = 1000,
            });
        }
    }
}
```

5. Executar e empacotar

Comandos de compilação comuns：

```bash
# Construa toda a solução
dotnet construir Docky.Sdk.Sample.slnx

# Construa apenas este projeto
dotnet construir Ducky.InstantKill/
```

6. Open Mod (Executar Jogo)

Depois que a compilação implanta automaticamente o mod no diretório do jogo, o mod é ativado na interface de gerenciamento de mod do jogo, e o efeito pode ser testado depois que o jogo entra na cena do campo de batalha：Quando o protagonista ataca o inimigo, o inimigo deve morrer instantaneamente.
