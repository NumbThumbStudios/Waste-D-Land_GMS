var initY = 120;
var offsetY = 105;
    
for(var i = 0; i < ds_list_size(serverList); i ++)
{
    serverBG = instance_create(0,initY+(i*offsetY),obj_JoinMenu_Server);
    serverBG.ip = ds_list_find_value(serverList, i);
    serverBG.sName = ds_list_find_value(serverNames, i);
    serverBG.connectedClients = ds_list_find_value(serverClientsConnected, i);
    serverBG.sNum = i;
    
    ds_list_add(serverObjs, serverBG);
}

//show_message("Server List Size: "+string(ds_list_size(serverList)));
