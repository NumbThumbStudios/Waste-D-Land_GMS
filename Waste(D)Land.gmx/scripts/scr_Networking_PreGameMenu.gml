var b = buffer_read(argument0, buffer_string);

switch(b)
{
    case "My Dice Roll": // To Server, From Client
        // Read the Clients Roll
        var roll = buffer_read(argument0, buffer_u8);
        
        // Gather client ID
        var sock = ds_map_find_value(async_load, "id");

        // Send all other clients this data
        for(var i = 0; i < ds_list_size(socketList); i ++)
        {
            buffer_seek(buffer, buffer_seek_start, 0);
            buffer_write(buffer, buffer_string, "PreGame - To Client");
            buffer_write(buffer, buffer_string, "Someone Has Rolled");
            buffer_write(buffer, buffer_string, string(sock));
            buffer_write(buffer, buffer_string, string(roll));
            network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
        }
        
        // Add players roll to the map
        ds_map_add(map_PreGame_InitialRolls, real(sock), real(roll));
        //ds_list_add(list_PreGame_InitialRolls, real(roll));
        ds_list_add(list_PreGame_InitialRolls, real(roll));
        
        // Check if all players have rolled
        if(ds_map_size(map_PreGame_InitialRolls) == ds_list_size(socketList))
        {
            scr_Build_InitialGameSettings();
            
            // Send all clients their position in the turn queue
            /*for(var i = 0; i < ds_list_size(socketList); i ++)
            {
                var sock = ds_list_find_value(list_PlayersTurn,i);
                
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_string, "PreGame - To Client");
                buffer_write(buffer, buffer_string, "Show Me My Position In The Turn Queue");
                buffer_write(buffer, buffer_string, string(i));
                network_send_packet(ds_list_find_value(socketList, i), buffer, buffer_tell(buffer));
            }*/
            
            with(obj_Menu_PreStage_Controller) { alarm[8] = room_speed * 2; }
        }
    break;
    
    case "Someone Has Rolled":
        var someone = buffer_read(argument0, buffer_string);
        var roll    = buffer_read(argument0, buffer_string);
        
        var character = ds_map_find_value(map_PreGame_Characters, real(someone));
        with(character)
        {
            state = "Jump";
            image_index = 0;
            myDice.currentRoll = real(roll);
        }
    break;
    
    case "Show Me My Position In The Turn Queue":
        var position = buffer_read(argument0, buffer_string);
        
        with(instance_create(view_xview[0]+view_wview[0]/2,view_yview[0]+view_hview[0]/2,obj_Menu_PreStage_Positions))
        {
            image_index = real(position);
        }
    break;
    
    case "Create Screen Fade":
        var fade = instance_create(0,0,obj_Fade_To_Black);
    break;
    
    case "Load Game Room":
        // Send all clients to the Game!
        room_goto(currentStage);
        
        // Tell the Server to create the initial players!
        if(instance_exists(obj_Server))
        {
            with(obj_Client)
            {
                buffer_seek(buffer, buffer_seek_start, 0);
                buffer_write(buffer, buffer_string, "GameOn - To Server");
                buffer_write(buffer, buffer_string, "Create Players On Map - Server");
                network_send_packet(client, buffer, buffer_tell(buffer));
            }
        }
    break;
}
