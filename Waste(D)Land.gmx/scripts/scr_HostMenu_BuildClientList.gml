//argument0 = socket
//argument1 = name

var sock = argument0;
var name = argument1;
var xx = 0;

if(room == rm_Menu_ClientLobby) { xx = 480; }

// Add to our list...if we don't already have it!
var index = ds_list_find_index(socketList, sock);
if(index < 0)
{
    //ds_list_add(socketList, argument0);
    ds_list_add(namesList, name);
}

var initY = 120;
var offsetY = 105;

for(var i = 0; i < ds_list_size(socketList); i ++)
{
    clientBG = instance_create(xx,initY+(i*offsetY),obj_HostMenu_Server);
    clientBG.playerName = ds_list_find_value(namesList, i);
    clientBG.sNum = i;
}
