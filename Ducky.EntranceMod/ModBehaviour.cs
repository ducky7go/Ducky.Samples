using Ducky.Sdk.ModBehaviours;
using Ducky.Sdk.Logging;

namespace Ducky.EntranceMod;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Log.Info("Mod Enabled");
    }

    protected override void ModDisabled()
    {
        Log.Info("Mod Disabled");
    }
}
