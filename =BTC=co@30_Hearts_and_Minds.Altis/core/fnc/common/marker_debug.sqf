
private ["_units","_color","_marker","_markers","_units_owners","_has_headless"];

_units = allunits select {Alive _x};
if !(btc_marker_debug_cond) exitWith {};

_has_headless = !((entities "HeadlessClient_F") isEqualTo []);

if (_has_headless) then {
	btc_int_ask_data_owner = nil;
	[8,_units,player] remoteExec ["btc_fnc_int_ask_var",2];
	waitUntil {(!(isNil "btc_int_ask_data_owner"))};
	_units_owners = btc_int_ask_data_owner;
};

_markers = [];
{
	_marker = createmarkerLocal [format ["%1", _x], position _x];
	_marker setmarkertypelocal "mil_Dot";
	_marker setMarkerTextLocal format ["%1", typeOf _x];
	if (leader group _x == _x) then {
		_marker setMarkerTextLocal format ["%1 (%2)", typeOf _x,group _x getVariable ["btc_patrol_id",group _x getVariable "btc_traffic_id"]];
	};
	switch (true) do {
		case (side _x == west) : {_color = "ColorBlue"};
		case (side _x == east) : {_color = "ColorRed"};
		case (side _x == independent) : {_color = "ColorGreen"};
		default {_color = "ColorWhite"};
	};
	_marker setmarkerColorlocal _color;
	_marker setMarkerSizeLocal [0.7, 0.7];
	if (_has_headless) then {
		if !((_units_owners select _foreachindex) isEqualTo 2) then	{
			_marker setMarkerAlphaLocal 0.3;
		};
	};
	_markers pushBack _marker;
} foreach _units;
systemChat format ["UNITS:%1 - GROUPS:%2", count allunits, count allgroups];
sleep 1;
{deleteMarker _x} foreach _markers;
[] spawn btc_fnc_marker_debug;