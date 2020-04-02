var n = argument0;

// Verify 'N' is a Number
if(string(real(n)) == string(n))
{
    // Sall good, do shit here!
    if(real(n) < 16)
    {
        n = 16;
    }
    else
    if(real(n) > 85)
    {
        n = 85;
    }
    else
    {
        n = real(n);
    }
    
    myAge = n;
}
else
{
    // Nope! Catch the error, quick!
    if(!instance_exists(obj_Message_Generic_NoOptions)) 
    { 
        with(instance_create(0,0,obj_Message_Generic_NoOptions))
        {
            str_Title = "IMPOSSIBLE!";
            str_Info  = "You cannot be that age, it's physically impossible.
                        #Get your shit togehter and try again, dumbass!";
            state = "None"; 
        }
    }
}



