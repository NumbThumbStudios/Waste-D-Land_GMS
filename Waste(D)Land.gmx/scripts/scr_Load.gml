// Attempt to open save file
if(file_exists("dat.sav"))
{
    show_debug_message("Found save file! Attempting to load data...");
    
    // Open file
    ini_open("dat.sav");
    
    // Load Game Information Here
    
        // Load Player Data
        myName         = ini_read_string("player", "name", "shitbag");
        myAge          = ini_read_real("player", "age", 21);
        myGender       = ini_read_real("player", "gender", 1);
        currentHead    = ini_read_string("player", "head", "Naked");
        currentTorso   = ini_read_string("player", "torso", "Naked");
        currentLegs    = ini_read_string("player", "legs", "Naked");
        
        // Load Network Data
        connectPort = ini_read_real("network", "port", 17420);
    
    // Close File
    ini_close();
}

else

{
    room_goto(rm_Menu_MyProfile);
    //var n = get_string("This looks like your first time playing. \nWhat is your name, stanger? (2-16 characters)", "Stranger");                
    //scr_Validation_MyName(n);
    //scr_Save();
}
