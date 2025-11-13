<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.InstantKill/README.md) | [영어] (../../en/Ducky.InstantKill/README_en.md) | [도이치] (../../de/Ducky.InstantKill/README_de.md) | [프랑세] (README_fr.md) | [스페인어] (../../es-ES/Ducky.InstantKill/README_es.md) | [일본어] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.InstantKill/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod d'exemple Ducky.InstantKill

Brève 설명

Cet exemple implémente un mod simple qui tue le protagoniste dès qu'il attaque un ennemi. Lorsqu'il est activé, si la source de dégâts est le personnage principal, il infligera des dégâts élevés à la cible et la tuera instantanément. Mise en œuvre voir ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

Avant de commencer, assurez-vous que les exigences de l'environnement de préproduction sont préparées : [Préparation de l'environnement](../docs/Prequirement.md)

1. Présentation du projet

Ce répertoire ('Ducky.InstantKill/') illustre le mode mod d'un seul projet：Tout le code et les ressources sont placés dans le même projet, et la classe entry hérite de 'ModBehaviourBase', comme indiqué dans ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. Initialiser le projet

- Clonez le dépôt et ouvrez 'Ducky.InstantKill/'.
- Il est recommandé d'inclure au moins dans '.csproj'：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>액티퍼</Nullable>
    <LangVersion>아페르수</LangVersion>
    <ImplicitUsings>브라이</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>덕키.인스턴트 킬</ModName>
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
    <PrivateAssets>권유</PrivateAssets>
    <IncludeAssets>듀리; 해석; 인디젠; 콘텐츠 파일 ; 분석가; construire전동사</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Écrire ModBehaviour

La classe ingress hérite de la ModBehaviourBase et implémente les méthodes de cycle de vie ModEnabled() et ModDisabled(). Cet exemple enregistre le processeur sur l'événement 'OnHurt' pour infliger des dégâts importants à la cible lorsque les dégâts proviennent du personnage principal.

Exemple de code：

```csharp
en utilisant Ducky.Sdk ;
à l'aide de Ducky.Sdk.Logging ;

espace de noms Ducky.InstantKill ;

classe publique ModBehaviour : ModBehaviourBase
{
    protected 재정의 void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt ;
    }

    protected 재정의 void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt ;
    }

    privé void Health_OnHurt(Health h, DamageInfo da)
    {
        시(da. À h). IsFromMainToEnemy())를 사용합니다.
        {
            Log.Debug(« 인스턴트 킬 모드 : Tuer l'ennemi. ») ;
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
# Construire l'ensemble de la solution
dotnet build Docky.Sdk.Sample.slnx

# Construire ce projet uniquement
dotnet build Ducky.InstantKill/
```

6. Activer le mod (exécuter le jeu)

Build déploiera automatiquement le mod dans le catalogue de jeux, l'activera dans l'interface de gestion des mods du jeu et testera l'effet une fois le jeu lancé et le champ de bataille lancé：Lorsque le protagoniste attaque un ennemi, l'ennemi doit mourir instantanément.
