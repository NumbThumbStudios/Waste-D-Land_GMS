// Find and Remove Socket
var socket = ds_map_find_value(async_load, "socket");
ds_list_delete(socketList, ds_list_find_index(socketList, socket));

// Find and Remove Player Name
var pName = ds_map_find_value(namesMap, socket);
ds_list_delete(namesList, ds_list_find_index(namesList, pName));
ds_map_delete(namesMap, socket);

if(!currentlyInGame) // Rebuild our Game Lobby
{
    scr_HostMenu_DestroyClientList();
    scr_HostMenu_ReBuildClientList();
}
else // Update Players In Game
{
    
}

var clientName = ds_map_find_value(map_Head, socket);
var listOfNames = ds_list_write(namesList);
var listOfSockets = ds_list_write(socketList);
var mapOfNames = ds_map_write(map_Names);
var mapOfHeads = ds_map_write(map_Head);
var mapOfTorsos = ds_map_write(map_Torso);
var mapOfLegs   = ds_map_write(map_Legs);

// Loop through each connected client and send our Compiled Lists
for(var i = 0; i < ds_list_size(socketList); i ++)
{
    buffer_seek(buffer, buffer_seek_start, 0);
    buffer_write(buffer, buffer_string, "To Client");
    buffer_write(buffer, buffer_string, "Lobby Info");
    buffer_write(buffer, buffer_string, listOfSockets);
    buffer_write(buffer, buffer_string, listOfNames);
    buffer_write(buffer, buffer_string, mapOfNames);
    buffer_write(buffer, buffer_string, mapOfHeads);
    buffer_write(buffer, buffer_string, mapOfTorsos);
    buffer_write(buffer, buffer_string, mapOfLegs);
    buffer_write(buffer, buffer_string, string(clientName));
    network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
}








