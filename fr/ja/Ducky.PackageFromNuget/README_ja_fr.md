<!-- LANG_HEADER_START -->

\| [Chinois simplifié] (../../Ducky.PackageFromNuget/README.md) | [Traduction] (../../en/Ducky.PackageFromNuget/README_en.md) | [Deutsch] (../../de/Ducky.PackageFromNuget/README_de.md) | [English] (../../fr/Ducky.PackageFromNuget/README_fr.md) | [Español] (../../es-ES/Ducky.PackageFromNuget/README_es.md) | [Japonais] (README_ja.md) | [한국어] (../../ko/Ducky.PackageFromNuget/README_ko.md) | [Português] (../../pt-PT/Ducky.PackageFromNuget/README_pt.md) | [Русский] (../../ru/Ducky.PackageFromNuget/README_ru.md) | [Chinois traditionnel] (../../zh-TW/Ducky.PackageFromNuget/README_zh.md) |

<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget サンプル MOD

簡単な説明

Cet exemple montre comment utiliser des packages NuGet tiers dans des mods, en utilisant YamlDotNet comme exemple, comme la gestion des dépendances, l’accès aux fichiers de ressources et le déploiement de packages de dépendances.

開始する前に、実稼働前の環境要件が準備されていることを確認してください: [環境の準備](../docs/Prequirement.md)

## 1. プロジェクト紹介

このディレクトリ (['Ducky.PackageFromNuget/'](Ducky.PackageFromNuget/)) montre comment étendre les fonctionnalités des mods：

- ✅ Présentation des packages NuGet tiers
- ✅ Analyse des données à l’aide de bibliothèques externes (YAML)
- ✅ Mod リソース ファイルにアクセスする
- ✅ Gestion automatique des packages de dépendances

Exemple de scénario：\*\* Utilisez la bibliothèque YamlDotNet pour lire et analyser le fichier de configuration YAML dans le dossier Mod Resources.

## 2. プロジェクト構造

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj # Configuration du projet
« ModBehaviour.cs #モードエントリークラス
"├── README.md
└── アセット/
    "├── info.ini #モードメタ情報
    "├── preview.png #プレビュー画像
    └── nice.yml # サンプルYAMLファイル
```

## 3. Structure du projet

['ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj'] (Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>ネットスタンダード2.1</TargetFramework>
    <Nullable>エネーブル</Nullable>
    <LangVersion>プレビュー</LangVersion>
    <ImplicitUsings>vrai</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>すべての</PrivateAssets>
      <IncludeAssets>course; Construire; ネイティブ; contentファイル ; アナライザー; Construction transitionnelle</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

キーポイント：\*\*

- Le SDK utilise « PrivateAssets » pour éviter l’empaquetage dans la sortie
- Les bibliothèques tierces (YamlDotNet) sont automatiquement empaquetées dans le répertoire de sortie du mod

## 4. Ajouter un package NuGet

### Méthode 1：Utiliser l’interface de ligne de commande (recommandé)

```bash
cd Ducky.PackageFromNuget
dotnet ajouter paquet YamlDotNet
```

### Méthode 2：Modifier manuellement le fichier .csproj

で '<ItemGroup>» a été ajouté.：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### Méthode 3：Utiliser Visual Studio

1. Faites un clic droit sur le projet → gérer les packages NuGet
2. Recherchez « YamlDotNet »
3. 「インストール」をクリックします

## 5) Exemples de mise en œuvre

### リソースファイル

['actif/nice.yml'] (Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader です。
  title : « Belle configuration YAML »
  description : « これは、MOD の assets フォルダーから YAML をロードするデモンストレーションです »
```

### モードエントリークラス

['Ducky.PackageFromNuget/ModBehaviour.cs'] (Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
Utilisez ducky.Sdk.Logging.
Ducky.Sdk.ModComportements.
YamlDotNet.Serialization.
Utilisez YamlDotNet.Serialization.NamingConventions.

espace de noms Ducky.PackageFromNuget ;

パブリッククラス ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Récupère le répertoire où se trouve l’assembly mod
        var dir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location) !;
        var ymlPath = Path.Combine(ディレクトリ, « nice.yml ») ;

        if (Fichier.Existe(ymlPath))
        {
            Log.Info(« Trouvé nice.yml : ») ;
            
            Utiliser YamlDotNet pour désérialiser les fichiers YAML
            var deserializer = nouveau DeserializerBuilder()
                . Conventions de nommage (conventions de nommage des cas Camel.
                . ビルド();

            var ymlContent = Fichier.ReadAllText(ymlPath) ;
            var niceData = デシリアライザー。 Désérialisation<NiceData>(ymlコンテンツ) ;
            
            Log.Info($"タイトル : {niceData.NiceHeader.Title}");
            Log.Info($" Description: {niceData.NiceHeader.Description}");
        }
        Sinon
        {
            Log.Warn(« nice.yml pas trouvé ! ») ;
        }
    }

    protected override void ModDisabled()
    {
        Nettoyer les ressources (si nécessaire)
    }
}

データモデルクラス
public クラス NiceData
{
    public NiceDateHeader NiceHeader { get ; セット; } = nouveau() ;

    パブリック・クラス NiceDateHeader
    {
        public string Title { get ; セット; } = chaîne. Vide;
        chaîne publique expliquée { get ; } セット; } = chaîne. Vide;
    }
}
```

## 6. リソースファイルへのアクセス

### Obtenir le catalogue de mods

```csharp
Méthode 1：Par lieu d’assemblage (recommandé)
var modDir = Path.GetDirectoryName(typeof(ModBehaviour) です。 Assembly.Location) !;
```

### リソースファイルにアクセスする

```csharp
Le répertoire assets/ est copié dans le répertoire racine du répertoire de sortie Mod
var configPath = Path.Combine(modDir, « nice.yml ») ;
var content = Fichier.ReadAllText(configPath) ;
```

**SDK Automatique：**

- ✅ サード パーティの NuGet パッケージの DLL をコピーする
- ✅ Copiez le fichier de ressources dans le répertoire de sortie
- ✅ ゲーム mods ディレクトリにデプロイする

## 7. Activer les mods

Une fois la construction réussie, activez le mod dans l’interface de gestion des mods du jeu：

1. Lancer le jeu
2. Aller à l’interface de gestion des mods
3. Recherchez « Ducky.PackageFromNuget ».
4. Cliquez sur Activer
5. Si vous vérifiez les journaux de jeu, vous verrez le contenu du YAML analysé

## 8) ベストプラクティス

### ✅ Choisissez la bonne bibliothèque

- Privilégiez les bibliothèques compatibles avec .NET Standard 2.0/2.1
- Évitez d’utiliser des bibliothèques spécifiques à une plate-forme
- Vérifiez si l’arborescence des dépendances de la bibliothèque est complexe

### ✅ Gestion des versions dépendantes

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. Affaire connexe

- [ダッキー・シングルプロジェクト] (../Ducky.SingleProject/README.md) - structure de base du projet
- [ダッキー・エントランス・モッド] (.. /Ducky.EntranceMod/README.md - Architecture à plusieurs niveaux (si vous avez besoin de partager des bibliothèques tierces)
- [環境準備ドキュメント](../docs/Prequirement.md)

## 10. プロット

Lors de l’utilisation d’un package NuGet tiers,：

- ✅ Étendez rapidement les fonctionnalités du mod
- ✅ Eviter de réinventer la roue
- ✅ Utiliser des solutions éprouvées et stables
- ✅ Tirer parti des ressources communautaires

**Note：**

- ⚠️ Assurez-vous que votre bibliothèque est compatible avec la norme .NET 2.1
- ⚠️ Être conscient de la taille des dépendances et de leur impact sur les performances
- ⚠️ Gérer les conflits de version de manière appropriée
- ⚠️ Respectez les licences de bibliothèques tierces
