<!-- LANG_HEADER_START -->

\| [Chinês simplificado] (../../Ducky.InstantKill/README.md) | [Português] (../../en/Ducky.InstantKill/README_en.md) | [Alemão] (../../de/Ducky.InstantKill/README_de.md) | [Français] (README_fr.md) | [Español] (../../es-ES/Ducky.InstantKill/README_es.md) | [Japonês] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Português] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Chinês tradicional] (../../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod d'exemple Ducky.InstantKill

Descrição de Brève

Cet exemple implémente un mod simple qui tue le protagoniste dès qu'il attaque un ennemi. Lorsqu'il est activé, si la source de dégâts est le personnage principal, il infligera des dégâts élevés à la cible et la tuera instantanément. Mise en œuvre voir ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Avant de commencer, assurez-vous que les exigences de l'environnement de préproduction sont préparées : [Préparation de l'environnement](../docs/Prequirement.md)

1. Présentation du projet

Ce répertoire ('Ducky.InstantKill/') ilustra le mode mod d'un seul projet：Tout le code et les ressources sont placés dans le même projet, et la classe entry hérite de 'ModBehaviourBase', comme indiqué dans ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Inicializador do projeto

- Clonez le dépôt et ouvrez 'Ducky.InstantKill/'.
- Il est recommandé d'inclure au moins dans '.csproj'：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>NetStandard2,1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>Vrai</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.InstantKill</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Installer et configurer Ducky.Sdk

Nous vous recommandons d'ajouter un SDK via NuGet：

```bash
dotnet ajouter le paquet Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>tout</PrivateAssets>
    <IncludeAssets>Duree; construire; Indigène; arquivos de conteúdo ; Analisadores; construiretransitivo</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Écrire ModBehaviour

La classe ingress hérite de la ModBehaviourBase et implémente les méthodes de cycle de vie ModEnabled() et ModDisabled(). Exemplo exemplificativo do processeur sur l'événement «OnHurt» pour infliger des dégâts importants à la cible lorsque les dégâts proviennent du personnage principal.

Exemple de code：

```csharp
en utilisant Ducky.Sdk ;
à l'aide de Ducky.Sdk.Logging ;

espaço de nomes Ducky.InstantKill ;

classe publique ModBehaviour : ModBehaviourBase
{
    protegido substituir void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt ;
    }

    protegido substituir void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt ;
    }

    privé void Health_OnHurt(Saúde h, DamageInfo da)
    {
        si (da. À h). IsFromMainToEnemy())
        {
            Log.Debug(« Instant Kill Mod : Tuer l'ennemi. ») ;
            h.Hurt(novo DamageInfo(h.TryGetCharacter())
            {
                dommageValeur = 1000,
            });
        }
    }
}
```

5. Exécuter et empaqueter

Commandes de compilation courantes：

```bash
# Construire l'ensemble de la solution
dotnet construir Docky.Sdk.Sample.slnx

# Construire ce projet uniquement
dotnet construir Ducky.InstantKill/
```

6. Activer le mod (exécuter le jeu)

Build déploiera automatiquement le mod dans le catalogue de jeux, l'activera dans l'interface de gestion des mods du jeu et testera l'effet une fois le jeu lancé et le champ de bataille lancé：Lorsque le protagoniste attaque un ennemi, l'ennemi doit mourir instantanément.
