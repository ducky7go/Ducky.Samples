<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.TryHarmony/README.md) | [Traduction] (../../en/Ducky.TryHarmony/README_en.md) | [Deutsch] (../../de/Ducky.TryHarmony/README_de.md) | [English] (../../fr/Ducky.TryHarmony/README_fr.md) | [Español] (../../es-ES/Ducky.TryHarmony/README_es.md) | [Japonais] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [Português] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [Chinois traditionnel] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod d’échantillon Ducky.TryHarmony

簡要說明

Cet exemple illustre l’utilisation d’HarmonyLib pour corriger un mod pour le code du jeu au moment de l’exécution.L’exemple contient un simple correctif Harmony (save patch) qui a pour effet de faire échouer systématiquement l’opération de sauvegarde (SaveFilePatch).L’inscription et l’enregistrement des correctifs sont implémentés dans ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs :1).

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

Ce catalogue ('Ducky. TryHarmony/') illustre le mode de patch Harmony：Enregistrez le correctif en appelant PatchAll d’Harmony dans ModEnabled et annulez le correctif dans ModDisabled.Rendez-vous dans les réalisations clés：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Fiche projet：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Activer Harmony dans csproj

Pour utiliser le correctif Harmony, activez la propriété IncludeHarmony dans 'Ducky.TryHarmony.csproj'.Par exemple：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>vrai</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. SaveFilePatch

La fonction principale de 'SaveFilePatch' est de faire échouer les opérations de sauvegarde (sauvegarde du jeu) de manière constante, ce qui facilite la démonstration de l’effet de correctif et du processus de gestion des erreurs.L’exemple de correctif intercepte la méthode liée à la sauvegarde et renvoie un échec (voir ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs :1)).

4. Fonctionnement et tests

- Construire des projets：

```bash
dotnet build Ducky.TryHarmony/
```

- Ouvrez les mods (déployez les versions dans le catalogue de mods du jeu et ouvrez-les dans le jeu)
- Toute tentative d’enregistrement d’une sauvegarde dans le jeu entraîne l’échec de la sauvegarde, indiquant que le correctif est actif.

5. Précautions courantes

- Vérifiez que 'IncludeHarmony' est défini sur 'true', sinon le code lié à Harmony ne fonctionnera pas correctement.
- Lors du débogage de correctifs, log peut être ajouté à 'ModBehaviour' (en utilisant 'Ducky.Sdk.Logging.Log') pour vérifier que 'PatchAll()'/'UnpatchAll()' est appelé.
