btc_ropes_deployed = false;
btc_log_hud = false;
btc_lifted = false;

private _heli = vehicle player;

player removeAction btc_lift_action;
player removeAction btc_lift_action_hud;

if !(ropes _heli isEqualTo []) then {
    {
        ropeDestroy _x;
    } forEach ropes _heli;
};

_heli setVariable ["cargo", nil];
