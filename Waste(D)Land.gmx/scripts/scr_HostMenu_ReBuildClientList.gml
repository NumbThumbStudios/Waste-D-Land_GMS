var initY = 120;
var offsetY = 105;
var xx = 0;

if(room == rm_Menu_ClientLobby) { xx = 480; }

for(var i = 0; i < ds_list_size(socketList); i ++)
{
    clientBG = instance_create(xx,initY+(i*offsetY),obj_HostMenu_Server);
    clientBG.playerName = ds_list_find_value(namesList, i);
    clientBG.sNum = i;
}
