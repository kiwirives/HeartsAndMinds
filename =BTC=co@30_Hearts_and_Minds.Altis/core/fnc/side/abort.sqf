if (isServer) then {
    btc_side_aborted = true;
} else {
    [] remoteExec ["btc_fnc_side_abort", 2];
};
