waitUntil {!isNull (findDisplay 46)};

player switchCamera "External";
enableSaving [false, false];
player enableFatigue false;
player allowDamage false;
enableTeamSwitch false;

// Setup configuration
call pizza_fnc_configuration;

// Init colored group indicators
call pizza_fnc_coloredHexes;