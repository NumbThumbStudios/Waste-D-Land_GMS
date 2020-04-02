var socket = ds_map_find_value(async_load, "socket");
ds_list_add(socketList, socket);

// Send connecting player their Socket ID
buffer_seek(buffer, buffer_seek_start, 0);
buffer_write(buffer, buffer_string, "To Client");
buffer_write(buffer, buffer_string, "My Socket ID");
buffer_write(buffer, buffer_string, string(socket));
network_send_packet(socket, buffer, buffer_tell(buffer));


