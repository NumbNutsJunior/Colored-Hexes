
// Author: Pizza Man
// File: fn_initColoredHexes.sqf
// Description: Draw group indicators with a custom color.

// Draw handler
addMissionEventHandler ["Draw3D", {

	// Init
	private _group = group player;
	private _leader = leader _group;
	private _hexIcon = "\A3\ui_f\data\igui\cfg\cursors\select_ca.paa";
	private _leaderIcon = "\A3\ui_f\data\igui\cfg\cursors\leader_ca.paa";

	// Figure color
	private _color = ["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet;
	if !(pizza_colored_hexes_enabled) then {_color = [1,1,1,1]};
	_color set [3, 0.75];

	// Vehicle cache
	private _vehicles = [];

	{
	
		// Init
		private _unit = _x;
		private _unitVehicle = vehicle _unit;
		private _unitInVehicle = !(_unit isEqualTo _unitVehicle);

		// Don't draw on player
		if !(_unitVehicle isEqualTo (vehicle player)) then {

			// Check for any duplicate vehicles
			if (((_unitInVehicle) && !(_unitVehicle in _vehicles)) || !(_unitInVehicle)) then {

				// Add unit's vehicle to vehicle cache
				if (_unitInVehicle) then {_vehicles pushBack _unitVehicle};

				// Figure position
				private _selection = if (_unitInVehicle) then {"zamerny"} else {"spine3"}; // Azeh & Dedmen
				private _position = _unitVehicle modelToWorldVisual (_unitVehicle selectionPosition [_selection, "Memory"]);

				// Draw hex icon
				drawIcon3D [_hexIcon, _color, _position, 1, 1, 0, "", 2];
				if ((_leader in (crew _unitVehicle)) && (alive _leader)) then {drawIcon3D [_leaderIcon, _color, _position, 1, 1, 0, "", 2]};
			};
		};
	} forEach (units _group);
}];
