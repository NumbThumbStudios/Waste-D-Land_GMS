//var buff = ds_map_find_value(async_load, "buffer");
var buff = argument0;
buffer_seek(buff, buffer_seek_start, 0);

var to = buffer_read(buff, buffer_string);
var msg = "";

switch(to)
{
    case "To Server":
        msg = buffer_read(buff, buffer_string);
        
        switch(msg)
        {
            case "Get Player Info":
                var name  = buffer_read(buff, buffer_string);
                var head  = buffer_read(buff, buffer_string);
                var torso = buffer_read(buff, buffer_string);
                var legs  = buffer_read(buff, buffer_string);
                
                ds_list_add(namesList, name);
                var sock = ds_map_find_value(async_load, "id");
                
                ds_map_add(namesMap, sock, name);
                ds_map_add(map_Names, sock, name);
                ds_map_add(map_Head, sock, head);
                ds_map_add(map_Torso, sock, torso);
                ds_map_add(map_Legs, sock, legs);
                
                if(!currentlyInGame)
                {
                    scr_HostMenu_DestroyClientList();
                    scr_HostMenu_BuildClientList(sock, name);
                }
                
                var listOfNames = ds_list_write(namesList);
                var listOfSockets = ds_list_write(socketList);
                
                var mapOfNames  = ds_map_write(map_Names);
                var mapOfHeads  = ds_map_write(map_Head);
                var mapOfTorsos = ds_map_write(map_Torso);
                var mapOfLegs   = ds_map_write(map_Legs);
                
                for(var i = 0; i < ds_list_size(socketList); i ++)
                {
                    buffer_seek(buffer, buffer_seek_start, 0);
                    buffer_write(buffer, buffer_string, "To Client");
                    buffer_write(buffer, buffer_string, "Lobby Info");
                    buffer_write(buffer, buffer_string, string(listOfSockets));
                    buffer_write(buffer, buffer_string, string(listOfNames));
                    buffer_write(buffer, buffer_string, string(mapOfNames));
                    buffer_write(buffer, buffer_string, string(mapOfHeads));
                    buffer_write(buffer, buffer_string, string(mapOfTorsos));
                    buffer_write(buffer, buffer_string, string(mapOfLegs));
                    buffer_write(buffer, buffer_string, string(name));
                    network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
                }
            break;
            
            case "Server - Start Game":
                for(var i = 0; i < ds_list_size(socketList); i ++)
                {
                    buffer_seek(buffer, buffer_seek_start, 0);
                    buffer_write(buffer, buffer_string, "To Client");
                    buffer_write(buffer, buffer_string, "Client - Start Game");
                    buffer_write(buffer, buffer_string, string(currentStage));
                    network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
                }
                    
                currentlyInGame = true;
                
                //scr_Build_InitialGameSettings();
            break;
            
            case "Create Player":
                var sock = ds_map_find_value(async_load, "id");
                var name = buffer_read(buff, buffer_string);
                var xx = buffer_read(buff, buffer_s32);
                var yy = buffer_read(buff, buffer_s32);
                
                networkPlayer = instance_create(xx,yy,obj_Player_Network);
                networkPlayer.myName = name;
                ds_map_add(clientMap, sock, networkPlayer);
                
                // Send info to all clients
                for(var i = 0; i < ds_list_size(socketList); i ++)
                {
                    var me = ds_list_find_value(socketList, i);
                    
                    if(sock != me)
                    {
                        buffer_seek(buffer, buffer_seek_start, 0);
                        buffer_write(buffer, buffer_string, "To Client");
                        buffer_write(buffer, buffer_string, "Add Player To Game");
                        buffer_write(buffer, buffer_string, name);
                        buffer_write(buffer, buffer_s32, xx);
                        buffer_write(buffer, buffer_s32, yy);
                        buffer_write(buffer, buffer_u8, sock);
                        network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
                    }
                }
            break;
            
            case "Update Player":
                var sock = ds_map_find_value(async_load, "id");
                var xx = buffer_read(buff, buffer_s32);
                var yy = buffer_read(buff, buffer_s32);
                var playerState = buffer_read(buff, buffer_string);
                
                var inst = ds_map_find_value(clientMap, sock);
                with(inst)
                {
                    x = xx;
                    y = yy;
                    state = playerState;
                }
                
                // Send info to all clients
                for(var i = 0; i < ds_list_size(socketList); i ++)
                {
                    var me = ds_list_find_value(socketList, i);
                    
                    if(sock != me)
                    {
                        buffer_seek(buffer, buffer_seek_start, 0);
                        buffer_write(buffer, buffer_string, "To Client");
                        buffer_write(buffer, buffer_string, "Update Network Player");
                        buffer_write(buffer, buffer_s32, xx);
                        buffer_write(buffer, buffer_s32, yy);
                        buffer_write(buffer, buffer_u8, sock);
                        buffer_write(buffer, buffer_string, playerState);
                        network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
                    }
                }
            break;
            
            case "Delete Me":
                var nameToErase = buffer_read(buff, buffer_string);
                var sock = ds_map_find_value(async_load, "id");
                ds_list_delete(socketList, ds_list_find_index(socketList, sock));
                ds_map_delete(map_Names, sock);
                ds_map_delete(map_Head, sock);
                ds_map_delete(map_Torso, sock);
                ds_map_delete(map_Legs, sock);
                
                for(var i = 0; i < ds_list_size(socketList); i ++)
                {   
                    buffer_seek(buffer, buffer_seek_start, 0);
                    buffer_write(buffer, buffer_string, "To Client");
                    buffer_write(buffer, buffer_string, "Client Disconnected");
                    buffer_write(buffer, buffer_string, nameToErase);
                    buffer_write(buffer, buffer_u8, sock);
                    network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
                }
                
                if(nameToErase != "")
                {
                    msg = instance_create(view_xview[0]+view_wview[0]/2,view_yview[0]+view_hview[0]-60,obj_Msg);
                    msg.text = nameToErase+" left the match.";
                }
                
                var inst = ds_map_find_value(clientMap, sock);
                with(inst) instance_destroy();        
            break;
            
            case "Add Data To Playermap Info":
                // Socket
                var sock = ds_map_find_value(async_load, "id");
                
                // head
                var h = buffer_read(buff, buffer_string);
                
                // torso
                var t = buffer_read(buff, buffer_string);
                
                // legs
                var l = buffer_read(buff, buffer_string);
                
                // Call Script to Set Player Map
                scr_Networking_PlayerMaps_Set(sock,0,0,"",h,t,l,0);
            break;
        }
    break;
    
    case "PreGame - To Server":
        scr_Networking_PreGameMenu(buff);
    break;
    
    case "GameOn - To Server":
        scr_Networking_GameOn(buff);
    break;
    
    default:
        //show_message("Wrong Thing! This is the Server.");
    break;
}


