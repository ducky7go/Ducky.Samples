<!-- LANG_HEADER_START -->

\| [중국어 간체자] (../../Ducky.EntranceMod/README.md) | [영어] (../../en/Ducky.EntranceMod/README_en.md) | [도이치] (../../de/Ducky.EntranceMod/README_de.md) | [프랑세] (README_fr.md) | [스페인어] (../../es-ES/Ducky.EntranceMod/README_es.md) | [일본어] (../../ja/Ducky.EntranceMod/README_ja.md) | [한국어] (../../ko/Ducky.EntranceMod/README_ko.md) | [포르투갈어] (../../pt-PT/Ducky.EntranceMod/README_pt.md) | [Русский] (../../ru/Ducky.EntranceMod/README_ru.md) | [중국어 번체자] (../../zh-TW/Ducky.EntranceMod/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.EntranceMod exemple de mod

Brève 설명

Cet exemple montre comment développer des mods à l'aide d'un modèle d'architecture multicouche pour séparer le code partagé en projets de bibliothèque distincts pour la réutilisation du code et La conception modulaire. Convient aux mods volumineux ou aux scénarios où le code doit être partagé entre plusieurs mods.

Avant de commencer, assurez-vous que les exigences de l'environnement de préproduction sont préparées : [Préparation de l'environnement](../docs/Prequirement.md)

## 1. Présentation du projet

Cet exemple se compose de deux éléments：

- **Projet principal de mods** ['Ducky.EntranceMod/'](Ducky.EntranceMod/) - Entrée du mod contenant des fichiers de ressources
- **Projet de bibliothèque publique** ['Ducky.EntranceMod.Common/'](Ducky.EntranceMod.Common/) - Base de code partagée

Ce modèle architectural s'applique：

- Les mods de grande taille nécessitent une gestion hiérarchique
- Plusieurs mods partagent une logique commune
- Développement collaboratif en équipe
- La logique métier doit être testée de manière indépendante

## 2. 프로젝트 구조

```
Ducky.EntranceMod/ # Projet de mod principal
Configuration du projet Ducky.EntranceMod.csproj #
├── ModBehaviour.cs # Classe d'entrée de mod
"├── README.md
└── assets/ # Répertoire du fichier de ressources
    "├── info.ini
    « description.md
    « lkeys.json
    "├── keys.hash.txt
    └── 로케일/
        "├── zh.csv
        └── en.csv

Ducky.EntranceMod.Common/ # Projet de bibliothèque publique
"Ducky.EntranceMod.Common.csproj # Configuration du projet de bibliothèque
├── LK.cs # Partager la clé de localisation
└── MyModBase.cs # Classe de base partagée
```

## 3. Configuration du projet de mod principal

['Ducky.EntranceMod/Ducky.EntranceMod.csproj'] (Ducky.EntranceMod/Ducky.EntranceMod.csproj:1)：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>액티퍼</Nullable>
    <LangVersion>아페르수</LangVersion>
    <ImplicitUsings>브라이</ImplicitUsings>
    <ModName>Ducky.EntranceMod</ModName>
    <!-- 关键：排除 SDK 库，避免重复打包 -->
    <ExcludeSdkLib>브라이</ExcludeSdkLib>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>권유</PrivateAssets>
      <IncludeAssets>듀리; 해석; 인디젠; 콘텐츠 파일 ; 분석가; construire전동사</IncludeAssets>
    </PackageReference>
  </ItemGroup>

  <!-- 引用公共库项目 -->
  <ItemGroup>
    <ProjectReference Include="..\Ducky.EntranceMod.Common\Ducky.EntranceMod.Common.csproj" />
  </ItemGroup>
</Project>
```

**Description de la configuration de base：**

- \\`<ExcludeSdkLib>브라이</ExcludeSdkLib>- Éviter l'empaquetage en double des bibliothèques SDK dans le répertoire de sortie

## 4. Configuration du projet de bibliothèque publique

['Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj'] (Ducky.EntranceMod.Common/Ducky.EntranceMod.Common.csproj:1)：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>넷스탠다드2.1</TargetFramework>
    <Nullable>액티퍼</Nullable>
    <LangVersion>아페르수</LangVersion>
    <ImplicitUsings>브라이</ImplicitUsings>
    <!-- 关键：标记为 Mod 库 -->
    <IsModLib>브라이</IsModLib>
    <!-- 关键：指向主 Mod 项目的 assets 目录 -->
    <AssetsDir>$(SolutionDir)Ducky.EntranceMod/assets</AssetsDir>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>권유</PrivateAssets>
      <IncludeAssets>듀리; 해석; 인디젠; 콘텐츠 파일 ; 분석가; construire전동사</IncludeAssets>
    </PackageReference>
  </ItemGroup>
</Project>
```

**Description de la configuration de base：**

- \\`<IsModLib>브라이</IsModLib>' - Marquez cet élément comme une bibliothèque de mods, le SDK le gérera spécialement
- \\`<AssetsDir>' - Pointe vers le répertoire assets du projet principal afin que la clé de localisation soit générée correctement

## 5. Partagez des exemples de code

### Partager les clés de localisation

['Ducky.EntranceMod.Common/LK.cs'] (Ducky.EntranceMod.Common/LK.cs:1):

```csharp
espace de noms Ducky.EntranceMod.Common ;

public statique classe LK
{
    interface utilisateur de classe statique publique
    {
        공개 const 문자열 NiceWelcomeMessage = « ducky_entrancemod.common.ui.nicewelcomemessage » ;
    }
}
```

### Classes de base partagées

['Ducky.EntranceMod.Common/MyModBase.cs'] (Ducky.EntranceMod.Common/MyModBase.cs:1):

```csharp
en utilisant Ducky.Sdk.ModBehaviours ;

espace de noms Ducky.EntranceMod.Common ;

classe abstraite publique MyModBase : ModBehaviourBase
{
    Une méthode universelle pour tous les partages de mods est accessible à ajouter ici
    protected virtual void LogModInfo(message de chaîne)
    {
        Log.Info($"[{GetType(). 명칭}] {message}");
    }
}
```

### Le mod principal utilise un code partagé

['Ducky.EntranceMod/ModBehaviour.cs'] (Ducky.EntranceMod/ModBehaviour.cs:1):

```csharp
à l'aide de Ducky.Sdk.Logging ;
en utilisant Ducky.EntranceMod.Common ;

espace de noms Ducky.EntranceMod ;

Classe de base partagée d'héritage
classe publique ModBehaviour : MyModBase
{
    protected 재정의 void ModEnabled()
    {
        Log.Info(« 모드 활성화 ») ;
        Utiliser une clé de localisation partagée
        var message = LK. UI. 좋은 환영 메시지 ;
        LogModInfo($"Clé du message de bienvenue : {message}");
    }

    protected 재정의 void ModDisabled()
    {
        Log.Info(« Mod désactivé ») ;
    }
}
```

## 6. Avantages de l'architecture 멀티쿠슈

### ✅ Réutilisation du code

- Plusieurs modérateurs peuvent partager la bibliothèque 'Ducky.EntranceMod.Common'
- Évitez la duplication de code et améliorez la maintenabilité

### ✅ 개념 모듈

- La logique métier est découplée de l'entrée de mod
- 테스트 유니테어 쉬움
- Effacer les dépendances

### ✅ 콜라보레이션 데퀴프

- Différents développeurs peuvent développer différentes couches indépendamment
- Réduire les conflits de code
- Révision facile du code

### ✅ Partage localisé

- Les bibliothèques publiques peuvent définir des clés de localisation partagées
- Tous les mods qui utilisent la bibliothèque sont automatiquement pris en charge pour la traduction

## 7. 프로세스 구조

Le SDK gère automatiquement les dépendances multi-projets：

```bash
# Construire l'ensemble de la solution (recommandé)
dotnet build Docky.Sdk.Sample.slnx

# ou construire le projet principal séparément (ce qui génère automatiquement le projet de bibliothèque dépendant)
dotnet 빌드 Ducky.EntranceMod/
```

Construire des produits：\*\*

- L'ensemble principal du mod + l'ensemble de la bibliothèque publique sont regroupés
- Le fichier de ressources est obtenu à partir du répertoire 'assets/' du projet principal
- Les bibliothèques SDK ne sont pas incluses de manière répétée (car '<ExcludeSdkLib>브라이</ExcludeSdkLib>\\`）

## 8. Activer les mods

Une fois construits, les mods sont automatiquement déployés dans le catalogue de jeux：

```
<游戏目录>/Duckov_Data/StreamingAssets/Mods/Ducky.EntranceMod/
« Ducky.EntranceMod.dll
├── Ducky.EntranceMod.Common.dll
└── 액티프스/
    "├── info.ini
    « lkeys.json
    └── 로케일/</游戏目录>
```

Activez le mod dans l'interface de gestion des mods du jeu.

## 9. Resignations d'extension

### Créer plus de bibliothèques publiques

Pour les projets complexes, vous pouvez créer plusieurs bibliothèques publiques：

```
Ducky.EntranceMod/ # 모드 관리자
Ducky.EntranceMod.Common/ # 코드 유니버스
Ducky.EntranceMod.Gameplay/ # Logique de jeu
Ducky.EntranceMod.UI/ # Lié à l'interface utilisateur
```

## 10. Foire aux 질문

### Q : 푸르쿼이 데피니르 '<ExcludeSdkLib>브라이</ExcludeSdkLib>\\`？

R : Évitez l'empaquetage en double des fichiers de bibliothèque de Ducky.Sdk dans le répertoire de sortie du mod. La bibliothèque SDK existe déjà dans le jeu et n'a pas besoin d'être incluse à nouveau.

### Q: \\`<AssetsDir>Devez-vous le régler ?

R : Pour les projets de bibliothèque publique, si vous incluez une clé de localisation (LK.cs), vous devez définir '<AssetsDir>Pointe vers le répertoire des ressources du projet principal afin que le SDK puisse générer correctement des métadonnées localisées.

### Q : Plusieurs projets de mods principaux peuvent-ils partager la même bibliothèque publique ?

R : 오이 ! C'est l'avantage des architectures multi-niveaux. Plusieurs mods peuvent faire référence au même projet de bibliothèque publique.

### Q : Où la clé de localisation des bibliothèques publiques sera-t-elle générée ?

R : Il générera en '<AssetsDir>', c'est-à-dire le fichier 'lkeys.json' sous le répertoire 'assets/' du projet principal.

## 11. 리소스 연결

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - Référence du mode mono-élément
- [Ducky.Localisation] (.. /Ducky.Localization/README.md- Explication détaillée du système de localisation
- [Documentation de préparation de l'environnement] (.. /docs/Prequirement.md)를 사용합니다.

## 12. 이력서

Le modèle d'architecture multicouche convient：

- ✅ Grands projets de mods
- ✅ Scénarios où la réutilisation du code est nécessaire
- ✅ Développement collaboratif en équipe
- ✅ Développement de mods de série

Si votre mod est relativement simple, il est recommandé de commencer par [Ducky.SingleProject](../Ducky.SingleProject/README.md) à projet unique.
