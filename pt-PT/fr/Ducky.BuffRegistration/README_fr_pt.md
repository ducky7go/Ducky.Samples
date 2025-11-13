<!-- LANG_HEADER_START -->

\| [简体中文](../../Ducky.BuffRegistration/README.md) | [English](../../en/Ducky.BuffRegistration/README_en.md) | [Deutsch](../../de/Ducky.BuffRegistration/README_de.md) | [Français](README_fr.md) | [Español](../../es-ES/Ducky.BuffRegistration/README_es.md) | [日本語](../../ja/Ducky.BuffRegistration/README_ja.md) | [한국어](../../ko/Ducky.BuffRegistration/README_ko.md) | [Português](../../pt-PT/Ducky.BuffRegistration/README_pt.md) | [Русский](../../ru/Ducky.BuffRegistration/README_ru.md) | [繁體中文](../../zh-TW/Ducky.BuffRegistration/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.BuffRegistration exemple de mod

Brève description

Cet exemple montre comment utiliser Ducky.Sdk pour enregistrer un bonus personnalisé, y compris les clés localisées et les dispositions de ressources.Entrée et implémentation voir ['Ducky.BuffRegistration/ModBehaviour.cs'](Ducky.BuffRegistration/ModBehaviour.cs:1)。

Avant de commencer, assurez-vous que les exigences de l’environnement de préproduction sont préparées : [Préparation de l’environnement](../docs/Prequirement.md)

1. Présentation du projet

Ce répertoire (['Ducky.BuffRegistration/'](Ducky.BuffRegistration/README.md:1Démontre le modèle d’enregistrement des Buffs via Contract.Buffs dans un mod à projet unique.Ce projet contient également des clés de localisation, voir ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。

2. Initialiser le projet

- Clonez le dépôt et ouvrez 'Ducky.BuffRegistration/'.
- Il est recommandé d’inclure au moins .csproj：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.BuffInscription</ModName>
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

4. Enregistrer un buff personnalisé (exemple)

Utilisez Contract.Buffs.RegisterBuff pour enregistrer le Buff et définir le nom d’affichage, la description, l’icône et la durée de vie dans le rappel.exemple：

```csharp
en utilisant Ducky.Sdk ;

classe publique ModBehaviour : ModBehaviourBase
{
    privé int _buffId ;

    protected override void ModEnabled()
    {
        _buffId = Contrat.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            mordu. SetDisplayName(LK. UI. DoNothingBuffName)
                . SetDescription(LK. UI. DoNothingBuffDescription)
                . SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                . SetLimitedLifeTime(true)
                . SetTotalLifeTime(60)
                . SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive) ;
        });

        Écouter l’initialisation de la scène：Accorde automatiquement ce buff au protagoniste lorsqu’il entre dans la base (voir ModBehaviour pour l’implémentation)
        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize ;
    }

    protected override void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize ;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter ;
            if (main != null)
            {
                Créez et ajoutez une instance de Buff enregistrée lorsque vous entrez dans la scène de base
                principal. AddBuff(Contract.Buffs.CreateBuffInstance(_buffId)) ;
            }
        }
    }
}
```

5. localisation

Cet exemple définit une clé de chaîne de caractères au niveau de ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1)。Le fichier de traduction se trouve généralement dans 'assets/locales/' (visible dans le répertoire source), mais attention：Les CSV de traduction, les métadonnées de traduction (« assets/lkeys.json » et les fichiers de validation (« assets/keys.hash.txt ») sont automatiquement collectés et écrits dans le répertoire « assets/ » par l’analyseur/générateur MSBuild du SDK au moment de la compilation.Par conséquent, le flux de travail recommandé est le suivant :：

- Définition ou modification de clés dans le code (recommandé)：Modifier ['Ducky.BuffRegistration/LK.cs'](Ducky.BuffRegistration/LK.cs:1) et compile, et le SDK génère/met à jour les métadonnées de traduction correspondantes.
- Ou modifiez 'assets/locales/ directement localement' localement{lang}.csv » et recompilez pour permettre au SDK d’intégrer les modifications.
- Si vous utilisez la traduction basée sur des fichiers (par exemple, écrire un texte long dans un fichier Markdown), vous pouvez utiliser '[TranslateFile(« md »)]' dans 'LK.cs' ; Le SDK placera le fichier correspondant dans 'assets/locales/{lang}/' et référencez-le en CSV avec le nom du fichier.

Exemple de clé：

- «LK. UI. DoNothingBuffName»
- «LK. UI. DoNothingBuffDescrição»

remarque：Les termes « assets/lkeys.json » et « assets/keys.hash.txt » sont utilisés pour le positionnement au moment de l’exécution et la vérification de l’empaquetage, et la modification manuelle n’est pas recommandée. Pour forcer une actualisation, nettoyez et recompilez le projet.

6. Construire et empaqueter

Commandes de compilation courantes：

```bash
dotnet construir Ducky.BuffRegistration/
```

6. Activer le mod (exécuter le jeu)

La version déploiera automatiquement le mod dans le catalogue de jeux, activera le mod dans l’interface de gestion des mods du jeu et lancera le jeu pour entrer dans la scène de base afin de voir si le protagoniste a reçu un buff personnalisé.
