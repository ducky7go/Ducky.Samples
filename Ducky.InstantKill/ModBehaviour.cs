using Ducky.Sdk.GameApis;
using Ducky.Sdk.Logging;
using Ducky.Sdk.ModBehaviours;

namespace Ducky.InstantKill;

public class ModBehaviour : ModBehaviourBase
{
    protected override void ModEnabled()
    {
        Health.OnHurt += Health_OnHurt;
    }

    protected override void ModDisabled()
    {
        Health.OnHurt -= Health_OnHurt;
    }

    private void Health_OnHurt(Health h, DamageInfo da)
    {
        if (da.To(h).IsFromMainToEnemy())
        {
            Log.Debug("Instant Kill Mod: Killing enemy.");
            h.Hurt(new DamageInfo(h.TryGetCharacter())
            {
                damageValue = 1000,
            });
        }
    }
}
