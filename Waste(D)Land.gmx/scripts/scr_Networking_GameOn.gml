var b = buffer_read(argument0, buffer_string);

switch(b)
{   
    case "Create Screen Fade":
        var fade = instance_create(0,0,obj_Fade_To_Black);
    break;
    
    case "Create Players On Map - Server": // For the Server to set all players and their positions
        for(var i = 0; i < ds_list_size(list_PlayersTurn); i ++)
        {
            sp = obj_GameBoard_LandingSpace_Start;
            checkSpace = ds_map_find_value(map_Player_CurrentLandingSpace,ds_list_find_value(list_PlayersTurn,i));
            if(checkSpace != "") { sp = checkSpace; show_debug_message("SP: "+string(checkSpace)); } else { show_debug_message("SP is undefined. SP: "+string(checkSpace)); }
    
            var socket = ds_list_find_value(list_PlayersTurn,i);    
            var playerToFollow = noone;    
            var xx = sp.x + sp.sprite_width / 2;
            var yy = sp.y + sp.sprite_height / 2;
            var offsetX = 40;
            var offsetY = 80;
            var playerOffsetY = 10;
            
            if(i == currentPlayersTurn)
            {
                yy = yy-playerOffsetY;
                playerToFollow = ds_list_find_value(list_PlayersTurn,i);
                
                /*with(instance_create(xx,yy-playerOffsetY,obj_PlayerCol))
                {
                    myPlayerID = ds_list_find_value(list_PlayersTurn,i);
                    myPlayerName = ds_map_find_value(obj_Client.map_Names, myPlayerID);
                    camFollowPlayer = self;
                }*/
            }
            else
            {
                var o = i % 2;
                if(o == 0) 
                { 
                    offsetY = 0; 
                } 
                else 
                { 
                    offsetY = 80; 
                }
                
                xx = sp.x+(offsetX*i);
                yy = sp.y+offsetY-playerOffsetY;
                
                /*with(instance_create(sp.x+(offsetX*i),sp.y+offsetY-playerOffsetY,obj_PlayerCol))
                {
                    myPlayerID = ds_list_find_value(list_PlayersTurn,i);
                    myPlayerName = ds_map_find_value(obj_Client.map_Names, myPlayerID);
                }*/
            }
            
            // Update Player Maps
            var h = ds_map_find_value(map_Player_Head, socket);
            var t = ds_map_find_value(map_Player_Torso, socket);
            var l = ds_map_find_value(map_Player_Legs, socket);
            var d = ds_map_find_value(map_Player_AmountOfDrinksTaken, socket);
            scr_Networking_PlayerMaps_Update(socket,xx,yy,sp,h,t,l,d);
            
            for(var k = 0; k < ds_list_size(socketList); k ++)
            {
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_string, "GameOn - To Client");
                buffer_write(buffer, buffer_string, "Create Players On Map - Client");
                buffer_write(buffer, buffer_string, string(ds_list_find_value(list_PlayersTurn,i)));
                buffer_write(buffer, buffer_string, ds_map_find_value(obj_Client.map_Names, ds_list_find_value(list_PlayersTurn,i)));
                buffer_write(buffer, buffer_string, string(ds_map_find_value(map_Player_Position_X, socket)));
                buffer_write(buffer, buffer_string, string(ds_map_find_value(map_Player_Position_Y, socket)));
                buffer_write(buffer, buffer_string, string(ds_map_find_value(map_Player_CurrentLandingSpace, socket)));
                buffer_write(buffer, buffer_string, ds_map_find_value(map_Player_Head, socket));
                buffer_write(buffer, buffer_string, ds_map_find_value(map_Player_Torso, socket));
                buffer_write(buffer, buffer_string, ds_map_find_value(map_Player_Legs, socket));
                buffer_write(buffer, buffer_string, string(ds_map_find_value(map_Player_AmountOfDrinksTaken, socket)));
                buffer_write(buffer, buffer_string, string(playerToFollow));
                network_send_packet(ds_list_find_value(socketList,k),buffer, buffer_tell(buffer));
            }
            
            show_debug_message("XXX: "+string(ds_map_find_value(map_Player_Position_X, ds_list_find_value(list_PlayersTurn,i))));
        }
        
        // Send info to clients!
        /*for(var i = 0; i < ds_list_size(socketList); i ++)
        {
            var player = ds_list_find_value(list_PlayersTurn, i);
            
            for(var k = 0; k < ds_list_size(list_PlayersTurn); k ++)
            {
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_string, "GameOn - To Client");
                buffer_write(buffer, buffer_string, "Create Players On Map - Client");
                buffer_write(buffer, buffer_string, string(ds_map_find_value(map_Player_Position_X, player)));
                buffer_write(buffer, buffer_string, string(ds_map_find_value(map_Player_Position_Y, player)));
                buffer_write(buffer, buffer_string, ds_map_find_value(map_Player_CurrentLandingSpace, player));
                buffer_write(buffer, buffer_string, ds_map_find_value(map_Player_Head, player));
                buffer_write(buffer, buffer_string, ds_map_find_value(map_Player_Torso, player));
                buffer_write(buffer, buffer_string, ds_map_find_value(map_Player_Legs, player));
                buffer_write(buffer, buffer_string, string(ds_map_find_value(map_Player_AmountOfDrinksTaken, player)));
                network_send_packet(ds_list_find_value(socketList,k),buffer, buffer_tell(buffer));
            }
        }*/
    break;
    
    case "Create Players On Map - Client": // For the Clients
        var playerID   = real(buffer_read(argument0, buffer_string));
        var playerName = buffer_read(argument0, buffer_string);
        var xx         = real(buffer_read(argument0, buffer_string));
        var yy         = real(buffer_read(argument0, buffer_string));
        var ls         = real(buffer_read(argument0, buffer_string));
        var hh         = buffer_read(argument0, buffer_string);
        var tt         = buffer_read(argument0, buffer_string);
        var ll         = buffer_read(argument0, buffer_string);
        var dt         = real(buffer_read(argument0, buffer_string));
        var followMe   = real(buffer_read(argument0, buffer_string));
        
        // Print Debug Message
        show_debug_message("---------------------------------");
        show_debug_message("Player ID: "+string(playerID));
        show_debug_message("Player Name: "+string(playerName));
        show_debug_message("XX: "+string(xx));
        show_debug_message("YY: "+string(yy));
        show_debug_message("Landing Space: "+string(ls));
        show_debug_message("Head: "+string(hh));
        show_debug_message("Torso: "+string(tt));
        show_debug_message("Legs: "+string(ll));
        show_debug_message("Drinks Taken: "+string(dt));
        
        with(instance_create(xx, yy, obj_PlayerCol))
        {
            myPlayerID = playerID;
            myPlayerName = playerName;
            myPlayerHead   = hh;
            myPlayerTorso  = tt;
            myPlayerLegs   = ll;
            myPlayerDrinks = dt;
            
            if(myPlayerID == followMe) { camFollowPlayer = self; }
        }
        
        with(obj_GameBoard_LandingSpace_Start)
        {
            image_blend = c_lime;
        }
    break;
}
