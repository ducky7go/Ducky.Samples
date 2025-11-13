using Ducky.Sdk.Localizations;
using Ducky.Sdk.Logging;
using Ducky.Sdk.ModBehaviours;

namespace Ducky.Localization;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Log.Info("Ducky.SingleProject Mod Enabled" + L.UI.NiceWelcomeMessage);
    }

    protected override void ModDisabled()
    {
        Log.Info("Ducky.SingleProject Mod Disabled");
    }
}
