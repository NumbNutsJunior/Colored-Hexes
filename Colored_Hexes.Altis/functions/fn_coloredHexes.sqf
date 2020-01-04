
// Author: Pizza Man
// File: fn_coloredHexes.sqf
// Description: Draw group indicators with a custom color.

// Debug
colored_hexes_enabled = if (isNil "colored_hexes_enabled") then {true} else {colored_hexes_enabled};

// Draw handler
addMissionEventHandler ["Draw3D", {

	// Init
	private _group = group player;
	private _leader = leader _group;
	private _hexIcon = "\A3\ui_f\data\igui\cfg\cursors\select_ca.paa";
	private _leaderIcon = "\A3\ui_f\data\igui\cfg\cursors\leader_ca.paa";

	// Figure color
	private _color = if (colored_hexes_enabled) then {

		[

			// Active elements
			profileNamespace getVariable ["IGUI_TEXT_RGB_R", 1],
			profileNamespace getVariable ["IGUI_TEXT_RGB_G", 1],
			profileNamespace getVariable ["IGUI_TEXT_RGB_B", 1],
			profileNamespace getVariable ["IGUI_TEXT_RGB_A", 0.5]
		];
	} else {

		// Default
		[1, 1, 1, 0.5];
	};

	// Figure group selections
	private _allGroupMembers = (units _group) select {(alive _x) && (_x in allUnits) && !(_x isEqualTo player)};
	private _allGroupVehicles = (_allGroupMembers apply {vehicle _x}) select {(alive _x) && !(_x in _allGroupMembers)};

	// Remove vehicle duplicates
	_allGroupVehicles = _allGroupVehicles arrayIntersect _allGroupVehicles;

	// Filter out members inside a vehicle
	_allGroupMembers = _allGroupMembers select {(vehicle _x) isEqualTo _x};

	{

		// Init
		private _unit = _x;

		// Don't draw on player
		if !(_unit isEqualTo (vehicle player)) then {

			// Figure position
			private _selection = if (_unit in _allGroupVehicles) then {"zamerny"} else {"spine3"}; // Azeh & Dedmen
			private _position = _unit modelToWorldVisual (_unit selectionPosition [_selection, "Memory"]);

			// Draw hex icon
			drawIcon3D [_hexIcon, _color, _position, 1, 1, 0, "", 2];
			if ((_leader in (crew _unit)) && (alive _leader)) then {drawIcon3D [_leaderIcon, _color, _position, 1, 1, 0, "", 2]};
		};
	} forEach (_allGroupMembers + _allGroupVehicles);
}];
