using Ducky.Sdk.ModBehaviours;
using Ducky.Sdk.Utils;

namespace Ducky.TryHarmony;

public class ModBehaviour : ModBehaviourBase
{
    private HarmonyLib.Harmony _harmony = null!;
    private static string HarmonyId => Helper.GetModId();

    protected override void ModEnabled()
    {
        var harmony = new HarmonyLib.Harmony(HarmonyId);
        harmony.PatchAll();
        _harmony = harmony;
    }

    protected override void ModDisabled()
    {
        _harmony.UnpatchAll(HarmonyId);
    }
}
