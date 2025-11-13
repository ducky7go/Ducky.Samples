<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (README.md) |

<!-- LANG_HEADER_END -->

# Mod d’exemple Ducky.InstantKill

Brève description

Cet exemple implémente un mod simple qui tue le protagoniste dès qu’il attaque un ennemi.Lorsqu’il est activé, si la source de dégâts est le personnage principal, il infligera des dégâts élevés à la cible et la tuera instantanément.Mise en œuvre voir ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Avant de commencer, assurez-vous que les exigences de l’environnement de préproduction sont préparées : [Préparation de l’environnement](../docs/Prequirement.md)

1. Présentation du projet

Ce répertoire ('Ducky.InstantKill/') illustre le mode mod d’un seul projet：Tout le code et les ressources sont placés dans le même projet, et la classe entry hérite de 'ModBehaviourBase', comme indiqué dans ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Initialiser le projet

- Clonez le dépôt et ouvrez 'Ducky.InstantKill/'.
- Il est recommandé d’inclure au moins dans '.csproj'：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.InstantKill</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. Installer et configurer Ducky.Sdk

Nous vous recommandons d’ajouter un SDK via NuGet：

```bash
dotnet ajouter le paquet Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>tout</PrivateAssets>
    <IncludeAssets>Duree; construire; indigène; contentfiles ; Analyseurs; construiretransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Écrire ModBehaviour

La classe ingress hérite de la ModBehaviourBase et implémente les méthodes de cycle de vie ModEnabled() et ModDisabled().Cet exemple enregistre le processeur sur l’événement 'OnHurt' pour infliger des dégâts importants à la cible lorsque les dégâts proviennent du personnage principal.

Exemple de code：

```csharp
en utilisant Ducky.Sdk ;
à l’aide de Ducky.Sdk.Logging ;

espace de noms Ducky.InstantKill ;

classe publique ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt ;
    }

    protected override void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt ;
    }

    privé void Health_OnHurt(Health h, DamageInfo da)
    {
        si (da. À h). IsFromMainToEnemy())
        {
            Log.Debug(« Instant Kill Mod : Tuer l’ennemi. ») ;
            h.Hurt(new DamageInfo(h.TryGetCharacter())
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
# Construire l’ensemble de la solution
dotnet build Docky.Sdk.Sample.slnx

# Construire ce projet uniquement
dotnet build Ducky.InstantKill/
```

6. Activer le mod (exécuter le jeu)

Build déploiera automatiquement le mod dans le catalogue de jeux, l’activera dans l’interface de gestion des mods du jeu et testera l’effet une fois le jeu lancé et le champ de bataille lancé：Lorsque le protagoniste attaque un ennemi, l’ennemi doit mourir instantanément.
