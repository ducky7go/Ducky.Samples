<!-- LANG_HEADER_START -->
| [简体中文](README.md) | 
<!-- LANG_HEADER_END -->

# Ducky.TryHarmony 示例 Mod

简要说明

本示例演示使用 HarmonyLib 在运行时修补游戏代码的 Mod。示例包含一个简单的 Harmony 补丁（保存补丁），其效果是使存档操作始终失败（SaveFilePatch）。入口与补丁注册在 [`Ducky.TryHarmony/ModBehaviour.cs`](Ducky.TryHarmony/ModBehaviour.cs:1) 中实现。

开始之前，请确保前置环境要求已准备: [环境准备](../docs/Prequirement.md)

1. 项目简介

本目录（`Ducky.TryHarmony/`）演示 Harmony 补丁模式：通过在 ModEnabled 中调用 Harmony 的 PatchAll 来注册补丁，并在 ModDisabled 中取消补丁。关键实现见：

- [`Ducky.TryHarmony/ModBehaviour.cs`](Ducky.TryHarmony/ModBehaviour.cs:1)
- [`Ducky.TryHarmony/SaveFilePatch.cs`](Ducky.TryHarmony/SaveFilePatch.cs:1)
- 项目文件：[`Ducky.TryHarmony/Ducky.TryHarmony.csproj`](Ducky.TryHarmony/Ducky.TryHarmony.csproj:1)

2. 在 csproj 中启用 Harmony

要使用 Harmony 补丁，请在 `Ducky.TryHarmony.csproj` 中启用 IncludeHarmony 属性。例如：

```xml
<Project Sdk="Microsoft.NET.Sdk">
  <PropertyGroup>
    <TargetFramework>netstandard2.1</TargetFramework>
    <Nullable>enable</Nullable>
    <LangVersion>preview</LangVersion>
    <ImplicitUsings>true</ImplicitUsings>
    <ModName>Ducky.TryHarmony</ModName>
    <IncludeHarmony>true</IncludeHarmony>
  </PropertyGroup>
</Project>
```

3. SaveFilePatch 的行为说明

`SaveFilePatch` 的主要功能是让存档（保存游戏）操作始终失败，便于演示补丁生效及错误处理流程。该补丁示例会拦截保存相关方法并返回失败（详见 [`Ducky.TryHarmony/SaveFilePatch.cs`](Ducky.TryHarmony/SaveFilePatch.cs:1)）。

4. 运行与测试

- 构建项目：
```bash
dotnet build Ducky.TryHarmony/
```
- 启用 Mod（将构建产物部署到游戏 Mod 目录并在游戏内启用）
- 在游戏内尝试保存存档，预期结果是“存档失败”，表明补丁生效。

5. 常见注意事项

- 确认 `IncludeHarmony` 已设置为 `true`，否则 Harmony 相关代码无法正常工作。
- 调试补丁时可在 `ModBehaviour` 中添加日志（使用 `Ducky.Sdk.Logging.Log`）以验证 `PatchAll()`/`UnpatchAll()` 是否被调用。
