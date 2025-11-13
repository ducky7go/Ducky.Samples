<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.TryHarmony/README.md) | [영어] (../../en/Ducky.TryHarmony/README_en.md) | [도이치] (../../de/Ducky.TryHarmony/README_de.md) | [프랑세] (README_fr.md) | [스페인어] (../../es-ES/Ducky.TryHarmony/README_es.md) | [일본어] (../../ja/Ducky.TryHarmony/README_ja.md) | [한국어] (../../ko/Ducky.TryHarmony/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.TryHarmony/README_pt.md) | [Русский] (../../ru/Ducky.TryHarmony/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.TryHarmony/README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod d'échantillon Ducky.TryHarmony

Brève 설명

Cet exemple illustre un mod qui utilise HarmonyLib pour corriger le code du jeu au moment de l'exécution. L'exemple contient un correctif Harmony simple (correctif de sauvegarde) qui a pour effet d'entraîner l'échec systématique de l'opération de sauvegarde (SaveFilePatch). Inscription et enregistrement des correctifs sur ['Ducky.TryHarmony/ModBehaviour.cs'](Ducky.TryHarmony/ModBehaviour.cs:1) est réalisée.

Avant de commencer, assurez-vous que les exigences de l'environnement de préproduction sont préparées : [Préparation de l'environnement](../docs/Prequirement.md)

1. Présentation du projet

Ce répertoire ('Ducky.TryHarmony/') illustre le mode de patch Harmony：Enregistrez le correctif en appelant PatchAll d'Harmony dans ModEnabled, puis annulez le correctif dans ModDisabled.Rendez-vous dans les réalisations clés：

- ['Ducky.TryHarmony/ModBehaviour.cs'] (Ducky.TryHarmony/ModBehaviour.cs:1)
- ['Ducky.TryHarmony/SaveFilePatch.cs'] (Ducky.TryHarmony/SaveFilePatch.cs:1)
- Documents de projet：['Ducky.TryHarmony/Ducky.TryHarmony.csproj'] (Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. Activer Harmony dans csproj

Pour utiliser le correctif Harmony, activez la propriété IncludeHarmony dans 'Ducky.TryHarmony.csproj'. 파 예：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>액티퍼</Nullable>
    <LangVersion>아페르수</LangVersion>
    <ImplicitUsings>브라이</ImplicitUsings>
    <ModName>덕키.트라이하모니</ModName>
    <IncludeHarmony>브라이</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. 파일 패치 저장

La fonction principale de 'SaveFilePatch' est de faire échouer l'opération de sauvegarde de manière cohérente, ce qui facilite la démonstration de l'effet de correctif et du processus de gestion des erreurs. Cet exemple de correctif intercepte la méthode de sauvegarde associée et renvoie un échec (voir ['Ducky.TryHarmony/SaveFilePatch.cs'](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. Fonctionnement et tests

- Construire le projet：

```bash
dotnet 빌드 Ducky.TryHarmony/
```

- Activer les mods (déployer les versions dans le catalogue de mods du jeu et les activer dans le jeu)
- Toute tentative de sauvegarde dans le jeu entraîne un « échec de la sauvegarde », indiquant que le correctif est en vigueur.

5. Considérations courantes

- Vérifiez que 'IncludeHarmony' est défini sur 'true', sinon le code lié à Harmony ne fonctionnera pas.
- Lors du débogage d'un patch, vous pouvez ajouter un log (en utilisant Ducky.Sdk.Logging.Log) à 'ModBehaviour' pour vérifier que 'PatchAll()'/'UnpatchAll()' est appelé.
