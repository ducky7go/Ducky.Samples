using Ducky.Sdk.Logging;
using Ducky.Sdk.ModBehaviours;
using YamlDotNet.Serialization;
using YamlDotNet.Serialization.NamingConventions;

namespace Ducky.PackageFromNuget;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        var dir = Path.GetDirectoryName(typeof(ModBehaviour).Assembly.Location)!;
        var ymlPath = Path.Combine(dir, "nice.yml");

        if (File.Exists(ymlPath))
        {
            Log.Info("Found nice.yml:");
            var deserializer = new DeserializerBuilder()
                .WithNamingConvention(CamelCaseNamingConvention.Instance)
                .Build();

            var ymlContent = File.ReadAllText(ymlPath);
            var niceData = deserializer.Deserialize<NiceData>(ymlContent);
            Log.Info($"Title: {niceData.NiceHeader.Title}");
        }
        else
        {
            Log.Warn("nice.yml not found!");
        }
    }

    protected override void ModDisabled()
    {
    }
}

public class NiceData
{
    public NiceDateHeader NiceHeader { get; set; } = new();

    public class NiceDateHeader
    {
        public string Title { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
    }
}
