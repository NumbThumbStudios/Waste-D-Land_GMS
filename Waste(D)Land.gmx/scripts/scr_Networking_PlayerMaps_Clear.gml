var sock = argument0; // Player Socket

ds_map_delete(map_Player_Position_X, sock);
ds_map_delete(map_Player_Position_Y, sock);
ds_map_delete(map_Player_CurrentLandingSpace, sock);
ds_map_delete(map_Player_Head, sock);
ds_map_delete(map_Player_Torso, sock);
ds_map_delete(map_Player_Legs, sock);
ds_map_delete(map_Player_AmountOfDrinksTaken, sock);
