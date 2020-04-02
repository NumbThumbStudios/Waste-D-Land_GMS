//argument0 = name
//argument1 = ip
//argument2 = clients connected
//argument3 = isBusy (Game already started)

/*for(var i = 0; i < ds_list_size(serverList); i ++)
{
    if(argument1 == ds_list_find_value(serverList, i))
    {
        if(argument2 != ds_list_find_value(serverClientsConnected, i))
        {
            ds_list_delete(serverClientsConnected, i);
            ds_list_add(serverClientsConnected, argument2);
            scr_JoinMenu_DestroyServerList();
            scr_JoinMenu_ReBuildServerList();
        }
    }
}*/

// Add to our list...if we don't already have it!
var index = ds_list_find_index(serverList, argument1);

if(index < 0)
{
    ds_list_add(serverClientsConnected, argument2);
    ds_list_add(serverList, argument1);
    ds_list_add(serverNames, argument0);
    
    var initY = 120;
    var offsetY = 105;
    
    serverBG = instance_create(0,initY+((ds_list_size(serverList)-1)*offsetY),obj_JoinMenu_Server);
    serverBG.ip = ds_list_find_value(serverList, (ds_list_size(serverList)-1));
    serverBG.sName = ds_list_find_value(serverNames, (ds_list_size(serverList)-1));
    serverBG.connectedClients = ds_list_find_value(serverClientsConnected, (ds_list_size(serverList)-1));
    serverBG.sNum = (ds_list_size(serverList)-1);
    
    ds_list_add(serverObjs, serverBG);
}
else
{
    var obj = ds_list_find_value(serverObjs, index);
    obj.connectedClients = argument2;
    obj.isBusy = argument3;
}




