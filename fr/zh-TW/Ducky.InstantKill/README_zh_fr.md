<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.InstantKill/README.md) | [Traduction] (../../en/Ducky.InstantKill/README_en.md) | [Deutsch] (../../de/Ducky.InstantKill/README_de.md) | [English] (../../fr/Ducky.InstantKill/README_fr.md) | [Español] (../../es-ES/Ducky.InstantKill/README_es.md) | [Japonais] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Português] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Chinois traditionnel] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod d’exemple Ducky.InstantKill

簡要說明

Cet exemple implémente un mod simple qui tue le protagoniste lorsqu’il attaque un ennemi.Après l’activation, lorsqu’un événement de blessure se produit, si la source des dégâts est le protagoniste, il infligera des dégâts élevés à la cible et la tuera instantanément.Pour l’implémentation, voir ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs :1).

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

Cet annuaire ('Ducky. InstantKill/') fait une démonstration du mode Mod à projet unique：Tout le code et les ressources sont placés dans le même projet, et la classe d’entrée hérite de 'ModBehaviourBase', voir ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs :1).

2. 初始化專案

- Clonez l’entrepôt et ouvrez 'Ducky.InstantKill/'.
- Recommandé en ". CSPROJ：

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

3. 安裝並配置 Ducky.Sdk

推薦通過 NuGet 添加 SDK：

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

La classe entry doit hériter de 'ModBehaviourBase' et implémenter les méthodes de cycle de vie 'ModEnabled()' et 'ModDisabled()'.Cet exemple enregistre le processeur sur l’événement « OnHurt », qui inflige une grande quantité de dégâts à la cible lorsque les dégâts proviennent du personnage principal.

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

常用構建命令：

```bash
# Construire l’ensemble de la solution
dotnet build Docky.Sdk.Sample.slnx

# Construire ce projet uniquement
dotnet build Ducky.InstantKill/
```

6. 開啟 Mod（執行遊戲）

Une fois que la build a déployé automatiquement le mod dans le répertoire du jeu, le mod est activé dans l’interface de gestion du mod de jeu, et l’effet peut être testé après l’entrée du jeu sur la scène du champ de bataille：Lorsque le protagoniste attaque l’ennemi, celui-ci doit mourir instantanément.
