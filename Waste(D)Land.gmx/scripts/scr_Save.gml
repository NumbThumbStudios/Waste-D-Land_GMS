// Open file
ini_open("dat.sav");

// Save Game Information Here

    // Save Player Info
    ini_write_string("player", "name", myName);
    ini_write_real("player", "age", myAge);
    ini_write_real("player", "gender", myGender);
    ini_write_string("player", "head", currentHead);
    ini_write_string("player", "torso", currentTorso);
    ini_write_string("player", "legs", currentLegs);
    
    // Save Network Info
    ini_write_real("network", "port", connectPort);


// Close File
ini_close();
