var n = argument0;

// Verify 'N' is a Number
if(string(real(n)) == string(n))
{
    // Sall good, do shit here!
    if(real(n) < 0)
    {
        n = 0;
    }
    else
    if(real(n) > 65535)
    {
        n = 65535;
    }
    else
    {
        n = real(n);
    }
    
    connectPort = n;
}
else
{
    // Nope! Catch the error, quick!
    if(!instance_exists(obj_Message_Generic_NoOptions)) 
    { 
        with(instance_create(0,0,obj_Message_Generic_NoOptions))
        {
            str_Title = "POSSIBLE PORT PROBLEM";
            str_Info  = "Yo, you might wanna change your port number to
                        #something that the server actually understands.
                        #Try something between 1024 and 65535.";
            state = "None"; 
        }
    }
}



