using Duckov.Buffs;
using Duckov.Utilities;
using Ducky.Sdk.Contracts;
using Ducky.Sdk.GameApis;
using Ducky.Sdk.ModBehaviours;
using Ducky.Sdk.Utils;
using Serilog;
using Log = Ducky.Sdk.Logging.Log;

namespace Ducky.TryHarmony;

public class ModBehaviour : ModBehaviourBase
{
    private HarmonyLib.Harmony _harmony = null!;
    private int _buffId;

    protected override void ModEnabled()
    {
        var executingAssembly = System.Reflection.Assembly.GetExecutingAssembly();
        var logFolder = Path.Combine(Path.GetDirectoryName(executingAssembly.Location));
        Serilog.Log.Logger = new Serilog.LoggerConfiguration()
            .MinimumLevel.Debug()
            .WriteTo.File(Path.Combine(logFolder, "Ducky.TryHarmony.log"), rollingInterval: RollingInterval.Day)
            .CreateLogger();

        var modName = Helper.GetModName();
        var harmony = new HarmonyLib.Harmony(modName);
        harmony.PatchAll();
        _harmony = harmony;

        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            buff.SetDisplayName(LK.UI.DoNothingBuffName)
                .SetDescription(LK.UI.DoNothingBuffDescription)
                .SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                .SetLimitedLifeTime(true)
                .SetTotalLifeTime(60)
                .SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        Log.Info("{ModName} Mod Enabled", modName);

        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    private void SceneLoader_onAfterSceneInitialize(SceneLoadingContext obj)
    {
        if (obj.sceneName == GameplayDataSettings.SceneManagement.BaseScene.Name)
        {
            var main = LevelManager.Instance.MainCharacter;
            if (main != null)
            {
                main.AddBuff(Contract.Buffs.CreateBuffInstance(_buffId));
            }
        }
    }

    protected override void ModDisabled()
    {
        _harmony.UnpatchAll();
        var modName = Helper.GetModName();
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
        Log.Info("{ModName} Mod Disabled", modName);
    }
}

public class DoNothingBuff : Buff
{
    protected override void OnNotifiedOutOfTime()
    {
        base.OnNotifiedOutOfTime();
        Log.Info("DoNothingBuff time out");
    }
}
