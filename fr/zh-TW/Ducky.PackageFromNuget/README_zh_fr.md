<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.PackageFromNuget/README.md) | [Traduction] (../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch] (../../de/Ducky.PackageFromNuget/README_de.md) | [English] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japonais] (../../ja/Ducky.PackageFromNuget/README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Chinois traditionnel] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget exemple de mod

簡要說明

Cet exemple montre comment utiliser des packages NuGet tiers dans Mod (en utilisant YamlDotNet comme exemple), y compris la gestion des dépendances, l’accès aux fichiers de ressources et le déploiement de l’empaquetage des dépendances.

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

## 1. Présentation du projet

Ce répertoire (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) montre comment étendre les fonctionnalités des mods：

- ✅ Présentation des packages NuGet tiers
- ✅ Analyse des données à l’aide de bibliothèques externes (YAML)
- ✅ Accéder au fichier de ressources mod
- ✅ Gérer automatiquement l’empaquetage des dépendances

**Exemples de scénarios：** Utilisez la bibliothèque YamlDotNet pour lire et résoudre les profils YAML dans le dossier de ressources Mod.

## 2. Structure du projet

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Configuration du projet
├── ModBehaviour.cs # Entrée du mod
"├── README.md
└── actifs/
    ├── info.ini # Métadonnées du mod
    ├── preview.png # Aperçu de l’image
    └── nice.yml # Exemple de fichier YAML
```

## 3. Configuration du projet

['ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>Activer</Nullable>
    <LangVersion>Aperçu</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>tout</PrivateAssets>
      <IncludeAssets>Duree; construire; indigène; contentfiles ; Analyseurs; construiretransitive</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

**Points clés：**

- Le SDK utilise « PrivateAssets » pour éviter l’empaquetage à la sortie
- La bibliothèque tierce (YamlDotNet) sera automatiquement empaquetée dans le répertoire de sortie Mod

## 4. Ajouter le package NuGet

### Méthode 1：Utilisation de l’interface de ligne de commande (recommandé)

```bash
cd Ducky.PackageFromNuget
dotnet ajouter paquet YamlDotNet
```

### Méthode 2：Modifier manuellement .csproj

Dans '<ItemGroup>» a ajouté：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Méthode 3：Utiliser Visual Studio

1. Faites un clic droit sur le projet → Gérer les packages NuGet
2. Recherchez « YamlDotNet »
3. Cliquez sur « Installer »

## 5) Exemples de mise en œuvre

### Fichier de ressources

['actifs/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader :
  title : « Belle configuration YAML »
  description : « Ceci est une démonstration de chargement de YAML à partir du dossier assets d’un mod »
```

### Classe d’entrée de gamme du mod

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
à l’aide de Ducky.Sdk.Logging ;
en utilisant Ducky.Sdk.ModBehaviours ;
en utilisant YamlDotNet.Serialization ;
en utilisant YamlDotNet.Serialization.NamingConventions ;

espace de noms Ducky.PackageFromNuget ;

classe publique ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Récupère le répertoire où se trouve l’assembly mod
        var dir = Chemin.GetDirectoryName(typeof(ModBehaviour). Assembly.Location) !;
        var ymlPath = Path.Combine(dir, « nice.yml ») ;

        if (Fichier.Existe(ymlPath))
        {
            Log.Info(« Trouvé nice.yml : ») ;
            
            Utiliser YamlDotNet pour désérialiser les fichiers YAML
            var deserializer = nouveau DeserializerBuilder()
                . WithNamingConvention(CamelCaseNamingConvention.Instance)
                . Build() ;

            var ymlContent = Fichier.ReadAllText(ymlPath) ;
            var niceData = désérialiseur. Désérialiser<NiceData>(ymlContent) ;
            
            Log.Info($"Titre : {niceData.NiceHeader.Title}");
            Log.Info($"La description : {niceData.NiceHeader.Description}");
        }
        autre
        {
            Log.Warn(« nice.yml pas trouvé ! ») ;
        }
    }

    protected override void ModDisabled()
    {
        Nettoyer les ressources (si nécessaire)
    }
}

Classe de modèle de données
classe publique NiceData
{
    public NiceDateHeader NiceHeader { get ; poser; } = nouveau() ;

    classe publique NiceDateHeader
    {
        public string Title { get ; poser; } = chaîne. Vide;
        public string Description { get ; poser; } = chaîne. Vide;
    }
}
```

## 6. Accès aux archives de ressources

### Obtenir le catalogue de mods

```csharp
Méthode 1：Passez l’emplacement de montage (recommandé)
var modDir = Chemin.GetDirectoryName(typeof(ModBehaviour). Assembly.Location) !;
```

### Accéder au fichier de ressources

```csharp
assets/ sera copié dans le répertoire racine du répertoire de sortie du mod
var configPath = Path.Combine(modDir, « nice.yml ») ;
var content = Fichier.ReadAllText(configPath) ;
```

**Traitement automatique du SDK：**

- ✅ Copier la DLL d’un package NuGet tiers
- ✅ Copiez le fichier de ressources dans le répertoire de sortie
- ✅ Déployer dans le répertoire Game Mods

## 7. Activer les mods

Une fois la construction réussie, activez le mod dans l’interface de gestion des mods du jeu：

1. Lancer le jeu
2. Entrez dans l’interface de gestion des mods
3. Trouvez « Ducky.PackageFromNuget »
4. Cliquez sur Activer
5. En regardant les journaux de jeu, vous devriez être en mesure de voir le contenu YAML analysé

## 8) Bonnes pratiques

### ✅ Choisissez la bonne bibliothèque

- Préférez les bibliothèques compatibles avec .NET Standard 2.0/2.1
- Évitez d’utiliser des bibliothèques spécifiques à une plate-forme
- Vérifiez si l’arborescence des dépendances de la bibliothèque est complexe

### ✅ Gérer les versions dépendantes

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Exemples pertinents

- [Ducky.SingleProject] (.. /Ducky.SingleProject/README.md) - La structure sous-jacente du projet
- [Ducky.EntranceMod] (.. /Ducky.EntranceMod/README.md) - Architecture multi-niveaux (si vous avez besoin de partager des bibliothèques tierces)
- [Document de préparation environnementale] (../docs/Prequirement.md)

## 10. Résumé

L’utilisation d’un package NuGet tiers peut：

- ✅ Étendez rapidement les fonctions du mod
- ✅ Eviter de réinventer la roue
- ✅ Utiliser une solution mature et stable
- ✅ Tirez parti des ressources communautaires

**Notes：**

- ⚠️ Assurez-vous que la bibliothèque est compatible avec .NET Standard 2.1
- ⚠️ Être conscient de la taille des dépendances et de l’impact sur les performances
- ⚠️ Bien gérer les conflits de version
- ⚠️ Respectez les licences des bibliothèques tierces
