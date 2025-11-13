<!-- LANG_HEADER_START -->

\| [Chino simplificado] (../../Ducky.InstantKill/README.md) | [Inglés] (../../en/Ducky.InstantKill/README_en.md) | [Deutsch] (../../de/Ducky.InstantKill/README_de.md) | [Français] (../../fr/Ducky.InstantKill/README_fr.md) | [English] (../../es-ES/Ducky.InstantKill/README_es.md) | [Japonés] (../../ja/Ducky.InstantKill/README_ja.md) | [한국어] (../../ko/Ducky.InstantKill/README_ko.md) | [Português] (../../pt-PT/Ducky.InstantKill/README_pt.md) | [Русский] (../../ru/Ducky.InstantKill/README_ru.md) | [Chino tradicional] (README_zh.md) |

<!-- LANG_HEADER_END -->

# Mod de muestra de Ducky.InstantKill

簡要說明

Este ejemplo implementa un mod simple que mata al protagonista cuando ataca a un enemigo.Después de la activación, cuando ocurre un evento de lesión, si la fuente del daño es el protagonista, infligirá un gran daño al objetivo y lo matará instantáneamente.Para la implementación, vea ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

開始之前，請確保前置環境要求已準備： [環境準備]（../docs/Prequirement.md)

1. 項目簡介

Este directorio ('Ducky. InstantKill/') muestra el modo Mod de un solo proyecto：Todo el código y los recursos se colocan en el mismo proyecto, y la clase de entrada hereda 'ModBehaviourBase', consulte ['Ducky.InstantKill/ModBehaviour.cs'](Ducky.InstantKill/ModBehaviour.cs:1).

2. 初始化專案

- Clona el almacén y abre 'Ducky.InstantKill/'.
- Recomendado en ". CSPROJ：

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>estándar de red2.1</TargetFramework>
    <Nullable>habilitar</Nullable>
    <LangVersion>Vista previa</LangVersion>
    <ImplicitUsings>verdadero</ImplicitUsings>
    <!-- ModName 必须项，建议与项目名一致 -->
    <ModName>Ducky.Muerte instantánea</ModName>
    <!-- 通过 Local.props 或此处指定本地游戏路径以便部署 -->
    <!-- <DuckyGamePath>C:\Path\To\Game</DuckyGamePath> -->
  </PropertyGroup>
</Project>
```

3. 安裝並配置 Ducky.Sdk

推薦通過 NuGet 添加 SDK：

```bash
dotnet add package Ducky.Sdk
```

```xml
<ItemGroup>
  <PackageReference Include="Ducky.Sdk" Version="x.y.z">
    <PrivateAssets>todo</PrivateAssets>
    <IncludeAssets>Ejecución; construir; nativo; archivos de contenido; Analizadores; buildtransitive</IncludeAssets>
  </PackageReference>
</ItemGroup>
```

4. Escribir ModBehaviour

La clase de entrada debe heredar 'ModBehaviourBase' e implementar los métodos de ciclo de vida 'ModEnabled()' y 'ModDisabled()'.En este ejemplo se registra el procesador en el evento "OnHurt", que inflige una gran cantidad de daño al objetivo cuando el daño proviene del personaje principal.

Código de ejemplo：

```csharp
usando Ducky.Sdk;
usando Ducky.Sdk.Logging;

espacio de nombres Ducky.InstantKill;

ModBehaviour de clase pública : ModBehaviourBase
{
    anulación protegida void ModEnabled()
    {
        Salud.OnHurt += Health_OnHurt;
    }

    anulación protegida void ModDisabled()
    {
        Salud.OnHurt -= Health_OnHurt;
    }

    privado void Health_OnHurt(Salud h, Información de daños da)
    {
        si (da. Para(h). IsFromMainToEnemy())
        {
            Log.Debug("Mod de muerte instantánea: Matar enemigo.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000,
            });
        }
    }
}
```

5. Ejecutar y empaquetar

常用構建命令：

```bash
# Construir toda la solución
dotnet build Docky.Sdk.Sample.slnx

# Construir solo este proyecto
dotnet build Ducky.InstantKill/
```

6. 開啟 Mod（執行遊戲）

Después de que la compilación implementa automáticamente el mod en el directorio del juego, el mod se habilita en la interfaz de administración de mods del juego y el efecto se puede probar después de que el juego ingrese a la escena del campo de batalla：Cuando el protagonista ataca al enemigo, el enemigo debería morir instantáneamente.
