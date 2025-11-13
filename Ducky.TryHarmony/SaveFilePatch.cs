using HarmonyLib;
using Saves;

namespace Ducky.TryHarmony;

[HarmonyPatch(typeof(SavesSystem), "SaveFile")]
internal class SaveFilePatch
{
    [HarmonyPrefix]
    public static bool Prefix()
    {
        return false;
    }
}
