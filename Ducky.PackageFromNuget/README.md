<!-- LANG_HEADER_START -->
| [简体中文](README.md) | 
<!-- LANG_HEADER_END -->

# Ducky.PackageFromNuget 示例 Mod

简要说明

本示例展示如何在 Mod 中使用第三方 NuGet 包（以 YamlDotNet 为例），包括依赖管理、资源文件访问和依赖打包部署。

开始之前，请确保前置环境要求已准备: [环境准备](../docs/Prequirement.md)

## 1. 项目简介

本目录（[`Ducky.PackageFromNuget/`](Ducky.PackageFromNuget/)）演示如何扩展 Mod 的功能：

- ✅ 引入第三方 NuGet 包
- ✅ 使用外部库解析数据（YAML）
- ✅ 访问 Mod 资源文件
- ✅ 自动处理依赖打包

**示例场景：** 使用 YamlDotNet 库读取并解析 Mod 资源文件夹中的 YAML 配置文件。

## 2. 项目结构

```
Ducky.PackageFromNuget/
├── Ducky.PackageFromNuget.csproj    # 项目配置
├── ModBehaviour.cs                   # Mod 入口类
├── README.md
└── assets/
    ├── info.ini                      # Mod 元信息
    ├── preview.png                   # 预览图
    └── nice.yml                      # 示例 YAML 文件
```

## 3. 项目配置

[`Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj`](Ducky.PackageFromNuget/Ducky.PackageFromNuget.csproj:1):

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.PackageFromNuget</ModName>
  </PropertyGroup>

  <ItemGroup>
    <!-- Ducky SDK 引用 -->
    <PackageReference Include="Ducky.Sdk" Version="x.y.z">
      <PrivateAssets>all</PrivateAssets>
      <IncludeAssets>runtime; build; native; contentfiles; analyzers; buildtransitive</IncludeAssets>
    </PackageReference>
    
    <!-- 第三方 NuGet 包：YamlDotNet -->
    <PackageReference Include="YamlDotNet" Version="16.3.0" />
  </ItemGroup>
</Project>
```

**关键点：**
- SDK 使用 `PrivateAssets` 避免打包到输出
- 第三方库（YamlDotNet）会自动打包到 Mod 输出目录

## 4. 添加 NuGet 包

### 方法一：使用 CLI（推荐）

```bash
cd Ducky.PackageFromNuget
dotnet add package YamlDotNet
```

### 方法二：手动编辑 .csproj

在 `<ItemGroup>` 中添加：

```xml
<PackageReference Include="YamlDotNet" Version="16.3.0" />
```

### 方法三：使用 Visual Studio

1. 右键项目 → 管理 NuGet 程序包
2. 搜索 "YamlDotNet"
3. 点击"安装"

## 5. 实现示例

### 资源文件

[`assets/nice.yml`](Ducky.PackageFromNuget/assets/nice.yml):

```yaml
niceHeader:
  title: "Nice YAML Configuration"
  description: "This is a demonstration of loading YAML from a mod's assets folder"
```

### Mod 入口类

[`Ducky.PackageFromNuget/ModBehaviour.cs`](Ducky.PackageFromNuget/ModBehaviour.cs:1):

```csharp
using Ducky.Sdk.Logging;
using Ducky.Sdk.ModBehaviours;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Ducky.PackageFromNuget;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        // 获取 Mod 程序集所在目录
        var dir = Path.GetDirectoryName(typeof(ModBehaviour).Assembly.Location)!;
        var ymlPath = Path.Combine(dir, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Found nice.yml:");
            
            // 使用 YamlDotNet 反序列化 YAML 文件
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = deserializer.Deserialize<NiceData>(ymlContent);
            
            Log.Info($"Title: {niceData.NiceHeader.Title}");
            Log.Info($"Description: {niceData.NiceHeader.Description}");
        }
        else
        {
            Log.Warn("nice.yml not found!");
        }
    }

    protected override void ModDisabled()
    {
        // 清理资源（如果需要）
    }
}

// 数据模型类
public class NiceData
{
    public NiceDateHeader NiceHeader { get; set; } = new();

    public class NiceDateHeader
    {
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
    }
}
```

## 6. 资源文件访问

### 获取 Mod 目录

```csharp
// 方法一：通过程序集位置（推荐）
var modDir = Path.GetDirectoryName(typeof(ModBehaviour).Assembly.Location)!;
```

### 访问资源文件

```csharp
// assets/ 目录下的文件会被复制到 Mod 输出目录的根目录
var configPath = Path.Combine(modDir, "nice.yml");
var content = File.ReadAllText(configPath);
```

**SDK 自动处理：**
- ✅ 复制第三方 NuGet 包的 DLL
- ✅ 复制资源文件到输出目录
- ✅ 部署到游戏 Mods 目录

## 7. 启用 Mod

构建成功后，在游戏的 Mod 管理界面启用该 Mod：

1. 启动游戏
2. 进入 Mod 管理界面
3. 找到 "Ducky.PackageFromNuget"
4. 点击启用
5. 查看游戏日志，应该能看到解析的 YAML 内容

## 8. 最佳实践

### ✅ 选择合适的库

- 优先选择 .NET Standard 2.0/2.1 兼容的库
- 避免使用平台特定的库
- 检查库的依赖树是否复杂

### ✅ 管理依赖版本

```xml
<!-- 使用 Directory.Build.props 统一管理版本 -->
<ItemGroup>
  <PackageReference Update="YamlDotNet" Version="16.3.0" />
</ItemGroup>
```

## 9. 相关示例

- [Ducky.SingleProject](../Ducky.SingleProject/README.md) - 基础项目结构
- [Ducky.EntranceMod](../Ducky.EntranceMod/README.md) - 多层架构（如需共享第三方库）
- [环境准备文档](../docs/Prequirement.md)

## 10. 总结

使用第三方 NuGet 包可以：

- ✅ 快速扩展 Mod 功能
- ✅ 避免重复造轮子
- ✅ 使用成熟稳定的解决方案
- ✅ 利用社区资源

**注意事项：**

- ⚠️ 确保库与 .NET Standard 2.1 兼容
- ⚠️ 注意依赖大小和性能影响
- ⚠️ 处理好版本冲突问题
- ⚠️ 遵守第三方库的许可证
