var sock = argument0; // Player Socket
var xx   = argument1; // Player Position X
var yy   = argument2; // Player Position Y
var cls  = argument3; // Player Current Landing Space
var h    = argument4; // Player Current Head
var t    = argument5; // Player Current Torso
var l    = argument6; // Player Current Legs
var d    = argument7; // Player Current Drink Count

if(xx != "NULL") { ds_map_replace(map_Player_Position_X, sock, xx); }
if(yy != "NULL") { ds_map_replace(map_Player_Position_Y, sock, yy); }
if(cls != "NULL") { ds_map_replace(map_Player_CurrentLandingSpace, sock, cls); }
if(h != "NULL") { ds_map_replace(map_Player_Head, sock, h); }
if(t != "NULL") { ds_map_replace(map_Player_Torso, sock, t); }
if(l != "NULL") { ds_map_replace(map_Player_Legs, sock, l); }
if(d != "NULL") { ds_map_replace(map_Player_AmountOfDrinksTaken, sock, d); }

show_debug_message("-----------------------------");
show_debug_message("PLAYER MAPS UPDATED.");
show_debug_message("-----------------------------");
