using Duckov.Buffs;
using Duckov.Utilities;
using Ducky.Sdk.Contracts;
using Ducky.Sdk.GameApis;
using Ducky.Sdk.Logging;
using Ducky.Sdk.ModBehaviours;

namespace Ducky.BuffRegistration;

public class ModBehaviour : ModBehaviourBase
{
    private int _buffId;

    protected override void ModEnabled()
    {
        _buffId = Contract.Buffs.RegisterBuff<DoNothingBuff>(buff =>
        {
            buff.SetDisplayName(LK.UI.DoNothingBuffName)
                .SetDescription(LK.UI.DoNothingBuffDescription)
                .SetIcon(GameplayDataSettings.Buffs.BaseBuff.Icon)
                .SetLimitedLifeTime(true)
                .SetTotalLifeTime(60)
                .SetExclusiveTag(Buff.BuffExclusiveTags.NotExclusive);
        });

        SceneLoader.onAfterSceneInitialize += SceneLoader_onAfterSceneInitialize;
    }

    protected override void ModDisabled()
    {
        SceneLoader.onAfterSceneInitialize -= SceneLoader_onAfterSceneInitialize;
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
}

public class DoNothingBuff : Buff
{
    protected override void OnNotifiedOutOfTime()
    {
        base.OnNotifiedOutOfTime();
        Log.Info("DoNothingBuff time out");
    }
}
