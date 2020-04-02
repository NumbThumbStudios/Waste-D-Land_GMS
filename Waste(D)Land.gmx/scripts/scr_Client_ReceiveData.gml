//var buff = ds_map_find_value(async_load, "buffer");
var buff = argument0;
buffer_seek(buff, buffer_seek_start, 0);

var to = buffer_read(buff, buffer_string);
var msg = "";

switch(to)
{
    case "To Client":
        msg = buffer_read(buff, buffer_string);
        
        switch(msg)
        {
            case "My Socket ID":
                var msid = buffer_read(buff, buffer_string);
                socketID = msid;
                mySocketID = socketID;
            break;
            
            case "Lobby Info":
                var strSockets = buffer_read(buff, buffer_string);
                if(strSockets != "") { ds_list_read(socketList, strSockets); }
                
                var strNames = buffer_read(buff, buffer_string);
                if(strNames != "") { ds_list_read(namesList, strNames); }
                
                var strMapNames = buffer_read(buff, buffer_string);
                if(strMapNames != "") { ds_map_read(map_Names, strMapNames); }
                
                var strHeads = buffer_read(buff, buffer_string);
                if(strHeads != "") { ds_map_read(map_Head, strHeads); }
                
                var strTorsos = buffer_read(buff, buffer_string);
                if(strTorsos != "") { ds_map_read(map_Torso, strTorsos); }
                
                var strLegs = buffer_read(buff, buffer_string);
                if(strLegs != "") { ds_map_read(map_Legs, strLegs); }
                
                var newcomer = buffer_read(buff, buffer_string);
                
                if(!currentlyInGame)
                {
                    scr_HostMenu_DestroyClientList();
                    scr_HostMenu_ReBuildClientList();
                }
                
                if(newcomer != "")
                {
                    msg = instance_create(view_xview[0]+view_wview[0]/2,view_yview[0]+view_hview[0]-60,obj_Msg);
                    msg.text = newcomer + " has joined the match!";
                }
            break;
            
            case "Server Ended":
                // Here is where we check/set a new Server host, hopefully...
                if(!instance_exists(obj_Message_Generic_NoOptions)) 
                { 
                    with(instance_create(0,0,obj_Message_Generic_NoOptions))
                    {
                        str_Title = "SERVER ENDED";
                        str_Info  = "The HOST ended the server, thus killing the game. And
                                      #since we don't know shit about Host Migration yet,
                                      #you are shit outta luck for now. Blame their ass
                                      #for this, not ours!";
                        state = "Load Main Menu"; 
                    }
                }
                
                // Old code below
                with(self) instance_destroy();
            break;
            
            case "Client - Start Game":
                currentStage = real(buffer_read(buff, buffer_string));
                fade = instance_create(0,0,obj_Fade_To_Black);
                alarm[8] = room_speed;
                if(instance_exists(obj_Menu_ClientLobby_Button_Back)) { with(obj_Menu_ClientLobby_Button_Back) instance_destroy(); }
                if(instance_exists(obj_Menu_HostMenu_Button_Back)) { with(obj_Menu_HostMenu_Button_Back) instance_destroy(); }
                
                // Send personal player data to server //
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_string, "To Server");
                buffer_write(buffer, buffer_string, "Add Data To Playermap Info");
                buffer_write(buffer, buffer_string, currentHead);
                buffer_write(buffer, buffer_string, currentTorso);
                buffer_write(buffer, buffer_string, currentLegs);
                network_send_packet(client, buffer, buffer_tell(buffer));
            break;
            
            case "Client Disconnected":
                var sock = ds_map_find_value(async_load, "id");
                var name = buffer_read(buff, buffer_string);
                var socketID = buffer_read(buff, buffer_u8);
                
                var inst = ds_map_find_value(clientMap, socketID);
                with(inst) instance_destroy();
                
                ds_map_delete(clientMap, socketID);
                
                if(name != "")
                {
                    msg = instance_create(view_xview[0]+view_wview[0]/2,view_yview[0]+view_hview[0]-60,obj_Msg);
                    msg.text = name+" left the match.";
                }
            break;
        }
    break;
    
    case "PreGame - To Client":
        scr_Networking_PreGameMenu(buff);
    break;
    
    case "GameOn - To Client":
        scr_Networking_GameOn(buff);
    break;
    
    default:
        //show_message("Wrong Thing! This is the Client.");
    break;
}

