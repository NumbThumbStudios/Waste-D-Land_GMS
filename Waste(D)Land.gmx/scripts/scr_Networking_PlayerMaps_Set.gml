var sock = argument0; // Player Socket
var xx   = argument1; // Player Position X
var yy   = argument2; // Player Position Y
var cls  = argument3; // Player Current Landing Space
var h    = argument4; // Player Current Head
var t    = argument5; // Player Current Torso
var l    = argument6; // Player Current Legs
var d    = argument7; // Player Current Drink Count

ds_map_add(map_Player_Position_X, sock, xx);
ds_map_add(map_Player_Position_Y, sock, yy);
ds_map_add(map_Player_CurrentLandingSpace, sock, cls);
ds_map_add(map_Player_Head, sock, h);
ds_map_add(map_Player_Torso, sock, t);
ds_map_add(map_Player_Legs, sock, l);
ds_map_add(map_Player_AmountOfDrinksTaken, sock, d);
