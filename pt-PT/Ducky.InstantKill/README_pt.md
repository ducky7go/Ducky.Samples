<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (README.md) |

<!-- LANG_HEADER_END -->

# Ducky.InstantKill exemplo mod

Breve descrição

Este exemplo implementa um mod simples que mata o protagonista assim que ele ataca um inimigo.Quando ativado, se a fonte de dano for o personagem principal, ele infligirá alto dano ao alvo e o matará instantaneamente.Implementação ver ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Antes de começar, certifique-se de que os requisitos do ambiente de pré-produção estão preparados: [Preparação do ambiente](../docs/Prequirement.md)

1. Introdução ao Projeto

Este diretório ('Ducky.InstantKill/') demonstra o modo mod de projeto único：Todos os códigos e recursos são colocados no mesmo projeto, e a classe de entrada herda 'ModBehaviourBase', como mostrado em ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Inicializar o projeto

- Clone o repositório e abra 'Ducky.InstantKill/'.
- Recomenda-se incluir pelo menos em '.csproj'：

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

4. Escrever ModBehaviour

A classe ingress herda o ModBehaviourBase e implementa os métodos de ciclo de vida ModEnabled() e ModDisabled().Este exemplo registra o processador no evento 'OnHurt' para infligir grandes danos ao alvo quando o dano vem do personagem principal.

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

6. Ativar Mod (Executar o jogo)

Build irá implantar automaticamente o mod no catálogo do jogo, habilitá-lo na interface de gerenciamento de mod do jogo e testar o efeito assim que o jogo for lançado e o campo de batalha for iniciado：Quando o protagonista ataca um inimigo, o inimigo deve morrer instantaneamente.
