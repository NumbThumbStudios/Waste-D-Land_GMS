ds_list_clear(list_PlayersTurn);

for(var i = 6; i > 0; i --)
{
    for(var k = ds_map_find_first(map_PreGame_InitialRolls); !is_undefined(k); k = ds_map_find_next(map_PreGame_InitialRolls, k))
    {
        var v = map_PreGame_InitialRolls[? k];
        var sock   = k;
        var roll   = v;
        
        if(roll == i)
        {
            ds_list_add(list_PlayersTurn, sock);
            ds_list_delete(list_PreGame_InitialRolls, i);
        }
    }
}

// DEBUG - PRINT OUR TURN ORDER
exit;
show_debug_message("-- TURN ORDER --------------------");
for(var i = 0; i < ds_list_size(list_PlayersTurn); i ++)
{
    var playerName = ds_map_find_value(namesMap, ds_list_find_value(list_PlayersTurn, i));
    show_debug_message(string(i+1) + ") " + string(playerName));
}





